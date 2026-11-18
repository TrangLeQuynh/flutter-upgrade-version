/// The reason an in-app update could not be started or failed.
///
/// Keep in sync with `InAppUpdateErrorCode.kt` on Android.
enum InAppUpdateErrorCode {
  /// The user has denied or canceled the update.
  userCanceled('USER_CANCELED'),

  /// Some other error prevented either the user from providing consent or the
  /// update from proceeding.
  updateFailed('UPDATE_FAILED'),

  /// The requested `AppUpdateType` is not supported.
  updateTypeNotSupported('UPDATE_TYPE_NOT_SUPPORTED'),

  /// `checkForUpdate` must be called before `startAnUpdate`.
  checkForUpdateRequired('CHECK_FOR_UPDATE_REQUIRED'),

  /// The update failed while downloading or installing.
  /// `details` holds the Play Core `InstallErrorCode`.
  installFailed('INSTALL_FAILED'),

  /// An error not covered by the other values.
  unknown(null);

  const InAppUpdateErrorCode(this.platformCode);

  /// The error code sent by the platform for this error.
  final String? platformCode;

  /// Maps a platform error code to its [InAppUpdateErrorCode], or [unknown].
  static InAppUpdateErrorCode fromPlatformCode(String code) => values.firstWhere(
    (value) => value.platformCode == code,
    orElse: () => unknown,
  );
}

/// Thrown when an in-app update cannot be started or fails.
class InAppUpdateException implements Exception {
  /// Creates an [InAppUpdateException].
  const InAppUpdateException({required this.code, this.message, this.details});

  /// The reason the update could not be started or failed.
  final InAppUpdateErrorCode code;

  /// Human-readable error message from the platform.
  final String? message;

  /// Additional error details from the platform, if any.
  final dynamic details;

  @override
  String toString() =>
    'InAppUpdateException(${code.name}, $message${details == null ? '' : ', $details'})';
}
