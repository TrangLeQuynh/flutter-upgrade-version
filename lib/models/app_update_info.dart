enum UpdateAvailability {
  unknown, //0
  updateNotAvailable, //1
  updateAvailable, //2
  developerTriggeredUpdateInProgress  //3
}

class AppUpdateInfo {

  String? _packageName;

  /// Check for update availability
  int? _updateAvailability;

  /// Immediate Updates
  bool? _immediateAllowed;

  /// Flexible Updates
  bool? _flexibleAllowed;

  /// Check update staleless
  /// Use to check the number of days since the update became available on the Play Store
  num? _clientVersionStalenessDays;

  /// Check update priority
  /// To determine priority, Google Play uses an integer value between 0 and 5, with 0 being the default and 5 being the highest priority.
  int? _updatePriority;

  AppUpdateInfo({
    String? packageName,
    int? updateAvailability,
    bool? immediateAllowed,
    bool? flexibleAllowed,
    num? clientVersionStalenessDays,
    int? updatePriority,
  }) {
    _packageName = packageName;
    _updateAvailability = updateAvailability;
    _immediateAllowed = immediateAllowed;
    _flexibleAllowed = flexibleAllowed;
    _clientVersionStalenessDays = clientVersionStalenessDays;
    _updatePriority = updatePriority;
  }

  String get packageName => _packageName ?? '';
  set packageName(String? value) => _packageName = value;
  int get updateAvailability => _updateAvailability ?? 0;
  set updateAvailability(int? value) => _updateAvailability = value;
  bool get immediateAllowed => _immediateAllowed ?? false;
  set immediateAllowed(bool? value) => _immediateAllowed = value;
  bool get flexibleAllowed => _flexibleAllowed ?? false;
  set flexibleAllowed(bool? value) => _flexibleAllowed = value;
  num get clientVersionStalenessDays => _clientVersionStalenessDays ?? 0;
  set clientVersionStalenessDays(num? value) => _clientVersionStalenessDays = value;
  int get updatePriority => _updatePriority ?? 0;
  set updatePriority(int? value) => _updatePriority = value;


  AppUpdateInfo.fromJson(Map<dynamic, dynamic>? json) {
    json ??= {};
    _packageName = json['packageName'];
    _updateAvailability = json['updateAvailability'];
    _immediateAllowed = json['immediateAllowed'];
    _flexibleAllowed = json['flexibleAllowed'];
    _clientVersionStalenessDays = json['clientVersionStalenessDays'];
    _updatePriority = json['updatePriority'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'packageName' : _packageName,
    'updateAvailability' : _updateAvailability,
    'immediateAllowed' : _immediateAllowed,
    'flexibleAllowed' : _flexibleAllowed,
    'clientVersionStalenessDays' : _clientVersionStalenessDays,
    'updatePriority' : _updatePriority,
  };
}
