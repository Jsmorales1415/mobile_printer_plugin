import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_printer_plugin/mobile_printer_plugin.dart';
import 'package:mobile_printer_plugin/mobile_printer_plugin_platform_interface.dart';
import 'package:mobile_printer_plugin/mobile_printer_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMobilePrinterPluginPlatform
    with MockPlatformInterfaceMixin
    implements MobilePrinterPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MobilePrinterPluginPlatform initialPlatform = MobilePrinterPluginPlatform.instance;

  test('$MethodChannelMobilePrinterPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMobilePrinterPlugin>());
  });

  test('getPlatformVersion', () async {
    MobilePrinterPlugin mobilePrinterPlugin = MobilePrinterPlugin();
    MockMobilePrinterPluginPlatform fakePlatform = MockMobilePrinterPluginPlatform();
    MobilePrinterPluginPlatform.instance = fakePlatform;

    expect(await mobilePrinterPlugin.getPlatformVersion(), '42');
  });
}
