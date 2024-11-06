import 'package:parking_utils/parking_item/parking_vehicle.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:parking_utils/parking_item/parking_person.dart';
import 'package:parking_utils/parking_item/parking_space.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  late final Database _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal() {
    _initDatabase();
  }

  void _initDatabase() {
    final dbPath = join(Directory.current.path, 'lib', 'database', 'parking_database.db');
    final dbFile = File(dbPath);

    if (!dbFile.existsSync()) {
      _database = sqlite3.open(dbPath);
      _onCreate(_database);
    } else {
      _database = sqlite3.open(dbPath);
    }
  }

  void _onCreate(Database db) {
    db.execute('''
      CREATE TABLE IF NOT EXISTS ParkingPerson (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT,
        lastName TEXT,
        email TEXT,
        phone TEXT
      )
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS ParkingVehicle (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        numberPlate TEXT,
        vehicleType TEXT
      )
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS ParkingSpace (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        isOccupied INTEGER,
        location TEXT,
        type TEXT,
        minuteRate REAL
      )
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS ParkingTime (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        startTime TEXT,
        endTime TEXT,
        personID INTEGER,
        spaceID INTEGER,
        vehicleID INTEGER,
        isActive INTEGER,
        FOREIGN KEY (personID) REFERENCES ParkingPerson(id),
        FOREIGN KEY (spaceID) REFERENCES ParkingSpace(id),
        FOREIGN KEY (vehicleID) REFERENCES ParkingVehicle(id)
      )
    ''');
  }

  // Methods for ParkingPerson
  void addParkingPerson(ParkingPerson person) {
    person.setID(_getNextPersonID());
    _database.execute(
      'INSERT INTO ParkingPerson (firstName, lastName, email, phone) VALUES (?, ?, ?, ?)',
      [person.getFirstName(), person.getLastName(), person.getEmail(), person.getPhone()],
    );
  }

  List<ParkingPerson> getParkingPersons() {
    List<ParkingPerson> persons = [];
    for (int i = 1; i < _getCurrentPersonID(); i++) {
      persons.add(getParkingPerson(i));
    }
    return persons;
  }

  ParkingPerson getParkingPerson(int id) {
    final List<Map<String, dynamic>> maps = _database.select('SELECT * FROM ParkingPerson WHERE id = ?', [id]);
    return ParkingPerson.fromMap(maps[0]);
  }

  void updateParkingPerson(ParkingPerson person) {
    _database.execute(
      'UPDATE ParkingPerson SET firstName = ?, lastName = ?, email = ?, phone = ? WHERE id = ?',
      [person.getFirstName(), person.getLastName(), person.getEmail(), person.getPhone(), person.getID()],
    );
  }

  void deleteParkingPerson(int id) {
    _database.execute('DELETE FROM ParkingPerson WHERE id = ?', [id]);
  }

  /// A private method that checks the latest ID in the person table and returns the next ID.
  int _getNextPersonID() {
    final List<Map<String, dynamic>> maps = _database.select('SELECT MAX(id) FROM ParkingPerson');
    return maps[0]['MAX(id)'] + 1;
  }

  int _getCurrentPersonID() {
    final List<Map<String, dynamic>> maps = _database.select('SELECT MAX(id) FROM ParkingPerson');
    return maps[0]['MAX(id)'];
  }

  // Vehicle methods
  void addParkingVehicle(ParkingVehicle vehicle) {
    vehicle.setID(_getNextVehicleID());
    _database.execute(
      'INSERT INTO ParkingVehicle (numberPlate, vehicleType) VALUES (?, ?)',
      [vehicle.getNumberPlate(), vehicle.getVehicleType()],
    );
  }

  int _getNextVehicleID() {
    final List<Map<String, dynamic>> maps = _database.select('SELECT MAX(id) FROM ParkingVehicle');
    return maps[0]['MAX(id)'] + 1;
  }

  void updateParkingVehicle(ParkingVehicle vehicle) {
    _database.execute(
      'UPDATE ParkingVehicle SET numberPlate = ?, vehicleType = ? WHERE id = ?',
      [vehicle.getNumberPlate(), vehicle.getVehicleType(), vehicle.getID()],
    );
  }

  void deleteParkingVehicle(int id) {
    _database.execute('DELETE FROM ParkingVehicle WHERE id = ?', [id]);
  }

  ParkingVehicle getParkingVehicle(int id) {
    final List<Map<String, dynamic>> maps = _database.select('SELECT * FROM ParkingVehicle WHERE id = ?', [id]);
    ParkingVehicle vehicle = ParkingVehicle(
        numberPlate: maps[0]['numberPlate'],
        vehicleType: maps[0]['vehicleType']
    );
    return vehicle;
  }

  List<ParkingVehicle> getParkingVehicles() {
    List<ParkingVehicle> vehicles = [];
    for (int i = 1; i < _getCurrentVehicleID(); i++) {
      vehicles.add(getParkingVehicle(i));
    }
    return vehicles;
  }

  int _getCurrentVehicleID() {
    final List<Map<String, dynamic>> maps = _database.select('SELECT MAX(id) FROM ParkingVehicle');
    return maps[0]['MAX(id)'];
  }
  ///Vehicle methods end

  ///ParkingSpace methods
  void addParkingSpace(ParkingSpace space) {
    space.setID(_getNextSpaceID());
    _database.execute(
      'INSERT INTO ParkingSpace (isOccupied, location, type, minuteRate) VALUES (?, ?, ?, ?)',
      [space.getIsOccupied() ? 1 : 0, space.getLocation(), space.getType(), space.getMinuteRate()],
    );
  }

  int _getNextSpaceID() {
    final List<Map<String, dynamic>> maps = _database.select('SELECT MAX(id) FROM ParkingSpace');
    return maps[0]['MAX(id)'] + 1;
  }

  void updateParkingSpace(ParkingSpace space) {
    _database.execute(
      'UPDATE ParkingSpace SET isOccupied = ?, location = ?, type = ?, minuteRate = ? WHERE id = ?',
      [space.getIsOccupied() ? 1 : 0, space.getLocation(), space.getType(), space.getMinuteRate(), space.getID()],
    );
  }

  void deleteParkingSpace(int id) {
    _database.execute('DELETE FROM ParkingSpace WHERE id = ?', [id]);
  }

  ParkingSpace getParkingSpace(int id) {
    final List<Map<String, dynamic>> maps = _database.select('SELECT * FROM ParkingSpace WHERE id = ?', [id]);
    ParkingSpace space = ParkingSpace(
        isOccupied: maps[0]['isOccupied'] == 1,
        location: maps[0]['location'],
        type: maps[0]['type'],
        minuteRate: maps[0]['minuteRate']
    );
    return space;
  }

  List<ParkingSpace> getParkingSpaces() {
    List<ParkingSpace> spaces = [];
    for (int i = 1; i < _getCurrentSpaceID(); i++) {
      spaces.add(getParkingSpace(i));
    }
    return spaces;
  }

  int _getCurrentSpaceID() {
    final List<Map<String, dynamic>> maps = _database.select('SELECT MAX(id) FROM ParkingSpace');
    return maps[0]['MAX(id)'];
  }
///ParkingSpace methods ends

}