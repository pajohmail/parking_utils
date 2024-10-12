import 'abstract_repository.dart';
import 'parking_vehicle.dart';

/// Repository class for managing `ParkingVehicle` objects.
///
/// This class extends `AbstractRepository` and provides methods to add, retrieve, update, and delete parking vehicles.
class ParkingVehicleRepository extends AbstractRepository<ParkingVehicle> {
  /// List of parking vehicles.
  List<ParkingVehicle> _parkingVehicleList = [];

  /// Static ID counter for parking vehicles.
  static int _parkingVehicleID = 1;

  /// Adds a new parking vehicle to the repository.
  ///
  /// If the parking vehicle does not have an ID, it assigns a new unique ID.
  /// \param item The parking vehicle to add.
  @override
  void add(ParkingVehicle item) {
    item.setID(_parkingVehicleID++);
    _parkingVehicleList.add(item);
  }

  /// Retrieves all parking vehicles from the repository.
  ///
  /// \return A list of all parking vehicles.
  @override
  List<ParkingVehicle> getAll() {
    return _parkingVehicleList;
  }

  /// Retrieves a parking vehicle by its ID.
  ///
  /// \param id The ID of the parking vehicle to retrieve.
  /// \return The parking vehicle with the specified ID, or `null` if not found.
  @override
  ParkingVehicle getById(int id) {
    return _parkingVehicleList.firstWhere((vehicle) => vehicle.getID() == id, orElse: () => null as ParkingVehicle);
  }

  /// Updates an existing parking vehicle in the repository.
  ///
  /// \param item The parking vehicle with updated information.
  @override
  void update(ParkingVehicle item) {
    int index = _parkingVehicleList.indexWhere((vehicle) => vehicle.getID() == item.getID());
    if (index != -1) {
      _parkingVehicleList[index] = item;
    }
  }

  /// Deletes a parking vehicle from the repository.
  ///
  /// \param item The parking vehicle to delete.
  @override
  void delete(ParkingVehicle item) {
    _parkingVehicleList.removeWhere((vehicle) => vehicle.getID() == item.getID());
  }
}