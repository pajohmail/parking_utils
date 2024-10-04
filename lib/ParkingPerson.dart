import 'package:parking_utils/CreditCardDetails.dart';
import 'package:parking_utils/ParkingItem.dart';

class ParkingPerson extends ParkingItem {
  String _FirstName = '';
  String _LastName = '';
  String _email = '';
  String _phone = '';
  List<String> _owenedVehicleList = [];
  List<CreditCardDetails> _creditCardList = [];
  @override
  int _id = 0;

  // Constructor
  ParkingPerson({
    required String FirstName,
    required String LastName,
    required String email,
    required String phone,

  })  : _FirstName = FirstName,
        _LastName = LastName,
        _email = email,
        _phone = phone;

  void addCreditCard(CreditCardDetails creditCard) {
    _creditCardList.add(creditCard);
  }

  void removeCreditCard(CreditCardDetails creditCard) {
    _creditCardList.remove(creditCard);
  }


  // Setters
  void setFirstName(String FirstName) {
    this._FirstName = FirstName;
  }

  void setLastName(String LastName) {
    this._LastName = LastName;
  }

  void setEmail(String email) {
    this._email = email;
  }

  void setPhone(String phone) {
    this._phone = phone;
  }
  // Getters
  String getFirstName() {
    return this._FirstName;
  }
  String getLastName() {
    return this._LastName;
  }

  String getEmail() {
    return this._email;
  }

  String getPhone() {
    return this._phone;
  }

}