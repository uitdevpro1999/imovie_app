import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let proximityChannelName = "imovie_app/call_proximity"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    if let controller = window?.rootViewController as? FlutterViewController {
      let channel = FlutterMethodChannel(
        name: proximityChannelName,
        binaryMessenger: controller.binaryMessenger
      )
      channel.setMethodCallHandler { call, result in
        switch call.method {
        case "enable":
          UIDevice.current.isProximityMonitoringEnabled = true
          result(nil)
        case "disable":
          UIDevice.current.isProximityMonitoringEnabled = false
          result(nil)
        default:
          result(FlutterMethodNotImplemented)
        }
      }
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
