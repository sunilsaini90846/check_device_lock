import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:check_device_lock/check_device_lock.dart';

void main() {
  const MethodChannel channel = MethodChannel('sun_check_device_lock');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return true;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('isDeviceSecure', () async {
    expect(await CheckDeviceLock.isDeviceSecure, true);
  });
}
