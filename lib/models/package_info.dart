class PackageInfo {
  String? _appName;
  String? _packageName;
  String? _version;
  String? _buildNumber;

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

  String get appName => _appName ?? '';
  set appName(String? appName) => _appName = appName;
  String get packageName => _packageName ?? '';
  set packageName(String? packageName) => _packageName = packageName;
  String get version => _version ?? '';
  set version(String? version) => _version = version;
  String get buildNumber => _buildNumber ?? '';
  set buildNumber(String? buildNumber) => _buildNumber = buildNumber;

  PackageInfo.fromJson(Map<dynamic, dynamic>? json) {
    json ??= {};
    _version = json['version'];
    _packageName = json['packageName'];
    _appName = json['appName'];
    _buildNumber = json['buildNumber'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'appName' : _appName,
    'packageName' : _packageName,
    'version' : _version,
    'buildNumber' : _buildNumber,
  };
}
