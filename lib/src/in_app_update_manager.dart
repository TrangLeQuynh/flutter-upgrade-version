import 'package:flutter/foundation.dart';
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
  Future<AppUpdateInfo?> checkForUpdate() async {
    try {
      Map<dynamic, dynamic>? _value =
          await _channel.invokeMethod('checkForUpdate');
      return AppUpdateInfo.fromJson(_value);
    } on PlatformException catch (e) {
      debugPrint('${e.code} : ${e.message}');
      return null;
    }
  }

  /// startAnUpdate
  @override
  Future<String?> startAnUpdate(
      {AppUpdateType type = AppUpdateType.flexible}) async {
    try {
      await _channel
          .invokeMethod('startAnUpdate', {'appUpdateType': type.index});
      return null;
    } on PlatformException catch (e) {
      return e.message;
    } on Exception catch (e) {
      return 'Exception: ${e.toString()}';
    }
  }
}
