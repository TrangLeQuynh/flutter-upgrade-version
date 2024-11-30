package com.tranglequynh.flutter_upgrade_version

import android.content.Context
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*

class PackageInfoHandler : MethodChannel.MethodCallHandler {

  private var context: Context
  private val binaryMessenger: BinaryMessenger
  private var packageInfoChannel: MethodChannel

  constructor(context: Context, binaryMessenger: BinaryMessenger) {
    this.context = context
    this.binaryMessenger = binaryMessenger

    this.packageInfoChannel = MethodChannel(binaryMessenger, FlutterUpgradeVersionPlugin.PACKAGE_INFO_CHANNEL)
    this.packageInfoChannel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "package-info" -> getPackageInfo(result)
      else -> result.notImplemented()
    }
  }

  fun getPackageInfo(result: MethodChannel.Result) {
    try {
      val packageManager = this.context.packageManager
      val info = packageManager.getPackageInfoCompatibility(context.packageName)
      val defaultLocale = Locale.getDefault()
      val data = mapOf<String, String?>(
        "appName" to info.applicationInfo?.loadLabel(packageManager)?.toString(),
        "packageName" to info.packageName,
        "version" to info.versionName,
        "buildNumber" to getLongVersionCode(info).toString(),
        "languageCode" to defaultLocale.getLanguage(),
        "regionCode" to defaultLocale.getCountry(),
      )
      result.success(data)
    } catch (e: Exception) {
      result.error("ERROR", e.message, null)
    }
  }

  @Suppress("deprecation")
  fun PackageManager.getPackageInfoCompatibility(packageName: String): PackageInfo {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
      return getPackageInfo(packageName, PackageManager.PackageInfoFlags.of(0))
    } else {
      return getPackageInfo(packageName, 0)
    }
  }

  @Suppress("deprecation")
  private fun getLongVersionCode(info: PackageInfo): Long {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
      return info.getLongVersionCode()
    }
    return info.versionCode.toLong()
  }

  fun stopHandle() {
    this.packageInfoChannel.setMethodCallHandler(null)
  }

}