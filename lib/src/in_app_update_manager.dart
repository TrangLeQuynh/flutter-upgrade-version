import 'package:flutter/services.dart';
import 'package:flutter_upgrade_version/config/flutter_upgrade_version_config.dart';
import 'package:flutter_upgrade_version/models/app_update_info.dart';
import 'package:flutter_upgrade_version/platforms/in_app_update_platform.dart';

class InAppUpdateManager implements InAppUpdatePlatform {
  static const MethodChannel _channel = MethodChannel(FlutterUpgradeVersionConfig.inAppUpdateChannel);

  @override
  Future<AppUpdateInfo> checkForUpdate() async {
    Map<dynamic, dynamic>? _value = await _channel.invokeMethod('checkForUpdate');
    return AppUpdateInfo.fromJson(_value);
  }

  @override
  Future<void> startAnUpdate({ AppUpdateType type = AppUpdateType.flexible }) async {
    await _channel.invokeMethod('startAnUpdate', {
      'appUpdateType' : type.index
    });
  }
}
