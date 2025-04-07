//
//  OSCATestCaseExtensionTests.swift
//  OSCATestCaseExtensionTests
//
//  Created by Stephan Breidenbach on 04.07.22.
//
#if canImport(XCTest) && canImport(OSCATestCaseExtension)
import XCTest
@testable import OSCATestCaseExtension
import OSCAEssentials

class OSCATestCaseExtensionTests: XCTestCase {
  static let moduleVersion = "1.0.3"
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    try super.setUpWithError()
  }// end override func setUpWithError
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    try super.tearDownWithError()
  }// end override func tearDownWithError
  
  func testModuleInit() throws -> Void {
    let testCaseExtension = makeTestCaseExtension()
    XCTAssertNotNil(testCaseExtension, "TestCaseExtension initialization failed!")
    XCTAssertEqual(testCaseExtension.version, OSCATestCaseExtensionTests.moduleVersion)
    XCTAssertEqual(testCaseExtension.bundlePrefix, "de.osca.testCaseExtension")
    XCTAssertNotNil(OSCATestCaseExtension.bundle)
  }// end func testModuleInit
  
}// end class OSCATestCaseExtensionTests

extension OSCATestCaseExtensionTests {
  public func makeTestCaseExtension() -> OSCATestCaseExtension {
    return OSCATestCaseExtension.create()
  }// end public func makeTestCaseExtension
}// end extension class OSCATestCaseExtensionTests
#endif
