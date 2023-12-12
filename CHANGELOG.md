## 1.1.3

* Android: Adds a `namespace` for compatibility with AGP 8.0

## 1.1.2

* Support min SDK `3.0.0`

## 1.1.1

* Support SDK `>=2.12.2 <3.0.0`

## 1.1.0

* Remove `getAndroidStoreVersion`. Use `InAppUpdateManager` for Android Device instead.
* Add `languageCode` and `regionCode` into PackageInfo
* Need `regionCode` to ensure `getiOSStoreVersion` function works.

## 1.0.9

* Update README.md

## 1.0.8

* Fix issue when start an update

## 1.0.7

* Fix bug "duplicate - start an update"

## 1.0.6

* Add availableVersionCode, installStatus in AppUpdateInfo model

## 1.0.5

* Deprecated UpgradeVersion.getAndroidStoreVersion
* Use InAppUpdateManager for Android Device instead.

## 1.0.4

* Add the equal state when comparing 2 version

## 1.0.3

* isReviewing: default is True

## 1.0.2

* Provide documentation for classes, functions and other.

## 1.0.1

* Refactor Docs

## 1.0.0

* Get Package Information (app name, package name, version, build number).
* Get Information of Version at store (CH Play, Apple Store).
