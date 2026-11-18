import '../models/app_update_info.dart';
import '../models/in_app_update_exception.dart';

/// The interface that implementations of in-app-update must implement
///
/// Support Android
/// The in-app updates feature is supported on devices running Android 5.0 (API level 21) or higher.
/// Additionally, in-app updates are only supported for Android mobile devices, Android tablets, and Chrome OS devices.
///
abstract class InAppUpdatePlatform {
  /// Check for update availability
  /// Before requesting an update, check if there is an update available for your app.
  /// Using AppUpdateManager to check for update
  ///
  Future<AppUpdateInfo?> checkForUpdate();

  /// After you confirm that an update is available, you can request an update
  /// Android support: Flexible updates and Immediate updates
  ///
  /// Completes normally if the user accepted the update.
  ///
  /// Throws [InAppUpdateException] otherwise. Check [InAppUpdateException.code]
  /// for the reason, e.g. [InAppUpdateErrorCode.userCanceled] when the user
  /// denied or canceled the update.
  Future<void> startAnUpdate({AppUpdateType type = AppUpdateType.flexible});
}
