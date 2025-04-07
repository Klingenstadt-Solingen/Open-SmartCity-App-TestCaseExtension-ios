//
//  XCTestCase+DeeplinkScheme.swift
//  OSCATestCaseExtension
//
//  Created by Stephan Breidenbach on 12.07.22.
//

#if canImport(XCTest)
import Foundation
import XCTest

public extension XCTestCase {
  /// initializes deeplink scheme from `.plist` develop
  private func getDevDeeplinkScheme() throws -> String {
    guard let dict = self.devPlistDict else { throw XCTestCaseError.plistNotFound }
    guard let deeplinkScheme = dict[Keys.Plist.deeplinkScheme] as? String else { throw XCTestCaseError.deeplinkSchemeNotFound}
    return deeplinkScheme
  }// end private func getDevDeeplinkScheme
  
  /// initializes a network service from `.plist` production
  private func getProductionDeeplinkScheme() throws -> String {
    guard let dict = self.productionPlistDict else { throw XCTestCaseError.plistNotFound }
    guard let deeplinkScheme = dict[Keys.Plist.deeplinkScheme] as? String else { throw XCTestCaseError.deeplinkSchemeNotFound}
    return deeplinkScheme
  }// end private func getProductionDeeplinkScheme
  
  func makeDevDeeplinkScheme() throws -> String {
    return try getDevDeeplinkScheme()
  }// end public func makeDevDeeplinkScheme
  
  func makeProductionDeeplinkScheme() throws -> String {
    return try getProductionDeeplinkScheme()
  }// end public func makeProductionDeeplinkScheme
}// end extension class XCTestCase

#endif
