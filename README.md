# check_device_lock

For Android and iOS to check the device is secure by any passcode or biomatric.

## Getting Started

![Example Image:](https://github.com/sunilsaini90846/check_device_lock/blob/main/example/assets/example_image.jpeg)


# Method

Call this method to check if the device is secure:
```
Future<void> initPlatformState() async {
    bool value;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      value = await CheckDeviceLock.isDeviceSecure ?? false;
    } on PlatformException {
      value = false;
    }
}
```