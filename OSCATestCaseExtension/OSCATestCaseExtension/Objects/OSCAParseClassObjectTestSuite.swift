//
//  OSCAParseClassObjectTestSuite.swift
//  OSCATestCaseExtension
//
//  Created by Stephan Breidenbach on 19.01.23.
//
#if canImport(XCTest) && canImport(OSCAEssentials)
import Foundation
import XCTest
import OSCAEssentials
import OSCANetworkService
import Combine

/// Generic test suite for `Parse` class objects
/// [based upon](https://qualitycoding.org/wwdc21-unit-testing/)
open class OSCAParseClassObjectTestSuite<ParseObject: OSCAParseClassObject>: XCTestCase {
  public typealias ParseClassPublisher = AnyPublisher<[ParseObject], OSCANetworkError>
  public typealias ParseClassSchemaPublisher = AnyPublisher<[ParseClassSchema], OSCANetworkError>
  
  private var cancellables: Set<AnyCancellable>!
  open var sut: [ParseObject]! = []
  
  override open func setUpWithError() throws {
    try super.setUpWithError()
    // initialize cancellables
    self.cancellables = []
  }// end override func setupWithError
  
  override open func tearDownWithError() throws {
    self.sut = nil
    if !self.cancellables.isEmpty {
      self.cancellables.forEach { $0.cancel() }
      self.cancellables.removeAll()
    }// end if
    try super.tearDownWithError()
  }// end override open func tearDownWithError
  
  open func makeSpecificObject() -> ParseObject? { nil }
  
  open func makeClassRequestResource( baseURL: URL,
                                      parseClass: String,
                                      parameters: [String: CustomStringConvertible],
                                      headers: [String: CustomStringConvertible]) -> OSCAClassRequestResource<ParseObject> {
    let classRequestResource = OSCAClassRequestResource<ParseObject>(baseURL: baseURL,
                                                                     parseClass: parseClass,
                                                                     parameters: parameters,
                                                                     headers: headers)
    return classRequestResource
  }// end open func makeClassRequestResource
  
  open func makeClassSchemaRequestResource( baseURL: URL,
                                            parameters: [String: CustomStringConvertible],
                                            headers: [String: CustomStringConvertible]) -> OSCAClassSchemaRequestResource {
    let classSchemaRequestResource = OSCAClassSchemaRequestResource(baseURL: baseURL,
                                                                    parseClass: ParseObject.parseClassName,
                                                                    parameters: parameters,
                                                                    headers: headers)
    return classSchemaRequestResource
  }// end open func makeClassSchemaRequestResource
  
  
  open func makeParseClassPublisher( networkService: OSCANetworkService,
                                     classRequestResource: OSCAClassRequestResource<ParseObject>) -> ParseClassPublisher {
    
    let publisher = networkService.fetch(classRequestResource)
    return publisher
  }// end open func makeParseClassPublisher
  
  open func makeParseClassSchemaPublisher( networkService: OSCANetworkService,
                                           classSchemaRequestResource: OSCAClassSchemaRequestResource) -> ParseClassSchemaPublisher {
    let publisher = networkService.fetch(classSchemaRequestResource)
    return publisher
  }// end open func makeParseClassSchemaPublisher
  
  /// Is there a file with the `JSON` scheme example data available?
  /// The file name has to match with the test class name: `OSCAXyzTests.json`
  open func testJSONDataAvailable() throws -> Void {
    /// `give`
    
    /// `when`
    let jsonData = self.jsonData
    /// `then`
    XCTAssertNotNil(jsonData,"No json content available!")
  }// end open func testJSONDataAvailable
  
