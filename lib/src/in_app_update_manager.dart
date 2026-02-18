import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/app_update_info.dart';
import '../platforms/in_app_update_platform.dart';

/// InAppUpdateManager
///
/// Implements from InAppUpdatePlatform
class InAppUpdateManager implements InAppUpdatePlatform {
  static const MethodChannel _channel =
      MethodChannel('com.tranglequynh.flutter-upgrade-version/in-app-update');

  VoidCallback? _onUpdateDownloadedCallback;

  InAppUpdateManager() {
    // Set up listener for events from Kotlin
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onUpdateDownloaded':
        _onUpdateDownloadedCallback?.call();
        _onUpdateDownloadedCallback = null;
        break;
      default:
        throw MissingPluginException('Unknown method: ${call.method}');
    }
  }

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
      {AppUpdateType type = AppUpdateType.flexible,
      bool completeOnDownload = true,
      VoidCallback? onUpdateDownloaded}) async {
    try {
      if (!completeOnDownload) {
        _onUpdateDownloadedCallback = onUpdateDownloaded;
      }
      await _channel.invokeMethod('startAnUpdate', {
        'appUpdateType': type.index,
        'completeOnDownload': completeOnDownload
      });
      return null;
    } on PlatformException catch (e) {
      _onUpdateDownloadedCallback = null;
      return e.message;
    } on Exception catch (e) {
      _onUpdateDownloadedCallback = null;
      return 'Exception: ${e.toString()}';
    }
  }

  @override
  Future<String?> completeUpdate() async {
    try {
      await _channel.invokeMethod('completeUpdate');
      return null;
    } on PlatformException catch (e) {
      return e.message;
    } on Exception catch (e) {
      return 'Exception: ${e.toString()}';
    }
  }
}
