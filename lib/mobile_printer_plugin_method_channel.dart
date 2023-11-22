import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mobile_printer_plugin_platform_interface.dart';

/// An implementation of [MobilePrinterPluginPlatform] that uses method channels.
class MethodChannelMobilePrinterPlugin extends MobilePrinterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mobile_printer_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
