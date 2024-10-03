class ParkingTime {
  int? _hours;
  int? _minutes;
  int? _seconds;

  ParkingTime(this._hours, this._minutes, this._seconds);

  int? get hours => _hours;
  int? get minutes => _minutes;
  int? get seconds => _seconds;

  set hours(int? hours) => _hours = hours;
  set minutes(int? minutes) => _minutes = minutes;
  set seconds(int? seconds) => _seconds = seconds;

  @override
  String toString() {
    return 'ParkingTime{hours: $_hours, minutes: $_minutes, seconds: $_seconds}';
  }
}