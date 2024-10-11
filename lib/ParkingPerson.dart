import 'package:parking_utils/ParkingItem.dart';
import 'package:parking_utils/ParkingVehicle.dart';

class CreditCardDetails {
  // Define the properties and methods for CreditCardDetails
}

class ParkingPerson extends ParkingItem {
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phone = '';
  List<ParkingVehicle> _ownedVehicleList = [];


  ParkingPerson({
    required String FirstName,
    required String LastName,
    required String email,
    required String phone,
  })  : _firstName = FirstName,
        _lastName = LastName,
        _email = email,
        _phone = phone;



  void setFirstName(String FirstName) {
    this._firstName = FirstName;
  }

  void setLastName(String LastName) {
    this._lastName = LastName;
  }

  void setEmail(String email) {
    this._email = email;
  }

  void setPhone(String phone) {
    this._phone = phone;
  }

  String getFirstName() {
    return this._firstName;
  }

  String getLastName() {
    return this._lastName;
  }

  String getEmail() {
    return this._email;
  }

  String getPhone() {
    return this._phone;
  }
}