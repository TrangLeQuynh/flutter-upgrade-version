import 'package:flutter/services.dart';
import 'package:flutter_upgrade_version/config/flutter_upgrade_version_config.dart';
import 'package:flutter_upgrade_version/models/package_info.dart';

/// Package Manager
class PackageManager {
  /// Create the Flutter platform client
  ///
  /// Package Info Channel
  static const MethodChannel _channel =
      MethodChannel(FlutterUpgradeVersionConfig.packageInfoChannel);

  /// Returns a map with the following keys
  /// version, packageName, appName,buildNumber
  static Future<PackageInfo> getPackageInfo() async {
    try {
      Map<dynamic, dynamic>? _data =
          await _channel.invokeMethod('package-info');
      PackageInfo _info = PackageInfo.fromJson(_data);
      return _info;
    } catch (e) {
      return PackageInfo();
    }
  }
}
