//
//  OSCANetworkServiceTests.swift
//  OSCATestCaseExtensionTests
//
//  Created by Stephan Breidenbach on 08.07.22.
//
#if canImport(XCTest) && canImport(OSCATestCaseExtension)
import XCTest
@testable import OSCATestCaseExtension
import OSCANetworkService

class OSCANetworkServiceTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    try super.setUpWithError()
  }// end override func setUpWithError
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    try super.tearDownWithError()
  }// end override func tearDownWithError
  
  func testMakeDevNetworkService() throws {
    var devNetworkService: OSCANetworkService?
    XCTAssertNoThrow(devNetworkService = try makeDevNetworkService())
    guard let devNetworkService = devNetworkService else {
      XCTFail("No develop network service initialized")
      return
    }// end guard
    XCTAssertNotNil(devNetworkService)
  }// end func testMakeDevNetworkService
  
  func testMakeProduktionNetworkService() throws {
    var productionNetworkService: OSCANetworkService?
    XCTAssertNoThrow(productionNetworkService = try makeProductionNetworkService())
    guard let productionNetworkService = productionNetworkService else {
      XCTFail("No production network service initialized")
      return
    }// end guard
    XCTAssertNotNil(productionNetworkService)
  }// end func testMakeProductionNetworkService
}// end class OSCATestCaseExtensionTests
#endif
