import 'package:parking_utils/parking_item/parking_person.dart';
import 'package:parking_utils/repository/parking_person_repository.dart';
import 'package:parking_utils/parking_item/parking_space.dart';
import 'package:parking_utils/repository/parking_space_repository.dart';
import 'package:parking_utils/parking_item/parking_time.dart';
import 'package:parking_utils/repository/parking_time_repository.dart';
import 'package:parking_utils/parking_item/parking_vehicle.dart';
import 'package:parking_utils/repository/parking_vehicle_repository.dart';
import 'package:parking_utils/repository/payment_handler.dart';
import 'dart:async';

/// A control class based on the singleton pattern.
///
/// This class controls access to the child classes of `AbstractRepository`
/// and ensures that only one instance of the repository classes is created.
/// It also minimizes logic in the `CLIDialog` class.
class WatchTower {
  /// The singleton instance of `WatchTower`.
  static WatchTower? _instance;

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

  /// Timer for periodically running tasks.
  Timer? _timer;

  /// Private constructor for `WatchTower`.
  ///
  /// Initializes the timer to run `controlParkingTimes` every minute.
  WatchTower._internal() {
    _startTimer();
  }

  /// Factory constructor for `WatchTower`.
  ///
  /// Ensures that only one instance of `WatchTower` is created.
  factory WatchTower() {
    if (_instance == null) {
      _instance = WatchTower._internal();
    }
    return _instance!;
  }

  /// Starts a timer that calls `controlParkingTimes` every minute.
  void _startTimer() {
    _timer = Timer.periodic(
        Duration(minutes: 1), (Timer t) => controlParkingTimes());
  }

  /// Edits a parking session based on the given ID and new end time.
  ///
  /// \param id The ID of the parking session to edit.
  /// \param endTime The new end time for the parking session.
  Future<void> editParkingSession(int id, DateTime endTime) async {
    ParkingTime? time = await getTimeById(id);
    if (time != null) {
      time.endTime = endTime;
      await updateTime(time);
    }
  }

  /// Ends the parking session for a given ID and processes the refund.
  ///
  /// \param id The ID of the parking session to end.
  Future<void> endParkingSession(int id) async {
    ParkingTime? time = await getTimeById(id);
    if (time != null) {
      time.isActive = false;
      await updateTime(time);
    }
  }

  /// Controls the parking times by deactivating expired parking times.
  ///
  /// Retrieves all parking times from the repository and deactivates those
  /// that have expired.
  Future<void> controlParkingTimes() async {
    List<ParkingTime> times = await _timeRepository.getAll();
    DateTime now = DateTime.now();
    for (ParkingTime time in times) {
      if (time.isActive && time.endTime.isBefore(now)) {
        time.isActive = false;
        await _timeRepository.update(time);
      }
    }
  }

  /// Creates a payment for parking.
  ///
  /// \param minutePrice The price per minute of parking.
  /// \param minutes The number of minutes parked.
  /// \param parkingPersonPhoneNumber The phone number of the person paying for parking.
  /// \return A `Future` that resolves to `true` if the payment is successful, otherwise `false`.
  Future<bool> createPayment(
      double minutePrice, int minutes, String parkingPersonPhoneNumber) async {
    double total = minutePrice * minutes;
    return await _paymentHandler.pay(parkingPersonPhoneNumber, total);
  }

  /// Adds a new person to the repository.
  ///
  /// \param person The `ParkingPerson` to add.
  Future<void> addPerson(ParkingPerson person) async {
    await _personRepository.add(person);
  }

  /// Retrieves all persons from the repository.
  ///
  /// \return A list of all `ParkingPerson` objects.
  Future<List<ParkingPerson>> getAllPersons() async {
    return await _personRepository.getAll();
  }

  /// Retrieves a person by their ID.
  ///
  /// \param id The ID of the person to retrieve.
  /// \return The `ParkingPerson` with the specified ID, or `null` if not found.
  Future<ParkingPerson?> getPersonById(int id) async {
    return await _personRepository.getById(id);
  }

