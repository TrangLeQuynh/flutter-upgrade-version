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

  /// Constructor Package Info
  PackageInfo({
    String? appName,
    String? packageName,
    String? version,
    String? buildNumber,
  }) {
    _version = version;
    _packageName = packageName;
    _appName = appName;
    _buildNumber = buildNumber;
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

  /// PackageInfo.fromJson
  PackageInfo.fromJson(Map<dynamic, dynamic>? json) {
    json ??= {};
    _version = json['version'];
    _packageName = json['packageName'];
    _appName = json['appName'];
    _buildNumber = json['buildNumber'];
  }

  /// Json
  Map<String, dynamic> toJson() => <String, dynamic>{
    'appName' : _appName,
    'packageName' : _packageName,
    'version' : _version,
    'buildNumber' : _buildNumber,
  };
}
