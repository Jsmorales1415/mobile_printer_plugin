
import 'mobile_printer_plugin_platform_interface.dart';

class MobilePrinterPlugin {
  Future<String?> getPlatformVersion() {
    return MobilePrinterPluginPlatform.instance.getPlatformVersion();
  }
}
