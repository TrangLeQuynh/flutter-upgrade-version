import 'dart:async';
import 'package:flutter/services.dart';

class FlutterUpgradeVersion {
  static const MethodChannel _channel = MethodChannel('flutter_upgrade_version');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
