import Flutter
import UIKit

public class SwiftCheckDeviceLockPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "sun_check_device_lock", binaryMessenger: registrar.messenger())
        let instance = SwiftCheckDeviceLockPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
            /// This method is invoked on the UI thread.
            if call.method == "isDeviceSecure" {
                let isDeviceSecure = self.isDeviceSecure()
                result(isDeviceSecure)
            } else {
                result(FlutterMethodNotImplemented)
            }
    }
    
    /// Method use to get true and false value
    /// If device has password or any biometric authentication then it return true otherwise return false.
    func isDeviceSecure() -> Bool {
        let secret = "Device has passcode set?".data(using: String.Encoding.utf8, allowLossyConversion: false)
        let attributes = [kSecClass as String: kSecClassGenericPassword, kSecAttrService as String: "LocalDeviceServices", kSecAttrAccount as String: "NoAccount", kSecValueData as String: secret!, kSecAttrAccessible as String: kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly] as [String : Any]
        let status = SecItemAdd(attributes as CFDictionary, nil)
        if status == 0 {
            SecItemDelete(attributes as CFDictionary)
            return true
        } else {
            return false
        }
    }
}
