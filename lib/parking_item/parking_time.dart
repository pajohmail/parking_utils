import 'parking_item.dart';
import '../repository/abstract_repository.dart';

/// Class representing a parking time.
///
/// This class extends `ParkingItem` and includes details about the parking time such as start time, end time, person ID, space ID, and vehicle ID.
class ParkingTime extends ParkingItem {
  /// The start time of the parking.
  DateTime _startTime = DateTime.now();

  /// The end time of the parking.
  DateTime _endTime;

  /// The ID of the person associated with the parking.
  int _personID;

  /// The ID of the parking space.
  int _spaceID;

  /// The ID of the vehicle.
  int _vehicleID;

  /// The status of the parking time.
  bool _isActive = true;

  /// Constructor for creating a `ParkingTime` instance.
  ///
  /// \param endTime The end time of the parking.
  /// \param personID The ID of the person associated with the parking.
  /// \param spaceID The ID of the parking space.
  /// \param vehicleID The ID of the vehicle.
  ParkingTime({
    required DateTime endTime,
    required int personID,
    required int spaceID,
    required int vehicleID,
  })  : _endTime = endTime,
        _personID = personID,
        _spaceID = spaceID,
        _vehicleID = vehicleID;

  // getters and setters
  bool isActive() => _isActive;
  int getPersonID() => _personID;
  int getSpaceID() => _spaceID;
  int getVehicleID() => _vehicleID;
  DateTime getStartTime() => _startTime;
  DateTime getEndTime() => _endTime;
  void setIsActive(bool isActive) => _isActive = isActive;
  void setPersonID(int personID) => _personID = personID;
  void setSpaceID(int spaceID) => _spaceID = spaceID;
  void setVehicleID(int vehicleID) => _vehicleID = vehicleID;
  void setStartTime(DateTime startTime) => _startTime = startTime;
  void setEndTime(DateTime endTime) => _endTime = endTime;

  /// Gets the ID of the parking time.
  ///
  /// \return The current ID of the parking time.
  @override
  int getID() => super.getID();

  /// Sets the ID of the parking time.
  ///
  /// \param id The new ID to set.
  @override
  void setID(int id) => super.setID(id);

  /// Converts the `ParkingTime` instance to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': getID(),
      'startTime': _startTime.toIso8601String(),
      'endTime': _endTime.toIso8601String(),
      'personID': _personID,
      'spaceID': _spaceID,
      'vehicleID': _vehicleID,
      'isActive': _isActive ? 1 : 0,
    };
  }

  /// Creates a `ParkingTime` instance from a map.
  static ParkingTime fromMap(Map<String, dynamic> map) {
    return ParkingTime(
      endTime: DateTime.parse(map['endTime']),
      personID: map['personID'],
      spaceID: map['spaceID'],
      vehicleID: map['vehicleID'],
    )
      ..setID(map['id'])
      ..setStartTime(DateTime.parse(map['startTime']))
      .._isActive = map['isActive'] == 1;
  }
}