  /// Is it possible to deserialize `JSON` scheme example data to an array of generic `ParseObject` 's?
  open func testDecodingJSONData() throws -> Void {
    /// `give`
    guard let data: Data = self.jsonData else {
      XCTFail("No JSON content available!")
      return
    }// end guard
    /// `when`
    let queryResponse: QueryResponse<ParseObject> = try OSCACoding.jsonDecoder().decode(QueryResponse<ParseObject>.self, from: data)
    /// `then`
    self.sut = queryResponse.results
    XCTAssertTrue(!sut.isEmpty)
    XCTAssertNotNil(sut.first?.objectId, "\(ParseObject.self) object's objectId is nil!")
    XCTAssertNotNil(sut.first?.createdAt, "\(ParseObject.self) object's createdAt is nil!")
    XCTAssertNotNil(sut.first?.updatedAt, "\(ParseObject.self) object's updatedAt is nil!")
    XCTAssertTrue(!ParseObject.parseClassName.isEmpty, "\(ParseObject.self) has now class name!")
  }// end open func testDecodingJSONData
  
  /// Is it possible to fetch the class schema of the generic `ParseObject` conforming to `OSCAParseClassObject` protocol
  open func testFetchParseObjectSchema() throws -> Void {
    var error: Error?
    var parseClassObjectSchemas: [ParseClassSchema] = []
    let networkService = try makeDevNetworkService()
    let parameters: [String: CustomStringConvertible] = [:]
    
    let expectation = self.expectation(description: "fetchParseObjectSchema")
    let baseURL = networkService.config.baseURL
    let headers = networkService.config.headers
    let classSchemaRequestResource = makeClassSchemaRequestResource(baseURL: baseURL,
                                                                    parameters: parameters,
                                                                    headers: headers)
    let publisher: ParseClassSchemaPublisher = makeParseClassSchemaPublisher(networkService: networkService, classSchemaRequestResource: classSchemaRequestResource)
      .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
      .eraseToAnyPublisher()
    publisher
      .sink { completion in
        switch completion {
        case .finished:
          expectation.fulfill()
        case let .failure(encounteredError):
          error = encounteredError
          expectation.fulfill()
        }// end switch completion
      } receiveValue: { parseClassSchemasFromNetwork in
        parseClassObjectSchemas = parseClassSchemasFromNetwork
      }// end sink
      .store(in: &self.cancellables)
    
    waitForExpectations(timeout: 90)
    
    XCTAssertNil(error)
    XCTAssertTrue(!parseClassObjectSchemas.isEmpty)
    XCTAssertTrue(parseClassObjectSchemas.count == 1)
  }// end open func testFetchParseObjectSchema
  
  /// Is it possible to fetch up to 1000 generic `ParseObject`'s conforming to `OSCAParseClassObject` protocol
  open func testFetchAllParseObjects() throws -> Void {
    var error: Error?
    let networkService = try makeDevNetworkService()
    let limit = 1000
    var parameters: [String : CustomStringConvertible] = [:]
    
    let expectation = self.expectation(description: "fetchAllParseObjects")
    let baseURL = networkService.config.baseURL
    let parseClass = ParseObject.parseClassName
    let headers = networkService.config.headers
    parameters["limit"] = "\(limit)"
    let classRequestResource = makeClassRequestResource(baseURL: baseURL,
                                                        parseClass: parseClass,
                                                        parameters: parameters,
                                                        headers: headers)
    let publisher: ParseClassPublisher = makeParseClassPublisher(networkService: networkService,
                                                                 classRequestResource: classRequestResource)
      .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
      .eraseToAnyPublisher()
    publisher
      .sink { completion in
        switch completion {
        case .finished:
          expectation.fulfill()
        case let .failure(encounteredError):
          error = encounteredError
          expectation.fulfill()
        }// end switch completion
      } receiveValue: { allParseClassObjectsFromNetwork in
        self.sut = allParseClassObjectsFromNetwork
      }// end sink
      .store(in: &self.cancellables)
    
    waitForExpectations(timeout: 90)
    
    XCTAssertNil(error)
    XCTAssertTrue(!self.sut.isEmpty)
  }// end open func testFetchAllParseObjects
}// end open class OSCAParseClassObjectTestSuite
#endif
