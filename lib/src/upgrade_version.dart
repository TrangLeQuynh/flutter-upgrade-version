import 'dart:convert';
import 'package:flutter_upgrade_version/models/package_info.dart';
import 'package:flutter_upgrade_version/models/version_info.dart';
import 'package:flutter_upgrade_version/src/util_service.dart';
import 'package:http/http.dart' as http;

/// Method Type support
enum MethodType { postType, getType }

/// UpgradeVersion
///
abstract class UpgradeVersion {
  /// Get Upgrade version
  /// Support Only iOS
  //
  // You need to pass country code as param if app is available on specific iTune store.
  static Future<VersionInfo> getiOSStoreVersion({ required PackageInfo packageInfo, String? regionCode }) async {
    final id = packageInfo.packageName;
    final parameters = {
      "bundleId": id,
      "country" : regionCode,
    };
    var uri = Uri.https("itunes.apple.com", "/lookup", parameters);
    Map<String, dynamic> _storeVersionGet =
        await getVersion(uri, MethodType.getType);
    Map<String, dynamic> _storeVersionPost =
        await getVersion(uri, MethodType.postType);
    Map<String, dynamic> _storeVersion =
        await _getAvailableVersion(_storeVersionGet, _storeVersionPost);
    return VersionInfo(
      localVersion: packageInfo.version,
      storeVersion: _storeVersion['storeVersion'],
      appStoreLink: _storeVersion['appStoreLink'],
    );
  }

  /// Call API to get version on Store
  static Future<Map<String, dynamic>> getVersion(
      Uri uri, MethodType methodType) async {
    try {
      late final http.Response response;
      if (methodType == MethodType.getType) {
        response = await http.get(uri);
      } else {
        response = await http.post(uri);
      }
      final _jsonObj = json.decode(response.body);
      String _version = _jsonObj['results'][0]['version'];
      return {
        'storeVersion': _version,
        'appStoreLink': _jsonObj['results'][0]['trackViewUrl'],
        'releaseNotes': _jsonObj['results'][0]['releaseNotes'],
      };
    } catch (e) {
      return {};
    }
  }

  /// _getAvailableVersion
  static Future<Map<String, dynamic>> _getAvailableVersion(
      Map<String, dynamic> body1, Map<String, dynamic> body2) async {
    bool _status1 = UtilService.validateVersion(body1['storeVersion']);
    bool _status2 = UtilService.validateVersion(body2['storeVersion']);
    if (!_status1 && !_status2) return <String, dynamic>{};
    if (!_status1) return body2;
    if (!_status2) return body1;
    String _ver1 = body1['storeVersion'] as String;
    String _ver2 = body2['storeVersion'] as String;
    bool? _value = UtilService.compareVersion(_ver1, _ver2) == 1;
    if (_value == false) return body2;
    return body1;
  }
}
