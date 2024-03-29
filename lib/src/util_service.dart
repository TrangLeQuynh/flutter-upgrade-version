class UtilService {
  /// Compare version
  /// need ver1 & ver2 is available
  static int? compareVersion(String ver1, String ver2) {
    try {
      List<String> _liVer1 = ver1.split('.');
      List<String> _liVer2 = ver2.split('.');
      for (int i = 0; i < _liVer1.length; ++i) {
        if (int.parse(_liVer1[i]) > int.parse(_liVer2[i])) {
          return 1;
        } else if (int.parse(_liVer1[i]) < int.parse(_liVer2[i])) {
          return -1;
        }
      }
      return 0;
    } catch (e) {
      return null;
    }
  }

  /// Return True | False
  /// Check version str is available for Version format. Example: `1.0.0` is available
  static bool validateVersion(String? version) {
    if (version == null) return false;
    RegExp _versionRegex = RegExp(r'^\d{1,3}.\d{1,3}.\d{1,3}');
    return _versionRegex.hasMatch(version);
  }
}
