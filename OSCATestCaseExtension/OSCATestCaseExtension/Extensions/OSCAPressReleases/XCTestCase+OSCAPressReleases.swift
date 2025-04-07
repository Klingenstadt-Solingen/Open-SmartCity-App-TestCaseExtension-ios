//
//  XCTestCase+OSCAPressReleases.swift
//  OSCATestCaseExtension
//
//  Created by Stephan Breidenbach on 30.01.23.
//

#if canImport(XCTest) && canImport(OSCAEssentials) && canImport(OSCAPressReleases)
import Foundation
import XCTest
import OSCAEssentials
import OSCAPressReleases
extension XCTestCase {
  public func make(config: Keys.Configuration) throws -> OSCAPressReleasesDependencies {
    let userDefaults   = try makeUserDefaults(domainString: "de.osca.pressreleases")
    var dependencies: OSCAPressReleasesDependencies?
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
  
  public func make(config: Keys.Configuration) throws -> OSCAPressReleases {
    let dependencies: OSCAPressReleasesDependencies = try make(config: config)
    var module: OSCAPressReleases?
    switch config {
    case .Development:
      // initialize module
      module = OSCAPressReleases.create(with: dependencies)
    case .Production:
      module = OSCAPressReleases.create(with: dependencies)
    }// end switch case
    guard let module = module else { throw XCTestCaseError.dataModuleError }
    return module
  }// end func make
}// end extension XCTestCase
#endif
