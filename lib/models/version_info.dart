import 'package:flutter_upgrade_version/src/util_service.dart';

/// VersionInfo
///
class VersionInfo {
  /// The package version
  String? _localVersion;

  /// The package version on store (CH Play and Apple Store)
  String? _storeVersion;

  /// The app link on store (CH Play and Apple Store)
  String? _appStoreLink;

  /// Description - Release note
  /// What is new in this version on store?
  String? _releaseNotes;

  /// Is this version reviewing?
  /// True | False
  late bool _isReviewing;

  /// Is this the latest version?
  /// True if It is not latest version, otherwise
  late bool _canUpdate;

  /// Getter & Setter
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

  /// Return True if Version 1 is bigger than Version 2, otherwise
  ///
  bool? _checkBigger(String? ver1, String? ver2) {
    if (!UtilService.validateVersion(ver1) ||
        !UtilService.validateVersion(ver2)) {
      return null;
    }
    return UtilService.compareVersion(ver1!, ver2!) == 1;
  }

  /// An instance of the VersionInfo
  /// Constructor
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
    _isReviewing = _checkBigger(localVersion, storeVersion) ?? true;
    _canUpdate = _checkBigger(storeVersion, localVersion) ?? false;
  }

  /// Converts [instance] to a JSON object.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'localVersion': _localVersion,
        'storeVersion': _storeVersion,
        'appStoreLink': _appStoreLink,
        'releaseNotes': _releaseNotes,
        'isReviewing': _isReviewing,
        "canUpdate": _canUpdate,
      };
}
