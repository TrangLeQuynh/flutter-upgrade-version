/// PackageInfo
///
class PackageInfo {
  /// The app name. `CFBundleDisplayName` ?? `CFBundleName` on iOS, `applicationInfo.loadLabel` on Android.
  String? _appName;

  /// The package name. `CFBundleIdentifier` on iOS, `packageName` on Android.
  String? _packageName;

  /// The package version. `CFBundleShortVersionString` on iOS, `versionName` on Android.
  String? _version;

  /// The build number. `CFBundleVersion` on iOS, `getLongVersionCode` on Android.
  String? _buildNumber;

  /// The language code of this Locale.
  String? _languageCode;

  ///Region/Country is just a setting about currently used regional settings, it doesn't mean the actual country you're in.
  ///ISO 3166 alpha-2 country code
  ///Returns the country/region code for this locale, which should either be the empty string, an uppercase ISO 3166 2-letter code, or a UN M.49 3-digit code.
  String? _regionCode;


  /// Constructor Package Info
  PackageInfo({
    String? appName,
    String? packageName,
    String? version,
    String? buildNumber,
    String? languageCode,
    String? regionCode,
  }) {
    _version = version;
    _packageName = packageName;
    _appName = appName;
    _buildNumber = buildNumber;
    _languageCode = languageCode;
    _regionCode = regionCode;
  }

  /// getter & setter
  ///
  String get appName => _appName ?? '';
  set appName(String? appName) => _appName = appName;

  String get packageName => _packageName ?? '';
  set packageName(String? packageName) => _packageName = packageName;

  String get version => _version ?? '';
  set version(String? version) => _version = version;

  String get buildNumber => _buildNumber ?? '';
  set buildNumber(String? buildNumber) => _buildNumber = buildNumber;

  String get languageCode => _languageCode ?? '';
  set languageCode(String? languageCode) => _languageCode = languageCode;

  String get regionCode => _regionCode ?? '';
  set regionCode(String? regionCode) => _regionCode = regionCode;

  /// PackageInfo.fromJson
  PackageInfo.fromJson(Map<dynamic, dynamic>? json) {
    json ??= {};
    _version = json['version'];
    _packageName = json['packageName'];
    _appName = json['appName'];
    _buildNumber = json['buildNumber'];
    _languageCode = json['languageCode'];
    _regionCode = json['regionCode'];
  }

  /// Json
  Map<String, dynamic> toJson() => <String, dynamic>{
        'appName': _appName,
        'packageName': _packageName,
        'version': _version,
        'buildNumber': _buildNumber,
        'languageCode': _languageCode,
        'regionCode': _regionCode,
      };
}
