import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mobile_printer_plugin_method_channel.dart';

abstract class MobilePrinterPluginPlatform extends PlatformInterface {
  /// Constructs a MobilePrinterPluginPlatform.
  MobilePrinterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MobilePrinterPluginPlatform _instance = MethodChannelMobilePrinterPlugin();

  /// The default instance of [MobilePrinterPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMobilePrinterPlugin].
  static MobilePrinterPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MobilePrinterPluginPlatform] when
  /// they register themselves.
  static set instance(MobilePrinterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
