class PackageInfoHandler {

  init(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: Config.PACKAGE_INFO_CHANNEL, binaryMessenger: registrar.messenger())
    channel.setMethodCallHandler { call, result in
      switch call.method {
        case "package-info":
          self.getPackageInfo(result)
        default:
          break
      }
    }
  }

  private func getPackageInfo(_ result: @escaping FlutterResult)-> Void {
    let dictionary = Bundle.main.infoDictionary ?? [:]
    let locale = NSLocale.current
    let info: [String: Any?] = [
      "appName" : dictionary["CFBundleDisplayName"] ?? dictionary["CFBundleName"],
      "packageName" : dictionary["CFBundleIdentifier"],
      "version" : dictionary["CFBundleShortVersionString"],
      "buildNumber" : dictionary["CFBundleVersion"],
      "languageCode" : locale.languageCode,
      "regionCode" : locale.regionCode,
    ]
    result(info)
  }
}
