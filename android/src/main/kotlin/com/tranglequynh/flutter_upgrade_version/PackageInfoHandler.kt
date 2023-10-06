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

class PackageInfoHandler :  MethodChannel.MethodCallHandler {

  private var context: Context
  private val binaryMessenger: BinaryMessenger
  private val packageInfoChannel: MethodChannel

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
    val packageManager = this.context.packageManager
    val info = packageManager.getPackageInfo(context.packageName, 0)
    val defaultLocale = Locale.getDefault()
    val data = mapOf<String, String?>(
      "appName" to info.applicationInfo.loadLabel(packageManager).toString(),
      "packageName" to info.packageName,
      "version" to info.versionName,
//      "versionCode" to info.versionCode.toString(),
      "buildNumber" to getLongVersionCode(info).toString(),
      "languageCode" to defaultLocale.getLanguage(),
      "regionCode" to defaultLocale.getCountry(),
    )
    result.success(data)
  }

  @Suppress("deprecation")
  private fun getLongVersionCode(info: PackageInfo): Long {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
      return info.longVersionCode
    }
    return info.versionCode.toLong()
  }

  fun stopHandle() {
    this.packageInfoChannel?.setMethodCallHandler(null)
  }

}