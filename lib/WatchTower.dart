import 'package:parking_utils/ParkingPerson.dart';
import 'package:parking_utils/ParkingPersonRepository.dart';
import 'package:parking_utils/ParkingSpace.dart';
import 'package:parking_utils/ParkingSpaceRepository.dart';
import 'package:parking_utils/ParkingTime.dart';
import 'package:parking_utils/ParkingTimeRepository.dart';
import 'package:parking_utils/ParkingVehicle.dart';
import 'package:parking_utils/ParkingVehicleRepository.dart';

class WatchTower {
  // a control class that is based on singleton pattern. It controls the access to
  // the child classes of AbstractRepository class. It is used to ensure that only
  // one instance of the repository classes is created. And minimize logic in the CLIDialog class.
  static WatchTower? _instance;
  WatchTower._internal();
  factory WatchTower() {
    if (_instance == null) {
      _instance = WatchTower._internal();
    }
    return _instance!;
  }

  final _personRepository = ParkingPersonRepository();
  final _spaceRepository = ParkingSpaceRepository();
  final _timeRepository = ParkingTimeRepository();
  final _vehicleRepository = ParkingVehicleRepository();

 void addPerson(ParkingPerson person) {
    _personRepository.add(person);
  }
  List<ParkingPerson> getAllPersons() {
    return _personRepository.getAll();
  }
  ParkingPerson? getPersonById(int id) {
    return _personRepository.getById(id);
  }
  void updatePerson(ParkingPerson person) {
    _personRepository.update(person);
  }
  void deletePerson(ParkingPerson person) {
    _personRepository.delete(person);
  }

  // _spaceRepository
  void addSpace(ParkingSpace space) {
    _spaceRepository.add(space);
  }
  List<ParkingSpace> getAllSpaces() {
    return _spaceRepository.getAll();
  }
  ParkingSpace? getSpaceById(int id) {
    return _spaceRepository.getById(id);
  }
  void updateSpace(ParkingSpace space) {
    _spaceRepository.update(space);
  }
  void deleteSpace(ParkingSpace space) {
    _spaceRepository.delete(space);
  }

  // _timeRepository
  void addTime(ParkingTime time) {
    _timeRepository.add(time);
  }
  List<ParkingTime> getAllTimes() {
    return _timeRepository.getAll();
  }
  ParkingTime? getTimeById(int id) {
    return _timeRepository.getById(id);
  }
  void updateTime(ParkingTime time) {
    _timeRepository.update(time);
  }
  void deleteTime(ParkingTime time) {
    _timeRepository.delete(time);
  }

  // _vehicleRepository
  void addVehicle(ParkingVehicle vehicle) {
    _vehicleRepository.add(vehicle);
  }
  List<ParkingVehicle> getAllVehicles() {
    return _vehicleRepository.getAll();
  }
  ParkingVehicle? getVehicleById(int id) {
    return _vehicleRepository.getById(id);
  }
  void updateVehicle(ParkingVehicle vehicle) {
    _vehicleRepository.update(vehicle);
  }
  void deleteVehicle(ParkingVehicle vehicle) {
    _vehicleRepository.delete(vehicle);
  }



}