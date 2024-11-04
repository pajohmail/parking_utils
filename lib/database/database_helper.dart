import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:parking_utils/parking_item/parking_person.dart';
import 'package:parking_utils/parking_item/parking_vehicle.dart';
import 'package:parking_utils/parking_item/parking_space.dart';
import 'package:parking_utils/parking_item/parking_time.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'parking_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ParkingPerson (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT,
        lastName TEXT,
        email TEXT,
        phone TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE ParkingVehicle (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        numberPlate TEXT,
        vehicleType TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE ParkingSpace (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        isOccupied INTEGER,
        location TEXT,
        type TEXT,
        minuteRate REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE ParkingTime (
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
  Future<int> addParkingPerson(ParkingPerson person) async {
    final db = await database;
    return await db.insert('ParkingPerson', person.toMap());
  }

  Future<List<ParkingPerson>> getParkingPersons() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('ParkingPerson');
    return List.generate(maps.length, (i) {
      return ParkingPerson.fromMap(maps[i]);
    });
  }

  Future<int> updateParkingPerson(ParkingPerson person) async {
    final db = await database;
    return await db.update(
      'ParkingPerson',
      person.toMap(),
      where: 'id = ?',
      whereArgs: [person.getID()],
    );
  }

  Future<int> deleteParkingPerson(int id) async {
    final db = await database;
    return await db.delete(
      'ParkingPerson',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Methods for ParkingVehicle
  Future<int> addParkingVehicle(ParkingVehicle vehicle) async {
    final db = await database;
    return await db.insert('ParkingVehicle', vehicle.toMap());
  }

  Future<List<ParkingVehicle>> getParkingVehicles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('ParkingVehicle');
    return List.generate(maps.length, (i) {
      return ParkingVehicle.fromMap(maps[i]);
    });
  }

  Future<int> updateParkingVehicle(ParkingVehicle vehicle) async {
    final db = await database;
    return await db.update(
      'ParkingVehicle',
      vehicle.toMap(),
      where: 'id = ?',
      whereArgs: [vehicle.id],
    );
  }

  Future<int> deleteParkingVehicle(int id) async {
    final db = await database;
    return await db.delete(
      'ParkingVehicle',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Methods for ParkingSpace
  Future<int> addParkingSpace(ParkingSpace space) async {
    final db = await database;
    return await db.insert('ParkingSpace', space.toMap());
  }

  Future<List<ParkingSpace>> getParkingSpaces() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('ParkingSpace');
    return List.generate(maps.length, (i) {
      return ParkingSpace.fromMap(maps[i]);
    });
  }

  Future<int> updateParkingSpace(ParkingSpace space) async {
    final db = await database;
    return await db.update(
      'ParkingSpace',
      space.toMap(),
      where: 'id = ?',
      whereArgs: [space.id],
    );
  }

  Future<int> deleteParkingSpace(int id) async {
    final db = await database;
    return await db.delete(
      'ParkingSpace',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Methods for ParkingTime
  Future<int> addParkingTime(ParkingTime time) async {
    final db = await database;
    return await db.insert('ParkingTime', time.toMap());
  }

  Future<List<ParkingTime>> getParkingTimes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('ParkingTime');
    return List.generate(maps.length, (i) {
      return ParkingTime.fromMap(maps[i]);
    });
  }

  Future<int> updateParkingTime(ParkingTime time) async {
    final db = await database;
    return await db.update(
      'ParkingTime',
      time.toMap(),
      where: 'id = ?',
      whereArgs: [time.id],
    );
  }

  Future<int> deleteParkingTime(int id) async {
    final db = await database;
    return await db.delete(
      'ParkingTime',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class ParkingVehicle {
  int id;
  String numberPlate;
  String vehicleType;

  ParkingVehicle({required this.id, required this.numberPlate, required this.vehicleType});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'numberPlate': numberPlate,
      'vehicleType': vehicleType,
    };
  }

  static ParkingVehicle fromMap(Map<String, dynamic> map) {
    return ParkingVehicle(
      id: map['id'],
      numberPlate: map['numberPlate'],
      vehicleType: map['vehicleType'],
    );
  }

  int get getId => id;
}

class ParkingSpace {
  int id;
  bool isOccupied;
  String location;
  String type;
  double minuteRate;

  ParkingSpace({required this.id, required this.isOccupied, required this.location, required this.type, required this.minuteRate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isOccupied': isOccupied ? 1 : 0,
      'location': location,
      'type': type,
      'minuteRate': minuteRate,
    };
  }

  static ParkingSpace fromMap(Map<String, dynamic> map) {
    return ParkingSpace(
      id: map['id'],
      isOccupied: map['isOccupied'] == 1,
      location: map['location'],
      type: map['type'],
      minuteRate: map['minuteRate'],
    );
  }

  int get getId => id;
}

class ParkingTime {
  int id;
  String startTime;
  String endTime;
  int personID;
  int spaceID;
  int vehicleID;
  bool isActive;

  ParkingTime({required this.id, required this.startTime, required this.endTime, required this.personID, required this.spaceID, required this.vehicleID, required this.isActive});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startTime': startTime,
      'endTime': endTime,
      'personID': personID,
      'spaceID': spaceID,
      'vehicleID': vehicleID,
      'isActive': isActive ? 1 : 0,
    };
  }

  static ParkingTime fromMap(Map<String, dynamic> map) {
    return ParkingTime(
      id: map['id'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      personID: map['personID'],
      spaceID: map['spaceID'],
      vehicleID: map['vehicleID'],
      isActive: map['isActive'] == 1,
    );
  }

  int get getId => id;
}