# Flutter Upgrade Version Package

A Flutter plugin for Android, iOS allowing get informations about package, version info.

|                | Android | iOS      |
|----------------|:-:|:-:|
| **Support**   |`:white_check_mark:` |`:white_check_mark:`| 


## Features

* Get Package Information (app name, package name, version, build number).
* Get Information of Version at store (CH Play, Apple Store).
* Support In App Update - Android (comming soon)

## Installation

First, add `flutter_upgrade_version` as a [dependency in your pubspec.yaml file](https://flutter.dev/using-packages/).

```dart
    dependencies
        flutter_upgrade_version: ^1.0.1
```

## Usage

You can use FlutterUpgradeVersion to get information about the package.

```dart
import 'package:flutter_upgrade_version/flutter_upgrade_version.dart';

Future<void> getPackageData() async {
    PackageInfo _packageInfo = await PackageManager.getPackageInfo();

    ///
    ///_packageInfo.appName;
    ///_packageInfo.packageName;
    ///_packageInfo.version;
    ///_packageInfo.buildNumber;
  }
```

You can get the app information on the Store through ID - package_name. You need to make sure the ID alrealy exits on the Store.

```dart
///Short Syntax - Support Android & iOS
///This function is a combination of two functions:  UpgradeVersion.getAndroidStoreVersion &  UpgradeVersion.getiOSStoreVersion
VersionInfo? _versionInfo = await UpgradeVersion.getUpgradeVersionInfo();

///
///Android
///I don't recommend people to use this function. It's not suitable. This function will fail if CH Play changes the HTML on the store
VersionInfo? _versionInfo1 = await UpgradeVersion.getAndroidStoreVersion(_packageInfo);

///
///iOS
VersionInfo? _versionInfo2 = await UpgradeVersion.getiOSStoreVersion(_packageInfo);

```

With <span style='color:blue'>VersionInfo</span> class, I have provided information about:
 
* **canUpdate**: Return **true** if app can update.

* **isReviewing**: Return **true** if app is reviewing.

* **localVersion**: The current version of app.

* **storeVersion**: The current version of app on the store.

* **appStoreLink**: Link connect to App Store.

* **releaseNotes**: The notes of version on the store.

