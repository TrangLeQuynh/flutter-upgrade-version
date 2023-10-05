import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_upgrade_version/flutter_upgrade_version.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PackageInfo _packageInfo = PackageInfo();

  @override
  void initState() {
    super.initState();
    getPackageData();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getPackageData() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    _packageInfo = await PackageManager.getPackageInfo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Version: ${_packageInfo.toJson()}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Locale myLocale = Localizations.localeOf(context);
                    // print('LOCALE: ${myLocale.languageCode} || ${myLocale.countryCode}');
                    if (Platform.isAndroid) {
                      InAppUpdateManager manager = InAppUpdateManager();
                      AppUpdateInfo? appUpdateInfo =
                          await manager.checkForUpdate();
                      if (appUpdateInfo == null) return;
                      if (appUpdateInfo.updateAvailability ==
                          UpdateAvailability
                              .developerTriggeredUpdateInProgress) {
                        //If an in-app update is already running, resume the update.
                        String? message = await manager.startAnUpdate(
                            type: AppUpdateType.immediate);
                        debugPrint(message ?? '');
                      } else if (appUpdateInfo.updateAvailability ==
                          UpdateAvailability.updateAvailable) {
                        ///Update available
                        if (appUpdateInfo.immediateAllowed) {
                          String? message = await manager.startAnUpdate(
                              type: AppUpdateType.immediate);
                          debugPrint(message ?? '');
                        } else if (appUpdateInfo.flexibleAllowed) {
                          String? message = await manager.startAnUpdate(
                              type: AppUpdateType.flexible);
                          debugPrint(message ?? '');
                        } else {
                          debugPrint(
                              'Update available. Immediate & Flexible Update Flow not allow');
                        }
                      }
                    } else if (Platform.isIOS) {
                      VersionInfo? _versionInfo = await UpgradeVersion.getiOSStoreVersion(packageInfo: _packageInfo, regionCode: "US");
                      print(_versionInfo.toJson());
                    }
                  },
                  child: const Text('Check Update'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
