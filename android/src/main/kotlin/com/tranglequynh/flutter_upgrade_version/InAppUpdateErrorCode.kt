package com.tranglequynh.flutter_upgrade_version

import io.flutter.plugin.common.MethodChannel

/**
 * Error codes sent to Dart when an in-app update fails.
 *
 * [name] is sent as the error code and [message] as the error message.
 * Keep in sync with `InAppUpdateErrorCode` in `lib/models/in_app_update_exception.dart`.
 */
enum class InAppUpdateErrorCode(val message: String) {
  /** The user has denied or canceled the update. */
  USER_CANCELED("The user has denied or canceled the update."),

  /** Some other error prevented either the user from providing consent or the update from proceeding. */
  UPDATE_FAILED("Some other error prevented either the user from providing consent or the update from proceeding."),

  /** The requested AppUpdateType is not supported. */
  UPDATE_TYPE_NOT_SUPPORTED("AppUpdateType is not supported."),

  /** checkForUpdate must be called before startAnUpdate. */
  CHECK_FOR_UPDATE_REQUIRED("checkForUpdate must be called before startAnUpdate."),

  /** The flexible update failed while downloading or installing. */
  INSTALL_FAILED("The update failed while downloading or installing."),

  /** Getting the app update info from Google Play failed. */
  CHECK_FOR_UPDATE_FAILED("Failed to get the app update info."),
}

/** Reports [code] as an error to Dart. */
internal fun MethodChannel.Result.error(code: InAppUpdateErrorCode, details: Any? = null) =
  error(code.name, code.message, details)
