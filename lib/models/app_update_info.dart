/// Flexible updates - Immediate updates
/// Represents the type of the update flow.
enum AppUpdateType { flexible, immediate }

/// UpdateAvailability
/// Enum represents the state of InAppUpdate
enum UpdateAvailability {
  ///value: 0
  unknown,

  ///value: 1
  updateNotAvailable,

  ///value: 2
  updateAvailable,

  ///value: 3
  developerTriggeredUpdateInProgress
}

/// AppUpdateInfo
class AppUpdateInfo {
  /// The package name
  String? _packageName;

  /// Check for update availability
  UpdateAvailability? _updateAvailability;

  /// Allow to apply a Immediate Update
  bool? _immediateAllowed;

  /// Allow to apply a Flexible Update
  bool? _flexibleAllowed;

  /// Use `clientVersionStalenessDays` to check the number of days since the update became available on the Play Store
  num? _clientVersionStalenessDays;

  /// Check update priority
  /// To determine priority, Google Play uses an integer value between 0 and 5, with 0 being the default and 5 being the highest priority.
  int? _updatePriority;

  /// If an update is available or in progress, this method returns the version code of the update.
  /// If no updates are available, this method returns an arbitrary value.
  int? _availableVersionCode;

  ///Returns the progress status of the update.
  int? _installStatus;

  /// Contructs an instance
  AppUpdateInfo({
    String? packageName,
    UpdateAvailability? updateAvailability,
    bool? immediateAllowed,
    bool? flexibleAllowed,
    num? clientVersionStalenessDays,
    int? updatePriority,
    int? availableVersionCode,
    int? installStatus,
  }) {
    _packageName = packageName;
    _updateAvailability = updateAvailability;
    _immediateAllowed = immediateAllowed;
    _flexibleAllowed = flexibleAllowed;
    _clientVersionStalenessDays = clientVersionStalenessDays;
    _updatePriority = updatePriority;
    _availableVersionCode = availableVersionCode;
    _installStatus = installStatus;
  }

  /// Getter & setter
  String get packageName => _packageName ?? '';
  set packageName(String? value) => _packageName = value;

  UpdateAvailability get updateAvailability =>
      _updateAvailability ?? UpdateAvailability.unknown;
  set updateAvailability(UpdateAvailability? value) =>
      _updateAvailability = value;

  bool get immediateAllowed => _immediateAllowed ?? false;
  set immediateAllowed(bool? value) => _immediateAllowed = value;

  bool get flexibleAllowed => _flexibleAllowed ?? false;
  set flexibleAllowed(bool? value) => _flexibleAllowed = value;

  num get clientVersionStalenessDays => _clientVersionStalenessDays ?? 0;
  set clientVersionStalenessDays(num? value) =>
      _clientVersionStalenessDays = value;

  int get updatePriority => _updatePriority ?? 0;
  set updatePriority(int? value) => _updatePriority = value;

  int get availableVersionCode => _availableVersionCode ?? 0;
  set availableVersionCode(int? value) => _availableVersionCode = value;

  int get installStatus => _installStatus ?? 0;
  set installStatus(int? value) => _installStatus = value;

  /// An instance of the AppUpdateInfo from json
  AppUpdateInfo.fromJson(Map<dynamic, dynamic>? json) {
    json ??= {};
    _packageName = json['packageName'];
    try {
      //a value from UpdateAvailability
      _updateAvailability =
          UpdateAvailability.values[json['updateAvailability'] ?? 0];
    } catch (e) {
      _updateAvailability = UpdateAvailability.unknown;
    }
    _immediateAllowed = json['immediateAllowed'];
    _flexibleAllowed = json['flexibleAllowed'];
    _clientVersionStalenessDays = json['clientVersionStalenessDays'];
    _updatePriority = json['updatePriority'];
    _availableVersionCode = json['availableVersionCode'];
    _installStatus = json['installStatus'];
  }

  /// Converts [instance] to a JSON object.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'packageName': _packageName,
        'updateAvailability': _updateAvailability,
        'immediateAllowed': _immediateAllowed,
        'flexibleAllowed': _flexibleAllowed,
        'clientVersionStalenessDays': _clientVersionStalenessDays,
        'updatePriority': _updatePriority,
        'availableVersionCode': _availableVersionCode,
        'installStatus': _installStatus,
      };
}
