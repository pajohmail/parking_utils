import 'parking_space.dart';
import 'abstract_repository.dart';

/// Repository class for managing `ParkingSpace` objects.
///
/// This class extends `AbstractRepository` and provides methods to add, retrieve, update, and delete parking spaces.
class ParkingSpaceRepository extends AbstractRepository<ParkingSpace> {
  /// List of parking spaces.
  List<ParkingSpace> _parkingSpaceList = [];

  /// Static ID counter for parking spaces.
  static int _parkingSpaceID = 1;

  /// Adds a new parking space to the repository.
  ///
  /// If the parking space does not have an ID, it assigns a new unique ID.
  /// \param item The parking space to add.
  @override
  void add(ParkingSpace item) {
    if (item.getID() == 0) {
      item.setID(_parkingSpaceID++);
    }
    _parkingSpaceList.add(item);
  }

  /// Retrieves all parking spaces from the repository.
  ///
  /// \return A list of all parking spaces.
  @override
  List<ParkingSpace> getAll() {
    return _parkingSpaceList;
  }

  /// Retrieves a parking space by its ID.
  ///
  /// \param id The ID of the parking space to retrieve.
  /// \return The parking space with the specified ID, or `null` if not found.
  @override
  ParkingSpace getById(int id) {
    return _parkingSpaceList.firstWhere((space) => space.getID() == id, orElse: () => null as ParkingSpace);
  }

  /// Updates an existing parking space in the repository.
  ///
  /// \param item The parking space with updated information.
  @override
  void update(ParkingSpace item) {
    int index = _parkingSpaceList.indexWhere((space) => space.getID() == item.getID());
    if (index != -1) {
      _parkingSpaceList[index] = item;
    }
  }

  /// Deletes a parking space from the repository.
  ///
  /// \param item The parking space to delete.
  @override
  void delete(ParkingSpace item) {
    _parkingSpaceList.removeWhere((space) => space.getID() == item.getID());
  }
}