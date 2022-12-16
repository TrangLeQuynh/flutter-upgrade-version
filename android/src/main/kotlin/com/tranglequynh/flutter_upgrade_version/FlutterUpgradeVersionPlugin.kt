package com.tranglequynh.flutter_upgrade_version

import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** FlutterUpgradeVersionPlugin */
class FlutterUpgradeVersionPlugin: FlutterPlugin, ActivityAware {
  private var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding? = null
  private var packageInfoHandler: PackageInfoHandler? = null
  private var inAppUpdateHandler: InAppUpdateHandler? = null
  private var activity: ActivityPluginBinding? = null

  override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    this.flutterPluginBinding = binding
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    this.flutterPluginBinding = null
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding

    packageInfoHandler = PackageInfoHandler(flutterPluginBinding!!.applicationContext, flutterPluginBinding!!.binaryMessenger)
    inAppUpdateHandler = InAppUpdateHandler(binding.activity, flutterPluginBinding!!.binaryMessenger)

    activity!!.addActivityResultListener(inAppUpdateHandler!!)
  }

  override fun onDetachedFromActivity() {
    activity!!.removeActivityResultListener(inAppUpdateHandler!!)
    activity = null

    packageInfoHandler?.stopHandle()
    inAppUpdateHandler?.stopHandle()
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity()
  }

  companion object {
    const val PACKAGE_INFO_CHANNEL = "com.tranglequynh.flutter-upgrade-version/package-info"
    const val IN_APP_UPDATE_CHANNEL = "com.tranglequynh.flutter-upgrade-version/in-app-update"
  }
}
