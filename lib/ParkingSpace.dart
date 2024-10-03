import 'package:parking_utils/ParkingItem.dart';

class ParkingSpace extends ParkingItem {
  bool _isOccupied = false;
  String _location = '';
  String _type = '';

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