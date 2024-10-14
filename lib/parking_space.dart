import 'package:parking_utils/parking_item.dart';

/// Class representing a parking space.
///
/// This class extends `ParkingItem` and includes details about the parking space such as its occupancy status, location, type, and rate per minute.
class ParkingSpace extends ParkingItem {
  /// Indicates whether the parking space is occupied.
  bool _isOccupied = false;

  /// The location of the parking space.
  String _location = '';

  /// The type of the parking space (e.g., compact, large).
  String _type = '';

  /// The rate per minute for using the parking space.
  double _minuteRate = 0.0;

  /// Constructor for creating a `ParkingSpace` instance.
  ///
  /// \param isOccupied Indicates whether the parking space is occupied.
  /// \param location The location of the parking space.
  /// \param type The type of the parking space.
  ParkingSpace({
    required bool isOccupied,
    required String location,
    required String type,
  })  : _isOccupied = isOccupied,
        _location = location,
        _type = type;

  /// Gets the occupancy status of the parking space.
  ///
  /// \return `true` if the parking space is occupied, `false` otherwise.
  bool getIsOccupied() {
    return this._isOccupied;
  }

  /// Gets the location of the parking space.
  ///
  /// \return The location of the parking space.
  String getLocation() {
    return this._location;
  }

  /// Gets the type of the parking space.
  ///
  /// \return The type of the parking space.
  String getType() {
    return this._type;
  }

  /// Gets the rate per minute for using the parking space.
  ///
  /// \return The rate per minute.
  double getMinuteRate() {
    return this._minuteRate;
  }

  /// Sets the rate per minute for using the parking space.
  ///
  /// \param rate The new rate per minute to set.
  void setMinuteRate(double rate) {
    this._minuteRate = rate;
  }

  /// Sets the type of the parking space.
  ///
  /// \param type The new type to set.
  void setType(String type) {
    this._type = type;
  }

  /// Sets the occupancy status of the parking space.
  ///
  /// \param isOccupied The new occupancy status to set.
  void setOccupied(bool isOccupied) {
    this._isOccupied = isOccupied;
  }

  /// Sets the location of the parking space.
  ///
  /// \param location The new location to set.
  void setLocation(String location) {
    this._location = location;
  }
}
