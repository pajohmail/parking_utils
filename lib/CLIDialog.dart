import 'dart:io';
import 'package:parking_utils/ParkingItemFactory.dart';
import 'package:parking_utils/ParkingPerson.dart';
import 'package:parking_utils/ParkingPersonFactory.dart';
import 'package:parking_utils/ParkingPersonRepository.dart';
import 'package:parking_utils/CreditCardDetails.dart';

class ClIDialog {
  ParkingPersonRepository _personRepository = ParkingPersonRepository();

  void welcomeMenu() {
    print('1. Edit Person');
    print('2. Edit Vehicle');
    print('3. Edit Parking lot');
    print('4. Edit Parking session');
    print('5. Exit');
    print('Enter your choice: ');
    int choice = int.parse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
        personMenu();
        break;
      case 2:
        vehicleMenu();
        break;
      case 3:
      // Add Parking lot logic
        break;
      case 4:
      // Add Parking session logic
        break;
      case 5:
        exit(0);
        break;
      default:
        print('Invalid choice');
        break;
    }
  }

  void personMenu() {
    print('1. Add Person');
    print('2. List Persons');
    print('3. Edit Person');
    print('4. Delete Person');
    print('5. Back to root menu');
    print('Enter your choice: ');
    int choice = int.parse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
        print("Adding new person");
        _addPersson();
        break;
      case 2:
        print('Listing all persons');
        _listPersons();
        break;
      case 3:
      _editPerson();
        break;
      case 4:
      print('Deleting person');
      _deletePerson();
        break;
      case 5:
      // Back logic
        break;
      default:
        print('Invalid choice');
        break;
    }
  }

  void vehicleMenu() {
    print('1. Add Vehicle');
    print('2. List Vehicle');
    print('3. Back');
    print('Enter your choice: ');
    int choice = int.parse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
      // Add Vehicle logic
        break;
      case 2:
      // List Vehicle logic
        break;
      case 3:
      // Back logic
        break;
      default:
        print('Invalid choice');
        break;
    }
  }

  void _listPersons(){
    List<ParkingPerson> persons = _personRepository.getAll();
    for (ParkingPerson person in persons){
      print('First Name: ${person.getFirstName()}');
      print('Last Name: ${person.getLastName()}');
      print('Phone: ${person.getPhone()}');
      print('Email: ${person.getEmail()}');
      print('ID: ${person.getID()}');
    }
  }

  void _addPersson(){
    print('Adding new person');
    print('Enter First name: ');
    String firstName = stdin.readLineSync()!;
    print("Enter Last name: ");
    String lastName = stdin.readLineSync()!;
    print("Enter Phone: ");
    String phone = stdin.readLineSync()!;
    print("Enter Email: ");
    String email = stdin.readLineSync()!;
    print("Enter credit card number: ");
    String creditCardNumber = stdin.readLineSync()!;
    print("Enter credit card expiry date: ");
    String creditCardExpiryDate = stdin.readLineSync()!;
    print("Enter credit card CVV: ");
    String creditCardCVV = stdin.readLineSync()!;
    print("Enter credit card holder name: ");
    String creditCardHolderName = stdin.readLineSync()!;

    ParkingPerson pp = ParkingPerson(
        FirstName: firstName,
        LastName: lastName,
        email: email,
        phone: phone
    );
    CreditCardDetails cc = CreditCardDetails(
        cardNumber: creditCardNumber,
        expiryDate: creditCardExpiryDate,
        cvvCode: creditCardCVV
    );
    pp.addCreditCard(cc);
   print("Inserting person");
    _personRepository.add(pp);

  }
  // Edit person asks for a persons ID
  // and then asks for the new values for the person  and updates _personRepository with
  // the new values
  void _editPerson(){
    print('Enter the ID of the person you want to edit: ');
    int id = int.parse(stdin.readLineSync()!);
    ParkingPerson pp = _personRepository.getById(id);
    if (pp == null){
      print('Person not found');
      return;
    }
    print('Enter First name: ');
    String firstName = stdin.readLineSync()!;
    print("Enter Last name: ");
    String lastName = stdin.readLineSync()!;
    print("Enter Phone: ");
    String phone = stdin.readLineSync()!;
    print("Enter Email: ");
    String email = stdin.readLineSync()!;
    print("Enter credit card number: ");
    String creditCardNumber = stdin.readLineSync()!;
    print("Enter credit card expiry date: ");
    String creditCardExpiryDate = stdin.readLineSync()!;
    print("Enter credit card CVV: ");
    String creditCardCVV = stdin.readLineSync()!;


    pp.setFirstName(firstName);
    pp.setLastName(lastName);
    pp.setEmail(email);
    pp.setPhone(phone);
    CreditCardDetails cc = CreditCardDetails(
        cardNumber: creditCardNumber,
        expiryDate: creditCardExpiryDate,
        cvvCode: creditCardCVV
    );
    pp.addCreditCard(cc);

    _personRepository.update(pp);

  }
  _deletePerson(){
    print('Enter the ID of the person you want to delete: ');
    int id = int.parse(stdin.readLineSync()!);
    ParkingPerson pp = _personRepository.getById(id);
    if (pp == null){
      print('Person not found');
      return;
    }
    _personRepository.delete(pp);
  }

}