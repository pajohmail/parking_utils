import 'package:parking_utils/ParkingItem.dart';

class ParkingVehicle extends ParkingItem {
  String _numberPlate = '';
  String _vehicleType = '';

  ParkingVehicle({
    required String numberPlate,
    required String vehicleType,
  })  :_numberPlate = numberPlate,
        _vehicleType = vehicleType;



  void setNumberPlate(String numberPlate) {
    this._numberPlate = numberPlate;
  }

  void setVehicleType(String vehicleType) {
    this._vehicleType = vehicleType;
  }

  String getNumberPlate() {
    return this._numberPlate;
  }

  String getVehicleType() {
    return this._vehicleType;
  }
}