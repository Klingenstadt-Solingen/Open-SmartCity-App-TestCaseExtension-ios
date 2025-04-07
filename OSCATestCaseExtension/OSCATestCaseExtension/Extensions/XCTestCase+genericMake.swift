//
//  XCTestCase+genericMake.swift
//  OSCATestCaseExtension
//
//  Created by Stephan Breidenbach on 30.01.23.
//

#if canImport(XCTest) && canImport(OSCAEssentials)
import Foundation
import XCTest
import OSCAEssentials

extension XCTestCase {
  /*
  public func make<D>(with config: Keys.Configuration) throws -> D {
    let userDefaults   = try makeUserDefaults(domainString: "de.osca.pressreleases")
    var dependencies: D?
    switch config {
    case .Development:
      let networkService = try makeDevNetworkService()
      dependencies = OSCAModuleDependencies()
    case .Production:
      let networkService = try makeProductionNetworkService()
      dependencies = OSCAPressReleasesDependencies(
        networkService: networkService,
        userDefaults: userDefaults)
    }// end switch case
    guard let dependencies = dependencies else { throw XCTestCaseError.dataModuleDependencyError }
    return dependencies
  }// end public func make dependencies
  
  public func make<T,D>(with config: Keys.Configuration,
                        from dependencies: D) throws -> T where T:OSCAModule {
    let userDefaults   = try makeUserDefaults(domainString: "de.osca.pressreleases")
    var dependencies: D = try make
    switch config {
    case .Development:
      let networkService = try makeDevNetworkService()
      dependencies = OSCAPressReleasesDependencies(
        networkService: networkService,
        userDefaults: userDefaults)
    case .Production:
      let networkService = try makeProductionNetworkService()
      dependencies = OSCAPressReleasesDependencies(
        networkService: networkService,
        userDefaults: userDefaults)
    }// end switch case
    guard let dependencies = dependencies else { throw XCTestCaseError.dataModuleDependencyError }
    return dependencies
  }// end public func make
   */
}// end extension XCTestCase

#endif
