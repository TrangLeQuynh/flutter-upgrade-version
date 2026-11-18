import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/app_update_info.dart';
import '../models/in_app_update_exception.dart';
import '../platforms/in_app_update_platform.dart';

/// InAppUpdateManager
///
/// Implements from InAppUpdatePlatform
class InAppUpdateManager implements InAppUpdatePlatform {
  static const MethodChannel _channel =
      MethodChannel('com.tranglequynh.flutter-upgrade-version/in-app-update');

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
  Future<void> startAnUpdate({AppUpdateType type = AppUpdateType.flexible}) async {
    try {
      await _channel.invokeMethod('startAnUpdate', {'appUpdateType': type.index});
    } on PlatformException catch (e, stackTrace) {
      Error.throwWithStackTrace(
        InAppUpdateException(
          code: InAppUpdateErrorCode.fromPlatformCode(e.code),
          message: e.message, 
          details: e.details,
        ),
        stackTrace,
      ); 
    }
  }
}
