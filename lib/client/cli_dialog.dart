import 'dart:io';
import 'package:parking_utils/parking_item/parking_person.dart' as pp;
import 'package:parking_utils/repository/parking_person_repository.dart';
import 'package:parking_utils/repository/parking_time_repository.dart';
import 'package:parking_utils/repository/parking_vehicle_repository.dart';
import 'package:parking_utils/parking_item/parking_vehicle.dart';
import 'package:parking_utils/parking_item/parking_space.dart';
import 'package:parking_utils/repository/parking_space_repository.dart';
import 'package:parking_utils/parking_item/parking_time.dart';
import 'package:parking_utils/repository/payment_handler.dart';
import 'package:parking_utils/client/watch_tower_client.dart';

/// A class that handles the command line interface for the parking system.
class ClIDialog {
  /// Instance of WatchTower to manage parking system operations.
  WatchTower _watchTower = WatchTower();

  /// Displays the welcome menu and handles user input to navigate to different sub-menus.
  Future<void> welcomeMenu() async {
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
          await personMenu();
          break;
        case 2:
          await vehicleMenu();
          break;
        case 3:
          await parkingSpaceMenu();
          break;
        case 4:
          await parkingSessionMenu();
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
  Future<void> personMenu() async {
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
          await _addPerson();
          break;
        case 2:
          print('Listing all persons');
          await _listPersons();
          break;
        case 3:
          await _editPerson();
          break;
        case 4:
          print('Deleting person');
          await _deletePerson();
          break;
        case 5:
          return;
        default:
          print('Invalid choice');
          break;
      }
    }
  }

  /// Displays the parking session management menu and handles user input to perform CRUD operations on parking sessions.
  Future<void> parkingSessionMenu() async {
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
          await _addParkingSession();
          break;
        case 2:
          print('Listing all parking sessions');
          await _listParkingSessions();
          break;
        case 3:
          print('Editing parking session');
          await _editParkingSession();
          break;
        case 4:
          print('Ending parking session');
          await _endParkingSession();
          return;
        case 5:
          return;
        default:
          print('Invalid choice');
          break;
      }
    }
  }

  /// Edits a parking session based on user input.
  Future<void> _editParkingSession() async {
    print('Enter the ID of the parking session you want to edit: ');
    String id = stdin.readLineSync()!;
    print('Enter the new end time in minutes: ');
    String endTime = stdin.readLineSync()!;

    ParkingTime? tmp = await _watchTower.getTimeById(_checkInputInt(id));
    if (tmp == null) {
      print('Parking Session not found');
      return;
    } else {
      DateTime date = _calcEndTime(tmp.getStartTime(), _checkInputInt(endTime));
      await _watchTower.editParkingSession(tmp.getID()!, date);
    }
  }

  /// Ends the parking session for a given ID and processes the refund.
  Future<void> _endParkingSession() async {
    print('Enter the ID of the parking session you want to end: ');
    String id = stdin.readLineSync()!;
    ParkingTime? tmp = await _watchTower.getTimeById(_checkInputInt(id));
    if (tmp == null) {
      print('Parking Session not found');
      return;
    }
    await _watchTower.endParkingSession(tmp.getID());
  }

  /// Calculates the difference in minutes between two DateTime objects.
  ///
  /// \param startTime The start time.
  /// \param endTime The end time.
  /// \return The difference in minutes.
  int _calcTime(DateTime startTime, DateTime endTime) {
    Duration difference = endTime.difference(startTime);
    return difference.inMinutes;
  }

  /// Calculates the end time based on the start time and the duration in minutes.
  DateTime _calcEndTime(DateTime startTime, int minutes) {
    return startTime.add(Duration(minutes: minutes));
  }

  /// Lists all parking sessions.
  Future<void> _listParkingSessions() async {
    List<ParkingTime> parkingTimes = await _watchTower.getAllTimes();
    for (ParkingTime parkingTime in parkingTimes) {
      print('Parking Session End Time: ${parkingTime.getEndTime()}');
      print('Parking Session Vehicle ID: ${parkingTime.getVehicleID()}');
      print('Parking Session Person ID: ${parkingTime.getPersonID()}');
      print('Parking Session Space ID: ${parkingTime.getSpaceID()}');
    }
  }

  /// Adds a new parking session based on user input.
  Future<void> _addParkingSession() async {
    print('Adding new parking session');
    print("Enter parking session duration in minutes: ");
    String durationStr = stdin.readLineSync()!;
    print("Enter parking session vehicle ID: ");
    String vehicleID = stdin.readLineSync()!;
    print("Enter parking session person ID: ");
    String personID = stdin.readLineSync()!;
    print('Enter parking session space ID: ');
    String spaceID = stdin.readLineSync()!;

    int duration = _checkInputInt(durationStr);
    DateTime endTime = DateTime.now().add(Duration(minutes: duration));

    var tempPerson = await _watchTower.getPersonById(_checkInputInt(personID));
    var tempParkVehicle = await _watchTower.getVehicleById(_checkInputInt(vehicleID));
    var tempParkingSpace = await _watchTower.getSpaceById(_checkInputInt(spaceID));

    if (tempPerson == null || tempParkingSpace == null || tempParkVehicle == null) {
      print('Person, Parking Space, or Parking Vehicle not found');
      return;
    }

    ParkingTime pt = ParkingTime(
      endTime: endTime,
      vehicleID: _checkInputInt(vehicleID),
      personID: _checkInputInt(personID),
      spaceID: _checkInputInt(spaceID),
    );

    await _watchTower.addTime(pt);
  }

  /// Displays the vehicle management menu and handles user input to perform CRUD operations on vehicles.
  Future<void> vehicleMenu() async {
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
          await _addVehicle();
          break;
        case 2:
          print("Listing all vehicles");
          await _listVehicles();
          break;
        case 3:
          print("Editing vehicle");
          await _editVehicle();
          break;
        case 4:
          print("Deleting vehicle");
          await _deleteVehicle();
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
  Future<void> parkingSpaceMenu() async {
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
          await _addParkingSpace();
          break;
        case 2:
          print("Listing all parking spaces");
          await _listParkingSpaces();
          break;
        case 3:
          print("Editing parking space");
          await _editParkingSpace();
          break;
        case 4:
          print("Deleting parking space");
          await _deleteParkingSpace();
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
  Future<void> _deleteParkingSpace() async {
    print('Enter the ID of the parking space you want to delete: ');
    int id = int.parse(stdin.readLineSync()!);
    ParkingSpace? ps = await _watchTower.getSpaceById(id);
    if (ps == null) {
      print('Parking Space not found');
      return;
    }
    await _watchTower.deleteSpace(ps);
  }

  /// Edits a parking space based on user input.
  Future<void> _editParkingSpace() async {
    print('Enter the ID of the parking space you want to edit: ');
    int id = int.parse(stdin.readLineSync()!);
    ParkingSpace? ps = await _watchTower.getSpaceById(id);
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

    await _watchTower.updateSpace(ps);
  }

  /// Adds a new parking space based on user input.
  Future<void> _addParkingSpace() async {
    print('Adding new parking space');
    print("Enter parking space location: ");
    String location = stdin.readLineSync()!;
    print("Enter parking space type: ");
    String type = stdin.readLineSync()!;
    print("Enter parking space status: t if occupied, f if not occupied");
    bool isOccupied = stdin.readLineSync() == 't';

    ParkingSpace ps =
    ParkingSpace(isOccupied: isOccupied, location: location, type: type);
    await _watchTower.addSpace(ps);
  }

  /// Lists all parking spaces.
  Future<void> _listParkingSpaces() async {
    List<ParkingSpace> parkingSpaces = await _watchTower.getAllSpaces();
    for (ParkingSpace parkingSpace in parkingSpaces) {
      print('Parking Space Number: ${parkingSpace.getIsOccupied()}');
      print('Parking Space Type: ${parkingSpace.getType()}');
      print('Parking Space Status: ${parkingSpace.getIsOccupied()}');
      print('ID: ${parkingSpace.getID()}');
    }
  }

  /// Deletes a vehicle based on user input.
  Future<void> _deleteVehicle() async {
    print('Enter the ID of the vehicle you want to delete: ');
    int id = int.parse(stdin.readLineSync()!);
    ParkingVehicle? pv = await _watchTower.getVehicleById(id);
    if (pv == null) {
      print('Vehicle not found');
      return;
    }
    await _watchTower.deleteVehicle(pv);
  }

  /// Edits a vehicle based on user input.
  Future<void> _editVehicle() async {
    print('Enter the ID of the vehicle you want to edit: ');
    int id = int.parse(stdin.readLineSync()!);
    ParkingVehicle? pv = await _watchTower.getVehicleById(id);
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

    await _watchTower.updateVehicle(pv);
  }

  /// Adds a new vehicle based on user input.
  Future<void> _addVehicle() async {
    print('Adding new vehicle');
    print("Enter number plate: ");
    String numberPlate = stdin.readLineSync()!;
    print("Enter vehicle type: ");
    String vehicleType = stdin.readLineSync()!;

    ParkingVehicle pv =
    ParkingVehicle(numberPlate: numberPlate, vehicleType: vehicleType);
    await _watchTower.addVehicle(pv);
  }

  /// Lists all vehicles.
  Future<void> _listVehicles() async {
    List<ParkingVehicle> vehicles = await _watchTower.getAllVehicles();
    for (ParkingVehicle vehicle in vehicles) {
      print('Number Plate: ${vehicle.getNumberPlate()}');
      print('Vehicle Type: ${vehicle.getVehicleType()}');
      print('ID: ${vehicle.getID()}');
    }
  }

  /// Lists all persons.
  Future<void> _listPersons() async {
    List<pp.ParkingPerson> persons = await _watchTower.getAllPersons();
    for (pp.ParkingPerson person in persons) {
      print('First Name: ${person.getFirstName()}');
      print('Last Name: ${person.getLastName()}');
      print('Phone: ${person.getPhone()}');
      print('Email: ${person.getEmail()}');
      print('ID: ${person.getID()}');
    }
  }

  /// Adds a new person based on user input.
  Future<void> _addPerson() async {
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
    await _watchTower.addPerson(person);
  }

  /// Edits a person based on user input.
  Future<void> _editPerson() async {
    print('Enter the ID of the person you want to edit: ');
    int id = int.parse(stdin.readLineSync()!);
    pp.ParkingPerson? person = await _watchTower.getPersonById(id);
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

    await _watchTower.updatePerson(person);
  }

  /// Deletes a person based on user input.
  Future<void> _deletePerson() async {
    print('Enter the ID of the person you want to delete: ');
    int inputInt = int.parse(stdin.readLineSync()!);
    pp.ParkingPerson? person = await _watchTower.getPersonById(inputInt);
    if (person == null) {
      print('Person not found');
      return;
    }
    await _watchTower.deletePerson(person);
  }

  /// Validates and converts user input to an integer.
  ///
  /// \param input The user input as a string.
  /// \return The validated integer input.
  int _checkInputInt(String input) {
    while (true) {
      try {
        int inputInt = int.parse(input);
        return inputInt;

      } catch (e) {
        // Do nothing, will prompt again
      }
      print('Invalid choice');
      print('input was $input');
      input = stdin.readLineSync()!;
    }
  }
}