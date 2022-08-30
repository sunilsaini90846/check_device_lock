import 'dart:async';

import 'package:flutter/services.dart';

class CheckDeviceLock {
  static const MethodChannel _channel = MethodChannel('sun_check_device_lock');

  /// This method work for iOS and Android applications.
  /// Method use to get true and false value
  /// If device has password or any biometric authentication then it return true otherwise return false.
  static Future<bool?> get isDeviceSecure async {
    final bool? isDeviceProtected =
        await _channel.invokeMethod('isDeviceSecure');
    return isDeviceProtected;
  }
}
