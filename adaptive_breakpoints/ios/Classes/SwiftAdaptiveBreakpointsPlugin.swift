import Flutter
import UIKit

public class SwiftAdaptiveBreakpointsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "adaptive_breakpoints", binaryMessenger: registrar.messenger())
    let instance = SwiftAdaptiveBreakpointsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
