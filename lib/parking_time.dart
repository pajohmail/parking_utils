import 'parking_item.dart';
import 'abstract_repository.dart';

/// Class representing a parking time.
///
/// This class extends `ParkingItem` and includes details about the parking time such as start time, end time, person ID, space ID, and vehicle ID.
class ParkingTime extends ParkingItem {
  /// The unique identifier for the parking time.
  int id = 0;

  /// The start time of the parking.
  DateTime startTime = DateTime.now();

  /// The end time of the parking.
  DateTime endTime;

  /// The ID of the person associated with the parking.
  int personID;

  /// The ID of the parking space.
  int spaceID;

  /// The ID of the vehicle.
  int vehicleID;

  /// The status of the parking time.
  bool isActive = true;

  /// Constructor for creating a `ParkingTime` instance.
  ///
  /// \param endTime The end time of the parking.
  /// \param personID The ID of the person associated with the parking.
  /// \param spaceID The ID of the parking space.
  /// \param vehicleID The ID of the vehicle.
  ParkingTime({
    required this.endTime,
    required this.personID,
    required this.spaceID,
    required this.vehicleID,
  });
  // getters and setters
  int getPersonID() => personID;
  int getSpaceID() => spaceID;
  int getVehicleID() => vehicleID;
  DateTime getStartTime() => startTime;
  DateTime getEndTime() => endTime;
  void setPersonID(int personID) => this.personID = personID;
  void setSpaceID(int spaceID) => this.spaceID = spaceID;
  void setVehicleID(int vehicleID) => this.vehicleID = vehicleID;
  void setStartTime(DateTime startTime) => this.startTime = startTime;

  /// Gets the ID of the parking time.
  ///
  /// \return The current ID of the parking time.
  int getID() => id;

  /// Sets the ID of the parking time.
  ///
  /// \param id The new ID to set.
  void setID(int id) => this.id = id;
}
