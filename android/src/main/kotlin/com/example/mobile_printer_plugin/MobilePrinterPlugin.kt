package com.example.mobile_printer_plugin

import androidx.annotation.NonNull
import android.app.Activity
import android.content.Context
import com.brother.sdk.lmprinter.Channel
import com.brother.sdk.lmprinter.PrinterSearcher

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** MobilePrinterPlugin */
class MobilePrinterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private lateinit var context: Context
  private lateinit var activity: Activity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "mobile_printer_plugin")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
//    if (call.method == "getPlatformVersion") {
//      result.success("Android ${android.os.Build.VERSION.RELEASE}")
//    } else {
//      result.notImplemented()
//    }
    if (call.method == "getPlatformVersion") {
      val devices = startSearchBluetoothPrinter()
      print(devices)

      if (devices.isNotEmpty()) {
        result.success(devices.toString())
      } else {
        result.success("No devices")
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity;
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  private fun startSearchBluetoothPrinter(): ArrayList<Map<String, String>> {

    val channels = PrinterSearcher.startBluetoothSearch(context).channels

    val devices = ArrayList<Map<String, String>>()

    channels.forEach {
      val modelName = it.extraInfo[Channel.ExtraInfoKey.ModelName]!!
      devices.add(
        mapOf(
          "macAddress" to it.channelInfo,
          "modelName" to modelName
        )
      )
    }
    return devices
  }
}
