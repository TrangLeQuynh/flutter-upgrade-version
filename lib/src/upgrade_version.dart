import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_upgrade_version/models/package_info.dart';
import 'package:flutter_upgrade_version/models/version_info.dart';
import 'package:flutter_upgrade_version/src/package_manager.dart';
import 'package:flutter_upgrade_version/src/util_service.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

/// Method Type support
enum MethodType { postType, getType }

/// UpgradeVersion
///
abstract class UpgradeVersion {

  /// Get Upgrade version
  /// Support Android & iOS
  static Future<VersionInfo?> getUpgradeVersionInfo() async {
    PackageInfo _packageInfo = await PackageManager.getPackageInfo();
    if (Platform.isIOS) return getiOSStoreVersion(_packageInfo);
    if (Platform.isAndroid) return getAndroidStoreVersion(_packageInfo);
    debugPrint('The target platform "${Platform.operatingSystem}" is not yet supported by this package.');
    return null;
  }

  /// Get Upgrade version
  /// Support Only Android
  static Future<VersionInfo?> getAndroidStoreVersion(PackageInfo packageInfo) async {
    final id = packageInfo.packageName;
    final uri = Uri.https("play.google.com", "/store/apps/details", {"id": id, "hl": "en"});
    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        debugPrint('Can\'t find an app in the Play Store with the id: $id');
        return VersionInfo(localVersion: packageInfo.version);
      }
      final document = parse(response.body);
      String storeVersion = '0.0.0';
      String? releaseNotes;

      final additionalInfoElements = document.getElementsByClassName('hAyfc');
      if (additionalInfoElements.isNotEmpty) {
        final versionElement = additionalInfoElements.firstWhere(
          (elm) => elm.querySelector('.BgcNfc')!.text == 'Current Version',
        );
        storeVersion = versionElement.querySelector('.htlgb')!.text;

        final sectionElements = document.getElementsByClassName('W4P4ne');
        final releaseNotesElement = sectionElements.firstWhere(
          (elm) => elm.querySelector('.wSaTQd')!.text == 'What\'s New',
        );
        releaseNotes = releaseNotesElement
          .querySelector('.PHBdkd')
          ?.querySelector('.DWPxHb')
          ?.text;
      } else {
        final scriptElements = document.getElementsByTagName('script');
        final infoScriptElement = scriptElements.firstWhere(
          (elm) => elm.text.contains('key: \'ds:5\''),
        );

        final param = infoScriptElement.text.substring(20, infoScriptElement.text.length - 2)
          .replaceAll('key:', '"key":')
          .replaceAll('hash:', '"hash":')
          .replaceAll('data:', '"data":')
          .replaceAll('sideChannel:', '"sideChannel":')
          .replaceAll('\'', '"');
        final parsed = json.decode(param);
        final data =  parsed['data'];

        storeVersion = data[1][2][140][0][0][0];
        releaseNotes = data[1][2][144][1][1];
      }

      return VersionInfo(
        localVersion: packageInfo.version,
        storeVersion: storeVersion,
        appStoreLink: uri.toString(),
        releaseNotes: releaseNotes,
      );
    } catch(e) {
      debugPrint('Exception: $e');
      return VersionInfo(localVersion: packageInfo.version);
    }
  }

  /// Get Upgrade version
  /// Support Only iOS
  static Future<VersionInfo> getiOSStoreVersion(PackageInfo packageInfo) async {
    final id = packageInfo.packageName;
    final parameters = {"bundleId": id};
    var uri = Uri.https("itunes.apple.com", "/lookup", parameters);
    Map<String, dynamic> _storeVersionGet = await getVersion(uri, MethodType.getType);
    Map<String, dynamic> _storeVersionPost = await getVersion(uri, MethodType.postType);
    Map<String, dynamic> _storeVersion = await _getAvailableVersion(_storeVersionGet, _storeVersionPost);
    return VersionInfo(
      localVersion: packageInfo.version,
      storeVersion: _storeVersion['storeVersion'],
      appStoreLink: _storeVersion['appStoreLink'],
    );
  }

  /// Call API to get version on Store
  static Future<Map<String, dynamic>> getVersion(Uri uri, MethodType methodType) async {
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
        'storeVersion' : _version,
        'appStoreLink' : _jsonObj['results'][0]['trackViewUrl'],
        'releaseNotes' : _jsonObj['results'][0]['releaseNotes'],
      };
    } catch (e) {
      return {};
    }
  }

  /// _getAvailableVersion
  static Future<Map<String, dynamic>> _getAvailableVersion(Map<String, dynamic> body1, Map<String, dynamic> body2) async {
    bool _status1 = UtilService.validateVersion(body1['storeVersion']);
    bool _status2 = UtilService.validateVersion(body2['storeVersion']);
    if (!_status1 && !_status2) return <String, dynamic>{};
    if (!_status1) return body2;
    if (!_status2) return body1;
    String _ver1 = body1['storeVersion'] as String;
    String _ver2 = body2['storeVersion'] as String;
    bool? _value = UtilService.compareVersion(_ver1, _ver2);
    if (_value == false) return body2;
    return body1;
  }
}
