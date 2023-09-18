package com.tranglequynh.flutter_upgrade_version

import android.app.Activity
import android.content.Intent
import com.google.android.play.core.appupdate.AppUpdateInfo
import com.google.android.play.core.appupdate.AppUpdateManager
import com.google.android.play.core.appupdate.AppUpdateManagerFactory
import com.google.android.play.core.appupdate.AppUpdateOptions
import com.google.android.play.core.install.InstallStateUpdatedListener
import com.google.android.play.core.install.model.*
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class InAppUpdateHandler : MethodChannel.MethodCallHandler, PluginRegistry.ActivityResultListener {
  private var activity: Activity
  private val binaryMessenger: BinaryMessenger
  private val inAppUpdateChannel: MethodChannel

  private var appUpdateManager: AppUpdateManager? = null
  private var appUpdateInfo: AppUpdateInfo? = null

  private var pendingResult: MethodChannel.Result? = null

  constructor(activity: Activity, binaryMessenger: BinaryMessenger) {
    this.activity = activity
    this.binaryMessenger = binaryMessenger

    this.inAppUpdateChannel = MethodChannel(binaryMessenger, FlutterUpgradeVersionPlugin.IN_APP_UPDATE_CHANNEL)
    this.inAppUpdateChannel.setMethodCallHandler(this)
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    if (requestCode == REQUEST_CODE_START_IN_APP_UPDATE) {
      when (resultCode) {
        Activity.RESULT_OK -> {
          ///The user has accepted the update.
          pendingResult?.success(null)
        }
        Activity.RESULT_CANCELED -> {
          ///The user has denied or canceled the update.
          pendingResult?.error("RESULT_CANCEL", "MSG_USER_HAS_DENIED_OR_CANCELED_THE_UPDATE", null)
        }
        ActivityResult.RESULT_IN_APP_UPDATE_FAILED -> {
          ///Some other error prevented either the user from providing consent or the update from proceeding.
          pendingResult?.error("RESULT_IN_APP_UPDATE_FAILED", "MSG_RESULT_IN_APP_UPDATE_FAILED", null)
        }
      }
      pendingResult?.let {
        pendingResult = null
      }
      return true
    }
    // If the update is cancelled or fails,
    // you can request to start the update again.
    return false
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "checkForUpdate" -> checkForUpdate(call, result)
      "startAnUpdate" -> startAnUpdate(call, result)
      else -> result.notImplemented()
    }
  }

  private fun checkForUpdate(call: MethodCall, result: MethodChannel.Result) {
    appUpdateManager = AppUpdateManagerFactory.create(activity.applicationContext)

    // Returns an intent object that you use to check for an update.
    // contain the update availability status.
    val appUpdateInfoTask = appUpdateManager!!.appUpdateInfo

    // Checks that the platform will allow the specified type of update.
    appUpdateInfoTask
      .addOnSuccessListener { info ->
        appUpdateInfo = info
        val data = mapOf(
          "packageName" to info.packageName(),
          "updateAvailability" to info.updateAvailability(),
          "immediateAllowed" to info.isUpdateTypeAllowed(AppUpdateType.IMMEDIATE),
          "flexibleAllowed" to info.isUpdateTypeAllowed(AppUpdateType.FLEXIBLE),
          "clientVersionStalenessDays" to info.clientVersionStalenessDays(),
          ///To determine priority, Google Play uses an integer value between 0 and 5, with 0 being the default and 5 being the highest priority
          "updatePriority" to info.updatePriority(),
          "availableVersionCode" to info.availableVersionCode(),
          "installStatus" to info.installStatus(),
        )
        result.success(data)
      }
      .addOnFailureListener { error ->
        result.error("ERROR", "MSG_UPDATE_INFO_TASK_EXCEPTION", error.message)
      }
  }

  /// After you confirm that an update is available, you can request an update using
  /// AppUpdateManager.startUpdateFlowForResult()
  private fun startAnUpdate(call: MethodCall, result: MethodChannel.Result) {
    if (pendingResult != null) {
      result.error("ERROR", "MSG_PROCESSING_UPDATE_IN_APP", null)
    }
    if (appUpdateManager != null || appUpdateInfo != null) {
      result.error("ERROR", "MSG_REQUIRE_CHECK_FOR_UPDATE", null)
    }
    val args = call.arguments as Map<String, Any>
    val type = when(args["appUpdateType"] as Int) {
      0 -> AppUpdateType.FLEXIBLE
      1 -> AppUpdateType.IMMEDIATE
      else -> null
    }

    if (type == null) {
      result.error("ERROR", "MSG_APP_UPDATE_TYPE_NO_SUPPORT", null)
      return
    }
    pendingResult = result
    if (type == AppUpdateType.FLEXIBLE) {
      // Before starting an update, register a listener for updates.
      appUpdateManager?.registerListener(updateListener)
    }
    appUpdateManager!!.startUpdateFlow(
      // Pass the intent that is returned by 'getAppUpdateInfo()'.
      appUpdateInfo!!,
      // an activity result launcher registered via registerForActivityResult
      activity,
      // Configure an update with AppUpdateOptions
      AppUpdateOptions.newBuilder(type)
        //Allows the update flow to delete Asset Packs from the app's storage before attempting to update the app, in case of insufficient storage.
        //.setAllowAssetPackDeletion(true) // Default false
        .build(),
    );
    appUpdateManager!!.startUpdateFlowForResult(
      appUpdateInfo!!,
      type,
      activity,
      REQUEST_CODE_START_IN_APP_UPDATE
    )
  }

  private fun unregisterUpdate() {
    // When status updates are no longer needed, unregister the listener.
    appUpdateManager?.unregisterListener(updateListener)
  }

  private val updateListener: InstallStateUpdatedListener =  InstallStateUpdatedListener {
    if (it.installStatus() == InstallStatus.DOWNLOADED) {
      // After the update is downloaded, show a notification
      // and request user confirmation to restart the app.
      pendingResult?.success(null)
      pendingResult?.let {
        pendingResult = null
      }
      appUpdateManager?.completeUpdate()
      unregisterUpdate()
    } else if (it.installErrorCode() != InstallErrorCode.NO_ERROR) {
      pendingResult?.error("ERROR", "MSG_UPDATE_LISTENER_ERROR", null)
      pendingResult?.let {
        pendingResult = null
      }
      unregisterUpdate()
    }
  }

  fun stopHandle() {
    unregisterUpdate()
    this.inAppUpdateChannel?.setMethodCallHandler(null)
  }

  companion object {
    private const val TAG = "InAppUpdateHandler"
    private const val REQUEST_CODE_START_IN_APP_UPDATE = 7109911
  }
}