import 'package:parking_utils/parking_person.dart';
import 'package:parking_utils/parking_person_repository.dart';
import 'package:parking_utils/parking_space.dart';
import 'package:parking_utils/parking_space_repository.dart';
import 'package:parking_utils/parking_time.dart';
import 'package:parking_utils/parking_time_repository.dart';
import 'package:parking_utils/parking_vehicle.dart';
import 'package:parking_utils/parking_vehicle_repository.dart';
import 'package:parking_utils/payment_handler.dart';

/// A control class based on the singleton pattern.
///
/// This class controls access to the child classes of `AbstractRepository`
/// and ensures that only one instance of the repository classes is created.
/// It also minimizes logic in the `CLIDialog` class.
class WatchTower {
  /// The singleton instance of `WatchTower`.
  static WatchTower? _instance;

  /// Private constructor for `WatchTower`.
  WatchTower._internal();

  /// Factory constructor for `WatchTower`.
  ///
  /// Ensures that only one instance of `WatchTower` is created.
  factory WatchTower() {
    if (_instance == null) {
      _instance = WatchTower._internal();
    }
    return _instance!;
  }

  /// Repository for managing `ParkingPerson` objects.
  final _personRepository = ParkingPersonRepository();

  /// Repository for managing `ParkingSpace` objects.
  final _spaceRepository = ParkingSpaceRepository();

  /// Repository for managing `ParkingTime` objects.
  final _timeRepository = ParkingTimeRepository();

  /// Repository for managing `ParkingVehicle` objects.
  final _vehicleRepository = ParkingVehicleRepository();

  /// Handler for processing payments.
  final _paymentHandler = PaymentHandler();

  /// Creates a payment for parking.
  ///
  /// \param minutePrice The price per minute of parking.
  /// \param minutes The number of minutes parked.
  /// \param parkingPersonPhoneNumber The phone number of the person paying for parking.
  /// \return A `Future` that resolves to `true` if the payment is successful, otherwise `false`.
  Future<bool> createPayment(double minutePrice, int minutes, String parkingPersonPhoneNumber) {
    double total = minutePrice * minutes;
    return _paymentHandler.pay(parkingPersonPhoneNumber, total);
  }

  /// Adds a new person to the repository.
  ///
  /// \param person The `ParkingPerson` to add.
  void addPerson(ParkingPerson person) {
    _personRepository.add(person);
  }

  /// Retrieves all persons from the repository.
  ///
  /// \return A list of all `ParkingPerson` objects.
  List<ParkingPerson> getAllPersons() {
    return _personRepository.getAll();
  }

  /// Retrieves a person by their ID.
  ///
  /// \param id The ID of the person to retrieve.
  /// \return The `ParkingPerson` with the specified ID, or `null` if not found.
  ParkingPerson? getPersonById(int id) {
    return _personRepository.getById(id);
  }

  /// Updates an existing person in the repository.
  ///
  /// \param person The `ParkingPerson` with updated information.
  void updatePerson(ParkingPerson person) {
    _personRepository.update(person);
  }

  /// Deletes a person from the repository.
  ///
  /// \param person The `ParkingPerson` to delete.
  void deletePerson(ParkingPerson person) {
    _personRepository.delete(person);
  }

  /// Adds a new parking space to the repository.
  ///
  /// \param space The `ParkingSpace` to add.
  void addSpace(ParkingSpace space) {
    _spaceRepository.add(space);
  }

  /// Retrieves all parking spaces from the repository.
  ///
  /// \return A list of all `ParkingSpace` objects.
  List<ParkingSpace> getAllSpaces() {
    return _spaceRepository.getAll();
  }

  /// Retrieves a parking space by its ID.
  ///
  /// \param id The ID of the parking space to retrieve.
  /// \return The `ParkingSpace` with the specified ID, or `null` if not found.
  ParkingSpace? getSpaceById(int id) {
    return _spaceRepository.getById(id);
  }

  /// Updates an existing parking space in the repository.
  ///
  /// \param space The `ParkingSpace` with updated information.
  void updateSpace(ParkingSpace space) {
    _spaceRepository.update(space);
  }

  /// Deletes a parking space from the repository.
  ///
  /// \param space The `ParkingSpace` to delete.
  void deleteSpace(ParkingSpace space) {
    _spaceRepository.delete(space);
  }

  /// Adds a new parking time to the repository.
  ///
  /// \param time The `ParkingTime` to add.
  void addTime(ParkingTime time) {
    _timeRepository.add(time);
  }

  /// Retrieves all parking times from the repository.
  ///
  /// \return A list of all `ParkingTime` objects.
  List<ParkingTime> getAllTimes() {
    return _timeRepository.getAll();
  }

  /// Retrieves a parking time by its ID.
  ///
  /// \param id The ID of the parking time to retrieve.
  /// \return The `ParkingTime` with the specified ID, or `null` if not found.
  ParkingTime? getTimeById(int id) {
    return _timeRepository.getById(id);
  }

  /// Updates an existing parking time in the repository.
  ///
  /// \param time The `ParkingTime` with updated information.
  void updateTime(ParkingTime time) {
    _timeRepository.update(time);
  }

  /// Deletes a parking time from the repository.
  ///
  /// \param time The `ParkingTime` to delete.
  void deleteTime(ParkingTime time) {
    _timeRepository.delete(time);
  }

  /// Adds a new parking vehicle to the repository.
  ///
  /// \param vehicle The `ParkingVehicle` to add.
  void addVehicle(ParkingVehicle vehicle) {
    _vehicleRepository.add(vehicle);
  }

  /// Retrieves all parking vehicles from the repository.
  ///
  /// \return A list of all `ParkingVehicle` objects.
  List<ParkingVehicle> getAllVehicles() {
    return _vehicleRepository.getAll();
  }

  /// Retrieves a parking vehicle by its ID.
  ///
  /// \param id The ID of the parking vehicle to retrieve.
  /// \return The `ParkingVehicle` with the specified ID, or `null` if not found.
  ParkingVehicle? getVehicleById(int id) {
    return _vehicleRepository.getById(id);
  }

  /// Updates an existing parking vehicle in the repository.
  ///
  /// \param vehicle The `ParkingVehicle` with updated information.
  void updateVehicle(ParkingVehicle vehicle) {
    _vehicleRepository.update(vehicle);
  }

  /// Deletes a parking vehicle from the repository.
  ///
  /// \param vehicle The `ParkingVehicle` to delete.
  void deleteVehicle(ParkingVehicle vehicle) {
    _vehicleRepository.delete(vehicle);
  }
}