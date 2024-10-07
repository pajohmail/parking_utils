import 'package:parking_utils/CreditCardDetails.dart';
import 'package:parking_utils/ParkingItem.dart';

/// Represents a person in the parking system.
class ParkingPerson extends ParkingItem {
  String _FirstName = '';
  String _LastName = '';
  String _email = '';
  String _phone = '';
  List<String> _owenedVehicleList = [];
  List<CreditCardDetails> _creditCardList = [];
  @override
  int _id = 0;

  /// Constructs a [ParkingPerson] with the given details.
  ///
  /// [FirstName] - The first name of the person.
  /// [LastName] - The last name of the person.
  /// [email] - The email address of the person.
  /// [phone] - The phone number of the person.
  ParkingPerson({
    required String FirstName,
    required String LastName,
    required String email,
    required String phone,
  })  : _FirstName = FirstName,
        _LastName = LastName,
        _email = email,
        _phone = phone;

  /// Adds a [CreditCardDetails] to the person's list of credit cards.
  ///
  /// [creditCard] - The credit card details to add.
  void addCreditCard(CreditCardDetails creditCard) {
    _creditCardList.add(creditCard);
  }

  /// Removes a [CreditCardDetails] from the person's list of credit cards.
  ///
  /// [creditCard] - The credit card details to remove.
  void removeCreditCard(CreditCardDetails creditCard) {
    _creditCardList.remove(creditCard);
  }

  /// Sets the first name of the person.
  ///
  /// [FirstName] - The new first name.
  void setFirstName(String FirstName) {
    this._FirstName = FirstName;
  }

  /// Sets the last name of the person.
  ///
  /// [LastName] - The new last name.
  void setLastName(String LastName) {
    this._LastName = LastName;
  }

  /// Sets the email address of the person.
  ///
  /// [email] - The new email address.
  void setEmail(String email) {
    this._email = email;
  }

  /// Sets the phone number of the person.
  ///
  /// [phone] - The new phone number.
  void setPhone(String phone) {
    this._phone = phone;
  }

  /// Gets the first name of the person.
  ///
  /// Returns the first name.
  String getFirstName() {
    return this._FirstName;
  }

  /// Gets the last name of the person.
  ///
  /// Returns the last name.
  String getLastName() {
    return this._LastName;
  }

  /// Gets the email address of the person.
  ///
  /// Returns the email address.
  String getEmail() {
    return this._email;
  }

  /// Gets the phone number of the person.
  ///
  /// Returns the phone number.
  String getPhone() {
    return this._phone;
  }
}