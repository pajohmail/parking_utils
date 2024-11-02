import 'package:parking_utils/parking_item/parking_item.dart';
import 'package:parking_utils/parking_item/parking_vehicle.dart';



/// Class representing a person associated with parking.
///
/// This class extends `ParkingItem` and includes personal details and a list of owned vehicles.
class ParkingPerson extends ParkingItem {
  /// The first name of the person.
  String _firstName = '';

  /// The last name of the person.
  String _lastName = '';

  /// The email address of the person.
  String _email = '';

  /// The phone number of the person.
  String _phone = '';

  /// A list of vehicles owned by the person.
  List<ParkingVehicle> _ownedVehicleList = [];

  /// Constructor for creating a `ParkingPerson` instance.
  ///
  /// \param FirstName The first name of the person.
  /// \param LastName The last name of the person.
  /// \param email The email address of the person.
  /// \param phone The phone number of the person.
  ParkingPerson({
    required String FirstName,
    required String LastName,
    required String email,
    required String phone,
  })  : _firstName = FirstName,
        _lastName = LastName,
        _email = email,
        _phone = phone;

  /// Sets the first name of the person.
  ///
  /// \param FirstName The new first name to set.
  void setFirstName(String FirstName) {
    this._firstName = FirstName;
  }

  /// Sets the last name of the person.
  ///
  /// \param LastName The new last name to set.
  void setLastName(String LastName) {
    this._lastName = LastName;
  }

  /// Sets the email address of the person.
  ///
  /// \param email The new email address to set.
  void setEmail(String email) {
    this._email = email;
  }

  /// Sets the phone number of the person.
  ///
  /// \param phone The new phone number to set.
  void setPhone(String phone) {
    this._phone = phone;
  }

  /// Gets the first name of the person.
  ///
  /// \return The current first name of the person.
  String getFirstName() {
    return this._firstName;
  }

  /// Gets the last name of the person.
  ///
  /// \return The current last name of the person.
  String getLastName() {
    return this._lastName;
  }

  /// Gets the email address of the person.
  ///
  /// \return The current email address of the person.
  String getEmail() {
    return this._email;
  }

  /// Gets the phone number of the person.
  ///
  /// \return The current phone number of the person.
  String getPhone() {
    return this._phone;
  }
}
