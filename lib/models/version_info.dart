import 'package:flutter_upgrade_version/src/util_service.dart';

class VersionInfo {
  String? _localVersion;
  String? _storeVersion;
  String? _appStoreLink;
  String? _releaseNotes;
  late bool _isReviewing;
  late bool _canUpdate;

  String get localVersion => _localVersion ?? '';
  set localVersion(String? localVersion) => _localVersion = localVersion;
  String get storeVersion => _storeVersion ?? '';
  set storeVersion(String? storeVersion) => _storeVersion = storeVersion;
  String get appStoreLink => _appStoreLink ?? '';
  set appStoreLink(String? appStoreLink) => _appStoreLink = appStoreLink;
  String get releaseNotes => _releaseNotes ?? '';
  set releaseNotes(String? releaseNotes) => _releaseNotes = releaseNotes;

  bool get isReviewing => _isReviewing;
  bool get canUpdate => _canUpdate;

  bool _checkBigger(String? ver1, String? ver2) {
    if (!UtilService.validateVersion(ver1) || !UtilService.validateVersion(ver2)) {
      return false;
    }
    return UtilService.compareVersion(ver1!, ver2!) ?? false;
  }

  VersionInfo({
    String? localVersion,
    String? storeVersion,
    String? appStoreLink,
    String? releaseNotes,
  }) {
    _localVersion = localVersion;
    _storeVersion = storeVersion;
    _appStoreLink = appStoreLink;
    _releaseNotes = releaseNotes;
    _isReviewing = _checkBigger(localVersion, storeVersion);
    _canUpdate = _checkBigger(storeVersion, localVersion);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'localVersion' : _localVersion,
    'storeVersion' : _storeVersion,
    'appStoreLink' : _appStoreLink,
    'releaseNotes' : _releaseNotes,
    'isReviewing' : _isReviewing,
    "canUpdate" : _canUpdate,
  };
}