  /// Updates an existing person in the repository.
  ///
  /// \param person The `ParkingPerson` with updated information.
  Future<void> updatePerson(ParkingPerson person) async {
    await _personRepository.update(person);
  }

  /// Deletes a person from the repository.
  ///
  /// \param person The `ParkingPerson` to delete.
  Future<void> deletePerson(ParkingPerson person) async {
    await _personRepository.delete(person);
  }

  /// Adds a new parking space to the repository.
  ///
  /// \param space The `ParkingSpace` to add.
  Future<void> addSpace(ParkingSpace space) async {
    await _spaceRepository.add(space);
  }

  /// Retrieves all parking spaces from the repository.
  ///
  /// \return A list of all `ParkingSpace` objects.
  Future<List<ParkingSpace>> getAllSpaces() async {
    return await _spaceRepository.getAll();
  }

  /// Retrieves a parking space by its ID.
  ///
  /// \param id The ID of the parking space to retrieve.
  /// \return The `ParkingSpace` with the specified ID, or `null` if not found.
  Future<ParkingSpace?> getSpaceById(int id) async {
    return await _spaceRepository.getById(id);
  }

  /// Updates an existing parking space in the repository.
  ///
  /// \param space The `ParkingSpace` with updated information.
  Future<void> updateSpace(ParkingSpace space) async {
    await _spaceRepository.update(space);
  }

  /// Deletes a parking space from the repository.
  ///
  /// \param space The `ParkingSpace` to delete.
  Future<void> deleteSpace(ParkingSpace space) async {
    await _spaceRepository.delete(space);
  }

  /// Adds a new parking time to the repository.
  ///
  /// \param time The `ParkingTime` to add.
  Future<void> addTime(ParkingTime time) async {
    await _timeRepository.add(time);
  }

  /// Retrieves all parking times from the repository.
  ///
  /// \return A list of all `ParkingTime` objects.
  Future<List<ParkingTime>> getAllTimes() async {
    return await _timeRepository.getAll();
  }

  /// Retrieves a parking time by its ID.
  ///
  /// \param id The ID of the parking time to retrieve.
  /// \return The `ParkingTime` with the specified ID, or `null` if not found.
  Future<ParkingTime?> getTimeById(int id) async {
    return await _timeRepository.getById(id);
  }

  /// Updates an existing parking time in the repository.
  ///
  /// \param time The `ParkingTime` with updated information.
  Future<void> updateTime(ParkingTime time) async {
    await _timeRepository.update(time);
  }

  /// Deletes a parking time from the repository.
  ///
  /// \param time The `ParkingTime` to delete.
  Future<void> deleteTime(ParkingTime time) async {
    await _timeRepository.delete(time);
  }

  /// Adds a new parking vehicle to the repository.
  ///
  /// \param vehicle The `ParkingVehicle` to add.
  Future<void> addVehicle(ParkingVehicle vehicle) async {
    await _vehicleRepository.add(vehicle);
  }

  /// Retrieves all parking vehicles from the repository.
  ///
  /// \return A list of all `ParkingVehicle` objects.
  Future<List<ParkingVehicle>> getAllVehicles() async {
    return await _vehicleRepository.getAll();
  }

  /// Retrieves a parking vehicle by its ID.
  ///
  /// \param id The ID of the parking vehicle to retrieve.
  /// \return The `ParkingVehicle` with the specified ID, or `null` if not found.
  Future<ParkingVehicle?> getVehicleById(int id) async {
    return await _vehicleRepository.getById(id);
  }

  /// Updates an existing parking vehicle in the repository.
  ///
  /// \param vehicle The `ParkingVehicle` with updated information.
  Future<void> updateVehicle(ParkingVehicle vehicle) async {
    await _vehicleRepository.update(vehicle);
  }

  /// Deletes a parking vehicle from the repository.
  ///
  /// \param vehicle The `ParkingVehicle` to delete.
  Future<void> deleteVehicle(ParkingVehicle vehicle) async {
    await _vehicleRepository.delete(vehicle);
  }
}