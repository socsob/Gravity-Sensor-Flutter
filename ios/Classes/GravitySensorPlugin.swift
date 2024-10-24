import Flutter
import UIKit
import CoreMotion
import Foundation

public class GravitySensorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let GRAVITY_SENSOR_CHANNEL_NAME = "gravity_sensor"

    let gravitySensorChannel = FlutterEventChannel(name: GRAVITY_SENSOR_CHANNEL_NAME, binaryMessenger: registrar.messenger())
    gravitySensorChannel.setStreamHandler(GravitySensorStreamHandler())
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        default:
            result(FlutterMethodNotImplemented)
        }
  }
}

class GravitySensorStreamHandler: NSObject, FlutterStreamHandler {
    private let motionManager = CMMotionManager()
    private let queue = OperationQueue()
    
    func onListen(withArguments arguments: Any?, eventSink sink: @escaping FlutterEventSink) -> FlutterError? {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: queue) { (data, error) in
                if data != nil {
                    sink([data!.gravity.x, data!.gravity.y, data!.gravity.z])
                }
            }
        } else {
            sink(FlutterError(code: "UNAVAILABLE", message: "Gravity sensor not available", details: nil))
        }

        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        motionManager.stopDeviceMotionUpdates()
        return nil
    }
}