import 'dart:io';
import 'package:parking_utils/ParkingPerson.dart';
import 'package:parking_utils/ParkingPersonRepository.dart';
import 'package:parking_utils/CreditCardDetails.dart';
import 'package:parking_utils/ParkingVehicleRepository.dart';
import 'package:parking_utils/ParkingVehicle.dart';
import 'package:parking_utils/ParkingSpace.dart';
import 'package:parking_utils/ParkingSpaceRepository.dart';
import 'package:parking_utils/ParkingSpace.dart';

class ClIDialog {
  ParkingPersonRepository _personRepository = ParkingPersonRepository();
  ParkingVehicleRepository _vehicleRepository = ParkingVehicleRepository();
  ParkingSpaceRepository _parkingSpaceRepository = ParkingSpaceRepository();
  void welcomeMenu() {
    print('1. Edit Person');
    print('2. Edit Vehicle');
    print('3. Edit Parking lot');
    print('4. Edit Parking session');
    print('5. Exit');
    print('Enter your choice: ');
    String input = stdin.readLineSync()!;
    int choice = _checkInputInt(input);
    switch (choice) {
      case 1:
        personMenu();
        break;
      case 2:
        vehicleMenu();
        break;
      case 3:
        PakingSpaceMenu();
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
    String input = stdin.readLineSync()!;
    int choice = _checkInputInt(input);
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
      welcomeMenu();
        break;
      default:
        print('Invalid choice');
        break;
    }
  }

  void vehicleMenu() {
    print('1. Add Vehicle');
    print('2. List Vehicle');
    print('3. Edit Vehicle');
    print('4. Delete Vehicle');
    print('5. Back');
    print('Enter your choice: ');
    String input = stdin.readLineSync()!;
    int choice = _checkInputInt(input);
    switch (choice) {
      case 1:
      print("Adding new vehicle");
      _addVehicle();
        break;
      case 2:
      print("Listing all vehicles");
      _listVehicles();
        break;
      case 3:
       print("Editing vehicle");
       _editVehicle();
        break;
      case 4:
        print("Deleting vehicle");
        _deleteVehicle();
        break;
      case 5:

        break;
      default:
        print('Invalid choice');
        break;
    }
  }
  void PakingSpaceMenu() {
    print('1. Add Parking Space');
    print('2. List Parking Space');
    print('3. Edit Parking Space');
    print('4. Delete Parking Space');
    print('5. Back');
    print('Enter your choice: ');
    String input = stdin.readLineSync()!;
    int choice = _checkInputInt(input);
    switch (choice) {
      case 1:
        print("Adding new parking space");
        _addParkingSpace();
        break;
      case 2:
        print("Listing all parking spaces");
        _listParkingSpaces();
        break;
      case 3:
        print("Editing parking space");
        _editParkingSpace();
        break;
      case 4:
        print("Deleting parking space");
        _deleteParkingSpace();
        break;
      case 5:
        break;
      default:
        print('Invalid choice');
        break;
    }
  }
  void _deleteParkingSpace() {
    print('Enter the ID of the parking space you want to delete: ');
    int id = int.parse(stdin.readLineSync()!);

    ParkingSpace ps = _parkingSpaceRepository.getById(id);
    if (ps == null){
      print('Parking Space not found');
      return;
    }
  }

  void _editParkingSpace() {
    print('Enter the ID of the parking space you want to edit: ');
    int id = int.parse(stdin.readLineSync()!);
    ParkingSpace ps = _parkingSpaceRepository.getById(id);
    if (ps == null){
      print('Parking Space not found');
      return;
    }
  }

  void _addParkingSpace(){
    print('Adding new parking space');
    print("Enter parking space location: ");
    String location = stdin.readLineSync()!;
    print("Enter parking space type: ");
    String type = stdin.readLineSync()!;
    print("Enter parking space status: t if occupied, f if not occupied");
    bool isOccupied = false;
    if(stdin.readLineSync()=='t'){
      isOccupied = true;
    }

    ParkingSpace ps = ParkingSpace(isOccupied: isOccupied, location: location, type: type);
    _parkingSpaceRepository.add(ps);
  }

  void _listParkingSpaces(){
    List<ParkingSpace> parkingSpaces = _parkingSpaceRepository.getAll();
    for (ParkingSpace parkingSpace in parkingSpaces){
      print('Parking Space Number: ${parkingSpace.getIsOccupied()}');
      print('Parking Space Type: ${parkingSpace.getType()}');
      print('Parking Space Status: ${parkingSpace.getIsOccupied()}');
      print('ID: ${parkingSpace.getID()}');
    }
  }

  void _deleteVehicle(){
    print('Enter the ID of the vehicle you want to delete: ');
    int id = int.parse(stdin.readLineSync()!);
    ParkingVehicle pv = _vehicleRepository.getById(id);
    if (pv == null){
      print('Vehicle not found');
      return;
    }
    _vehicleRepository.delete(pv);
  }

  void _editVehicle(){
    print('Enter the ID of the vehicle you want to edit: ');
    int id = int.parse(stdin.readLineSync()!);
    ParkingVehicle pv = _vehicleRepository.getById(id);
    if (pv == null){
      print('Vehicle not found');
      return;
    }
    print('Enter number plate: ');
    String numberPlate = stdin.readLineSync()!;
    print("Enter vehicle type: ");
    String vehicleType = stdin.readLineSync()!;

    pv.setNumberPlate(numberPlate);
    pv.setVehicleType(vehicleType);

    _vehicleRepository.update(pv);
  }
  void _addVehicle(){
    print('Adding new vehicle');
    print("Enter number plate: ");
    String numberPlate = stdin.readLineSync()!;
    print("Enter vehicle type: ");
    String vehicleType = stdin.readLineSync()!;

    ParkingVehicle pv = ParkingVehicle
      (numberPlate: numberPlate, vehicleType: vehicleType);
    _vehicleRepository.add(pv);
  }

  _listVehicles(){
    List<ParkingVehicle> vehicles = _vehicleRepository.getAll();
    for (ParkingVehicle vehicle in vehicles){
      print('Number Plate: ${vehicle.getNumberPlate()}');
      print('Vehicle Type: ${vehicle.getVehicleType()}');
      print('ID: ${vehicle.getID()}');
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
    int inputInt = int.parse(stdin.readLineSync()!);
    ParkingPerson pp = _personRepository.getById(inputInt);
    if (pp == null){
      print('Person not found');
      return;
    }
    _personRepository.delete(pp);
  }

  int _checkInputInt(String input) {
    while (true) {
      try {
        int inputInt = int.parse(input);
        if (inputInt >= 1 && inputInt <= 5) {
          return inputInt;
        }
      } catch (e) {
        // Do nothing, will prompt again
      }
      print('Invalid choice');
      input = stdin.readLineSync()!;
    }
  }
}