import 'package:parking_utils/parking_item/parking_person.dart';
import 'package:parking_utils/repository/parking_person_repository.dart';
import 'package:parking_utils/parking_item/parking_space.dart' as item;
import 'package:parking_utils/repository/parking_space_repository.dart';
import 'package:parking_utils/parking_item/parking_time.dart' as item;
import 'package:parking_utils/repository/parking_time_repository.dart';
import 'package:parking_utils/parking_item/parking_vehicle.dart';
import 'package:parking_utils/repository/parking_vehicle_repository.dart';
import 'package:parking_utils/repository/payment_handler.dart';
import 'package:parking_utils/database/database_helper.dart' as db;
import 'dart:async';

class WatchTowerServer {
  static WatchTowerServer? _instance;

  final db.DatabaseHelper _databaseHelper;
  late final ParkingPersonRepository _personRepository;
  final ParkingSpaceRepository _spaceRepository = ParkingSpaceRepository();
  final ParkingTimeRepository _timeRepository = ParkingTimeRepository();
  final ParkingVehicleRepository _vehicleRepository = ParkingVehicleRepository();
  final PaymentHandler _paymentHandler = PaymentHandler();
  Timer? _timer;

  WatchTowerServer._internal() : _databaseHelper = db.DatabaseHelper() {
    _personRepository = ParkingPersonRepository(_databaseHelper);
    _startTimer();
  }

  factory WatchTowerServer() {
    if (_instance == null) {
      _instance = WatchTowerServer._internal();
    }
    return _instance!;
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(minutes: 1), (Timer t) => controlParkingTimes());
  }

  Future<void> editParkingSession(int id, DateTime endTime) async {
    item.ParkingTime? time = await getTimeById(id);
    if (time != null) {
      time.setEndTime(endTime);
      await updateTime(time);
    }
  }

  Future<void> endParkingSession(int id) async {
    item.ParkingTime? time = await getTimeById(id);
    if (time != null) {
      time.setIsActive(false);
      await updateTime(time);
    }
  }

  Future<void> controlParkingTimes() async {
    List<item.ParkingTime> times = await _timeRepository.getAll();
    DateTime now = DateTime.now();
    for (item.ParkingTime time in times) {
      if (time.isActive() && time.getEndTime().isBefore(now)) {
        time.setIsActive(false);
        await _timeRepository.update(time);
      }
    }
  }

  Future<bool> createPayment(double minutePrice, int minutes, String parkingPersonPhoneNumber) async {
    double total = minutePrice * minutes;
    return await _paymentHandler.pay(parkingPersonPhoneNumber, total);
  }

  Future<void> addPerson(ParkingPerson person) async {
    await _personRepository.add(person);
  }

  Future<List<ParkingPerson>> getAllPersons() async {
    List<ParkingPerson> persons = await _personRepository.getAll();
    return  persons;
  }

  Future<ParkingPerson?> getPersonById(int id) async {
    return await _personRepository.getById(id);
  }

  Future<void> updatePerson(ParkingPerson person) async {
    await _personRepository.update(person);
  }

  Future<void> deletePerson(ParkingPerson person) async {
    await _personRepository.delete(person);
  }

  Future<void> addSpace(item.ParkingSpace space) async {
    await _spaceRepository.add(space);
  }

  Future<List<item.ParkingSpace>> getAllSpaces() async {
    return await _spaceRepository.getAll();
  }

  Future<item.ParkingSpace?> getSpaceById(int id) async {
    return await _spaceRepository.getById(id);
  }

  Future<void> updateSpace(item.ParkingSpace space) async {
    await _spaceRepository.update(space);
  }

  Future<void> deleteSpace(item.ParkingSpace space) async {
    await _spaceRepository.delete(space);
  }

  Future<void> addTime(item.ParkingTime time) async {
    await _timeRepository.add(time);
  }

  Future<List<item.ParkingTime>> getAllTimes() async {
    return await _timeRepository.getAll();
  }

  Future<item.ParkingTime?> getTimeById(int id) async {
    return await _timeRepository.getById(id);
  }

  Future<void> updateTime(item.ParkingTime time) async {
    await _timeRepository.update(time);
  }

  Future<void> deleteTime(item.ParkingTime time) async {
    await _timeRepository.delete(time);
  }

  Future<void> addVehicle(ParkingVehicle vehicle) async {
    await _vehicleRepository.add(vehicle);
  }

  Future<List<ParkingVehicle>> getAllVehicles() async {
    return await _vehicleRepository.getAll();
  }

  Future<ParkingVehicle?> getVehicleById(int id) async {
    return await _vehicleRepository.getById(id);
  }

  Future<void> updateVehicle(ParkingVehicle vehicle) async {
    await _vehicleRepository.update(vehicle);
  }

  Future<void> deleteVehicle(ParkingVehicle vehicle) async {
    await _vehicleRepository.delete(vehicle);
  }
}