import 'abstract_repository.dart';
import '../parking_item/parking_vehicle.dart';
import "../database/database_helper.dart";
/// Repository class for managing `ParkingVehicle` objects.
///
/// This class extends `AbstractRepository` and provides methods to add, retrieve, update, and delete parking vehicles.
class ParkingVehicleRepository extends AbstractRepository<ParkingVehicle> {
  // add a constructor that takes a database helper  as a parameter and assigns it to a private field
  /// Constructor for `ParkingVehicleRepository`
  ParkingVehicleRepository(this._databaseHelper);
  final DatabaseHelper _databaseHelper; // Add a private field for DatabaseHelper

  /// Static ID counter for parking vehicles.
  static int _parkingVehicleID = 1;

  /// Adds a new parking vehicle to the repository.
  ///
  /// If the parking vehicle does not have an ID, it assigns a new unique ID.
  /// \param item The parking vehicle to add.
  @override
  Future<void> add(ParkingVehicle vehicle) async {
    vehicle.setID(_parkingVehicleID++);
    _databaseHelper.addParkingVehicle(vehicle);
  }

  /// Retrieves all parking vehicles from the repository.
  ///
  /// \return A list of all parking vehicles.
  @override
  Future<List<ParkingVehicle>> getAll() async {
    List<ParkingVehicle> parkingVehicleList = [];
    parkingVehicleList = _databaseHelper.getParkingVehicles();
    return parkingVehicleList;
  }

  /// Retrieves a parking vehicle by its ID.
  ///
  /// \param id The ID of the parking vehicle to retrieve.
  /// \return The parking vehicle with the specified ID, or `null` if not found.
  @override
  Future<ParkingVehicle?> getById(int id) async {
    _databaseHelper.getParkingVehicle(id);
  }

  /// Updates an existing parking vehicle in the repository.
  ///
  /// \param item The parking vehicle with updated information.
  @override
  Future<void> update(ParkingVehicle item) async {
    _databaseHelper.updateParkingVehicle(item);
  }

  /// Deletes a parking vehicle from the repository.
  ///
  /// \param item The parking vehicle to delete.
  @override
  Future<void> delete(ParkingVehicle item) async {
    _databaseHelper.deleteParkingVehicle(item.getID());
}
}