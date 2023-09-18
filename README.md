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

## In-app Updates

The in-app updates feature is supported on devices running Android 5.0 (API level 21) or higher. Additionally, in-app updates are only supported for Android mobile devices, Android tablets, and ChromeOS devices.

Your app can use the Google Play Core libraries to support the following UX flows for in-app updates:

### Flexible Update Flows

Flexible updates provide background download and installation with graceful state monitoring. This UX flow is appropriate when it's acceptable for the user to use the app while downloading the update. For example, you might want to encourage users to try a new feature that's not critical to the core functionality of your app.

![Flexible Flow](assets/flexible_flow.png)


### Immediate Update Flows

Immediate updates are fullscreen UX flows that require the user to update and restart the app in order to continue using it. This UX flow is best for cases where an update is critical to the core functionality of your app. After a user accepts an immediate update, Google Play handles the update installation and app restart.

![Immediate Flow](assets/immediate_flow.png)



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

/// Android
if (Platform.isAndroid) {
  InAppUpdateManager manager = InAppUpdateManager();
  AppUpdateInfo appUpdateInfo = await manager.checkForUpdate();
  if (appUpdateInfo.updateAvailability == UpdateAvailabilitydeveloperTriggeredUpdateInProgress) {
    //If an in-app update is already running, resume the update.
    await manager.startAnUpdate(type: AppUpdateType.immediate);
  } else if (appUpdateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
    ///Update available
    if (appUpdateInfo.immediateAllowed) {
      debugPrint('Start an immediate update');
      await manager.startAnUpdate(type: AppUpdateType.immediate);
    } else if (appUpdateInfo.flexibleAllowed) {
      debugPrint('Start an flexible update');
      await manager.startAnUpdate(type: AppUpdateType.flexible);
    } else {
      debugPrint('Update available. Immediate & Flexible Update Flow not allow');
    }
  }
}

///
///iOS
if (Platform.isIOS) {
  VersionInfo? _versionInfo2 = await UpgradeVersion.getiOSStoreVersion(_packageInfo);
}

```

With <span style='color:blue'>VersionInfo</span> class, I have provided information about:
 
* **canUpdate**: Return **true** if app can update.

* **isReviewing**: Return **true** if app is reviewing.

* **localVersion**: The current version of app.

* **storeVersion**: The current version of app on the store.

* **appStoreLink**: Link connect to App Store.

* **releaseNotes**: The notes of version on the store.

