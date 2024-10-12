import 'package:parking_utils/ParkingItem.dart';

class ParkingSpace extends ParkingItem {
  bool _isOccupied = false;
  String _location = '';
  String _type = '';
  double _minuteRate = 0.0;

  ParkingSpace({
    required bool isOccupied,
    required String location,
    required String type,
  })
      : _isOccupied = isOccupied,
        _location = location,
        _type = type;

  getIsOccupied() {
    return this._isOccupied;
  }

  getLocation() {
    return this._location;
  }

  getType() {
    return this._type;
  }

  getMinuteRate() {
    return this._minuteRate;
  }

  setMinuteRate(double rate) {
    this._minuteRate = rate;
  }


  setType(String type) {
    this._type = type;
  }

  setOccupied(bool isOccupied) {
    this._isOccupied = isOccupied;
  }

  setLocation(String location) {
    this._location = location;
  }
}