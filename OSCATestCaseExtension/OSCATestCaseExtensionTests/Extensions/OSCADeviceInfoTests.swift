//
//  OSCADeviceInfoTests.swift
//  OSCATestCaseExtensionTests
//
//  Created by Stephan Breidenbach on 08.07.22.
//
#if canImport(XCTest) && canImport(OSCATestCaseExtension)
import XCTest
@testable import OSCATestCaseExtension
import OSCAEssentials

class OSCADeviceInfoTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    try super.setUpWithError()
  }// end override func setUpWithError
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    try super.tearDownWithError()
  }// end override func tearDownWithError
  
  func testMakeDeviceInfo() throws -> Void {
    var deviceInfo: OSCADeviceInfo?
    XCTAssertNoThrow(deviceInfo = try makeDeviceInfo())
    guard let deviceInfo = deviceInfo else {
      XCTFail("Device Info is not initialized!")
      return
    }// end guard
    XCTAssertNotNil(deviceInfo.uuid)
    XCTAssertNotNil(deviceInfo.localizedModel)
    XCTAssertNotNil(deviceInfo.systemName)
    XCTAssertNotNil(deviceInfo.model)
    XCTAssertNotNil(deviceInfo.systemVersion)
    XCTAssertNotNil(deviceInfo.name)
  }// end func testInit
  
}// end class OSCATestCaseExtensionTests
#endif
