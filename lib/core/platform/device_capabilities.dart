import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';

/// Hardware facts the performance profile needs.
// ignore: use_primary_constructors (no constructor by design: interface/static-only)
abstract interface class DeviceCapabilities {
  /// True when Android reports a low-RAM device (about 2 GB or less).
  Future<bool> isLowRamDevice();
}

class PlatformDeviceCapabilities() implements DeviceCapabilities {
  @override
  Future<bool> isLowRamDevice() async {
    if (!Platform.isAndroid) return false;
    try {
      return (await DeviceInfoPlugin().androidInfo).isLowRamDevice;
    } on Object {
      return false;
    }
  }
}
