//
//  OSCATestCaseExtension.swift
//
//
// created by Stephan Breidenbach on 23.06.22
//
import OSCAEssentials
import Foundation

/// Template module
public struct OSCATestCaseExtension: OSCAModule {
  
  /// version of the module
  public var version: String = "1.0.3"
  /// bundle prefix of the module
  public var bundlePrefix: String = "de.osca.testCaseExtension"
  
  
  /// module `Bundle`
  ///
  /// **available after module initialization only!!!**
  public internal(set) static var bundle: Bundle!
  
  /**
   create module and inject module dependencies
   
   ** This is the only way to initialize the module!!! **
   - Parameter moduleDependencies: module dependencies
   ```
   call: OSCATestCaseExtension.create()
   ```
   */
  public static func create() -> OSCATestCaseExtension {
    let module: OSCATestCaseExtension = OSCATestCaseExtension()
    return module
  }// end public static func create
  
  /// initializes the contact module
  private init() {
    var bundle: Bundle?
#if SWIFT_PACKAGE
    bundle = Bundle.module
#else
    bundle = Bundle(identifier: self.bundlePrefix)
#endif
    guard let bundle: Bundle = bundle else { fatalError("Module bundle not initialized!") }
    OSCATestCaseExtension.bundle = bundle
  }// end public init with network service
}// end public struct OSCATestCaseExtension
