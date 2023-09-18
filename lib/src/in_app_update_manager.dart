import 'package:flutter/services.dart';
import '../config/flutter_upgrade_version_config.dart';
import '../models/app_update_info.dart';
import '../platforms/in_app_update_platform.dart';

/// InAppUpdateManager
///
/// Implements from InAppUpdatePlatform
class InAppUpdateManager implements InAppUpdatePlatform {
  static const MethodChannel _channel =
      MethodChannel(FlutterUpgradeVersionConfig.inAppUpdateChannel);

  /// checkForUpdate
  /// Return AppUpdateInfo
  @override
  Future<AppUpdateInfo> checkForUpdate() async {
    Map<dynamic, dynamic>? _value =
        await _channel.invokeMethod('checkForUpdate');
    return AppUpdateInfo.fromJson(_value);
  }

  /// startAnUpdate
  @override
  Future<void> startAnUpdate(
      {AppUpdateType type = AppUpdateType.flexible}) async {
    await _channel.invokeMethod('startAnUpdate', {'appUpdateType': type.index});
  }
}
