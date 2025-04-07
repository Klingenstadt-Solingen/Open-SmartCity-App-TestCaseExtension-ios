//
//  PListTests.swift
//  OSCATestCaseExtensionTests
//
//  Created by Stephan Breidenbach on 08.07.22.
//
#if canImport(XCTest) && canImport(OSCATestCaseExtension)
import XCTest
@testable import OSCATestCaseExtension
import OSCAEssentials

class PListTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    try super.setUpWithError()
  }// end override func setUpWithError
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    try super.tearDownWithError()
  }// end override func tearDownWithError
  
  func testDevPlistDict() throws -> Void {
    guard let testDevPlistDict = devPlistDict
    else {
      XCTFail("No develop Plist dictionary initialized")
      return
    }// end guard
    XCTAssertNotNil(testDevPlistDict[Keys.Plist.parseRESTAPIKey] as? String)
    XCTAssertNotNil(testDevPlistDict[Keys.Plist.parseMasterAPIKey] as? String)
    XCTAssertNotNil(testDevPlistDict[Keys.Plist.devParseMasterAPIKey] as? String)
    XCTAssertNotNil(testDevPlistDict[Keys.Plist.devParseRESTAPIKey] as? String)
    XCTAssertNotNil(testDevPlistDict[Keys.Plist.parseAPIKey] as? String)
    XCTAssertNotNil(testDevPlistDict[Keys.Plist.devParseAPIKey] as? String)
  }// end func testDevPlistDict
  
  func testProductionPlistDict() throws -> Void {
    guard let testProductionPlistDict = productionPlistDict
    else {
      XCTFail("No Production Plist dictionary initialized")
      return
    }// end guard
    XCTAssertNotNil(testProductionPlistDict[Keys.Plist.parseRESTAPIKey] as? String)
    XCTAssertNotNil(testProductionPlistDict[Keys.Plist.parseMasterAPIKey] as? String)
    XCTAssertNotNil(testProductionPlistDict[Keys.Plist.devParseMasterAPIKey] as? String)
    XCTAssertNotNil(testProductionPlistDict[Keys.Plist.devParseRESTAPIKey] as? String)
    XCTAssertNotNil(testProductionPlistDict[Keys.Plist.parseAPIKey] as? String)
    XCTAssertNotNil(testProductionPlistDict[Keys.Plist.devParseAPIKey] as? String)
  }// end func testDevPlistDict
  
}// end class PListTests
#endif
