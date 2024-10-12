import 'dart:io';
import 'package:parking_utils/parking_person.dart' as pp;
import 'package:parking_utils/parking_person_repository.dart';
import 'package:parking_utils/parking_time_repository.dart';
import 'package:parking_utils/parking_vehicle_repository.dart';
import 'package:parking_utils/parking_vehicle.dart';
import 'package:parking_utils/parking_space.dart';
import 'package:parking_utils/parking_space_repository.dart';
import 'package:parking_utils/parking_time.dart';
import 'package:parking_utils/parking_time_repository.dart';
import 'package:parking_utils/payment_handler.dart';
import 'package:parking_utils/watch_tower.dart';


/// A class that handles the command line interface for the parking system.
class ClIDialog {
    WatchTower _watchTower = WatchTower();
  /// Displays the welcome menu and handles user input to navigate to different sub-menus.
  void welcomeMenu() {
    while (true) {
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
          parkingSpaceMenu();
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
  }

  /// Displays the person management menu and handles user input to perform CRUD operations on persons.
  void personMenu() {
    while (true) {
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
          _addPerson();
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
          return;
        default:
          print('Invalid choice');
          break;
      }
    }
  }

  void parkingSessionMenu() {
    while (true) {
      print('1. Add Parking Session');
      print('2. List Parking Sessions');
      print('3. Edit Parking Session');
      print('4. Delete Parking Session');
      print('5. Back to root menu');
      print('Enter your choice: ');
      String input = stdin.readLineSync()!;
      int choice = _checkInputInt(input);
      switch (choice) {
        case 1:
          print("Adding new parking session");
          _addParkingSession();
          break;
        case 2:
          print('Listing all parking sessions');
          // List Parking session logic
          break;
        case 3:
          print('Editing parking session');
          // Edit Parking session logic
          break;
        case 4:
          print('Deleting parking session');
          // Delete Parking session logic
          break;
        case 5:
          return;
        default:
          print('Invalid choice');
          break;
      }
    }
  }
  ///

  void _addParkingSession() {
    print('Adding new parking session');
    print("Enter parking session end time: ");
    String endTime = stdin.readLineSync()!;
    print("Enter parking session vehicle ID: ");
    String vehicleID = stdin.readLineSync()!;
    print("Enter parking session person ID: ");
    String personID = stdin.readLineSync()!;
    //ParkingTime pt = ParkingTime(endTime: DateTime.parse(endTime), vehicleID: int.parse(vehicleID), personID: int.parse(personID));

  }

