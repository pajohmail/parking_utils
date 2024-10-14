import 'package:parking_utils/parking_item.dart';

/// Class representing a parking vehicle.
///
/// This class extends `ParkingItem` and includes details about the vehicle such as its number plate and type.
class ParkingVehicle extends ParkingItem {
  /// The number plate of the vehicle.
  String _numberPlate = '';

  /// The type of the vehicle (e.g., car, motorcycle).
  String _vehicleType = '';

  /// Constructor for creating a `ParkingVehicle` instance.
  ///
  /// \param numberPlate The number plate of the vehicle.
  /// \param vehicleType The type of the vehicle.
  ParkingVehicle({
    required String numberPlate,
    required String vehicleType,
  })  : _numberPlate = numberPlate,
        _vehicleType = vehicleType;

  /// Sets the number plate of the vehicle.
  ///
  /// \param numberPlate The new number plate to set.
  void setNumberPlate(String numberPlate) {
    this._numberPlate = numberPlate;
  }

  /// Sets the type of the vehicle.
  ///
  /// \param vehicleType The new type to set.
  void setVehicleType(String vehicleType) {
    this._vehicleType = vehicleType;
  }

  /// Gets the number plate of the vehicle.
  ///
  /// \return The number plate of the vehicle.
  String getNumberPlate() {
    return this._numberPlate;
  }

  /// Gets the type of the vehicle.
  ///
  /// \return The type of the vehicle.
  String getVehicleType() {
    return this._vehicleType;
  }
}
