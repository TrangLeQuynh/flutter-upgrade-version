class UtilService {

  ///need ver1 & ver2 is available
  static bool? compareVersion(String ver1, String ver2) {
    try {
      List<String> _liVer1 = ver1.split('.');
      List<String> _liVer2 = ver2.split('.');
      for (int i = 0; i < _liVer1.length; ++ i) {
        if (int.parse(_liVer1[i]) > int.parse(_liVer2[i])) {
          return true;
        } else if (int.parse(_liVer1[i]) < int.parse(_liVer2[i])) {
          return false;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static bool validateVersion(String? version) {
    if (version == null) return false;
    RegExp _versionRegex = RegExp(r'^\d{1,3}.\d{1,3}.\d{1,3}');
    return _versionRegex.hasMatch(version);
  }
}
