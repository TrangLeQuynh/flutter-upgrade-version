import 'package:flutter/services.dart';
import 'package:flutter_upgrade_version/config/config.dart';
import 'package:flutter_upgrade_version/models/package_info.dart';

class PackageManager {
  static const MethodChannel _channel = MethodChannel(FlutterUpgradeVersionConfig.packageInfoChannel);

  static Future<PackageInfo> getPackageInfo() async {
    try {
      Map<dynamic, dynamic>? _data = await _channel.invokeMethod('package-info');
      PackageInfo _info = PackageInfo.fromJson(_data);
      return _info;
    } catch(e) {
      return PackageInfo();
    }
  }
}