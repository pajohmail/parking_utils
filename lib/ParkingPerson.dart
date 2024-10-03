import 'package:parking_utils/CreditCardDetails.dart';
import 'package:parking_utils/ParkingItem.dart';

class ParkingPerson extends ParkingItem{
  String _name = '';
  String _email = '';
  String _phone = '';
  List <String> _owenedVehicleList = [];
  List <CreditCardDetails> _creditCardList = [];

  ParkingPerson({
    required String name,
    required String email,
    required String phone,
  })  : _name = name,
        _email = email,
        _phone = phone;

  void setName(String name) {
    this._name = name;
  }

  void setEmail(String email) {
    this._email = email;
  }

  void setPhone(String phone) {
    this._phone = phone;
  }

  String getName() {
    return this._name;
  }

  String getEmail() {
    return this._email;
  }

  String getPhone() {
    return this._phone;
  }

}