  /// Displays the vehicle management menu and handles user input to perform CRUD operations on vehicles.
  void vehicleMenu() {
    while (true) {
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
          return;
        default:
          print('Invalid choice');
          break;
      }
    }
  }

  /// Displays the parking space management menu and handles user input to perform CRUD operations on parking spaces.
  void parkingSpaceMenu() {
    while (true) {
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
          return;
        default:
          print('Invalid choice');
          break;
      }
    }
  }

  /// Deletes a parking space based on user input.
  void _deleteParkingSpace() {
    print('Enter the ID of the parking space you want to delete: ');
    int id = int.parse(stdin.readLineSync()!);
    ParkingSpace? ps = _watchTower.getSpaceById(id);
    if (ps == null) {
      print('Parking Space not found');
      return;
    }
    _watchTower.deleteSpace(ps);
  }

  /// Edits a parking space based on user input.
  void _editParkingSpace() {
    print('Enter the ID of the parking space you want to edit: ');
    int id = int.parse(stdin.readLineSync()!);
    ParkingSpace? ps = _watchTower.getSpaceById(id);
    if (ps == null) {
      print('Parking Space not found');
      return;
    }
    print('Enter new location: ');
    String location = stdin.readLineSync()!;
    print('Enter new type: ');
    String type = stdin.readLineSync()!;
    print('Enter new status (t for occupied, f for not occupied): ');
    bool isOccupied = stdin.readLineSync() == 't';

    ps.setLocation(location);
    ps.setType(type);

    _watchTower.updateSpace(ps);
  }

  /// Adds a new parking space based on user input.
  void _addParkingSpace() {
    print('Adding new parking space');
    print("Enter parking space location: ");
    String location = stdin.readLineSync()!;
    print("Enter parking space type: ");
    String type = stdin.readLineSync()!;
    print("Enter parking space status: t if occupied, f if not occupied");
    bool isOccupied = stdin.readLineSync() == 't';

    ParkingSpace ps = ParkingSpace(isOccupied: isOccupied, location: location, type: type);
    _watchTower.addSpace(ps);
  }

  /// Lists all parking spaces.
  void _listParkingSpaces() {
    List<ParkingSpace> parkingSpaces = _watchTower.getAllSpaces();
    for (ParkingSpace parkingSpace in parkingSpaces) {
      print('Parking Space Number: ${parkingSpace.getIsOccupied()}');
      print('Parking Space Type: ${parkingSpace.getType()}');
      print('Parking Space Status: ${parkingSpace.getIsOccupied()}');
      print('ID: ${parkingSpace.getID()}');
    }
  }

  /// Deletes a vehicle based on user input.
  void _deleteVehicle() {
    print('Enter the ID of the vehicle you want to delete: ');
    int id = int.parse(stdin.readLineSync()!);
    ParkingVehicle? pv = _watchTower.getVehicleById(id);
    if (pv == null) {
      print('Vehicle not found');
      return;
    }
    _watchTower.deleteVehicle(pv);
  }

  /// Edits a vehicle based on user input.
  void _editVehicle() {
    print('Enter the ID of the vehicle you want to edit: ');
    int id = int.parse(stdin.readLineSync()!);
    ParkingVehicle? pv = _watchTower.getVehicleById(id);
    if (pv == null) {
      print('Vehicle not found');
      return;
    }
    print('Enter number plate: ');
    String numberPlate = stdin.readLineSync()!;
    print("Enter vehicle type: ");
    String vehicleType = stdin.readLineSync()!;

    pv.setNumberPlate(numberPlate);
    pv.setVehicleType(vehicleType);

    _watchTower.updateVehicle(pv);
  }

  /// Adds a new vehicle based on user input.
  void _addVehicle() {
    print('Adding new vehicle');
    print("Enter number plate: ");
    String numberPlate = stdin.readLineSync()!;
    print("Enter vehicle type: ");
    String vehicleType = stdin.readLineSync()!;

    ParkingVehicle pv = ParkingVehicle(numberPlate: numberPlate, vehicleType: vehicleType);
    _watchTower.addVehicle(pv);
  }

  /// Lists all vehicles.
  void _listVehicles() {
    List<ParkingVehicle> vehicles = _watchTower.getAllVehicles();
    for (ParkingVehicle vehicle in vehicles) {
      print('Number Plate: ${vehicle.getNumberPlate()}');
      print('Vehicle Type: ${vehicle.getVehicleType()}');
      print('ID: ${vehicle.getID()}');
    }
  }

  /// Lists all persons.
  void _listPersons() {
    List<pp.ParkingPerson> persons = _watchTower.getAllPersons();
    for (pp.ParkingPerson person in persons) {
      print('First Name: ${person.getFirstName()}');
      print('Last Name: ${person.getLastName()}');
      print('Phone: ${person.getPhone()}');
      print('Email: ${person.getEmail()}');
      print('ID: ${person.getID()}');
    }
  }

  /// Adds a new person based on user input.
  void _addPerson() {
    print('Enter First name: ');
    String firstName = stdin.readLineSync()!;
    print("Enter Last name: ");
    String lastName = stdin.readLineSync()!;
    print("Enter Phone: ");
    String phone = stdin.readLineSync()!;
    print("Enter Email: ");
    String email = stdin.readLineSync()!;


    pp.ParkingPerson person = pp.ParkingPerson(
        FirstName: firstName, LastName: lastName, email: email, phone: phone);

    print("Inserting person");
    _watchTower.addPerson(person);
  }

  /// Edits a person based on user input.
  void _editPerson() {
    print('Enter the ID of the person you want to edit: ');
    int id = int.parse(stdin.readLineSync()!);
    pp.ParkingPerson? person = _watchTower.getPersonById(id);
    if (person == null) {
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


    person.setFirstName(firstName);
    person.setLastName(lastName);
    person.setEmail(email);
    person.setPhone(phone);

    _watchTower.updatePerson(person);
  }

  /// Deletes a person based on user input.
  void _deletePerson() {
    print('Enter the ID of the person you want to delete: ');
    int inputInt = int.parse(stdin.readLineSync()!);
    pp.ParkingPerson? person = _watchTower.getPersonById(inputInt);
    if (person == null) {
      print('Person not found');
      return;
    }
    _watchTower.deletePerson(person);
  }

  /// Validates and converts user input to an integer.
  ///
  /// \param input The user input as a string.
  /// \return The validated integer input.
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