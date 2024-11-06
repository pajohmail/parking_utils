import '../parking_item/parking_space.dart';
import 'abstract_repository.dart';
import "../database/database_helper.dart";
/// Repository class for managing `ParkingSpace` objects.
///
/// This class extends `AbstractRepository` and provides methods to add, retrieve, update, and delete parking spaces.
class ParkingSpaceRepository extends AbstractRepository<ParkingSpace> {
  /// Constructor for `ParkingSpaceRepository takes a database helper  as a parameter and assigns it to a private field
  ParkingSpaceRepository(this._databaseHelper);
  final DatabaseHelper _databaseHelper; // Add a private field for DatabaseHelper




  /// Static ID counter for parking spaces.
  static int _parkingSpaceID = 1;

  /// Adds a new parking space to the repository.
  ///
  /// If the parking space does not have an ID, it assigns a new unique ID.
  /// \param item The parking space to add.
  @override
  Future<void> add(ParkingSpace item) async {
    item.setID(_parkingSpaceID++);
    _databaseHelper.addParkingSpace(item);
  }

  /// Retrieves all parking spaces from the repository.
  ///
  /// \return A list of all parking spaces.
  @override
  Future<List<ParkingSpace>> getAll() async {
    List<ParkingSpace> parkingSpaceList = [];
    parkingSpaceList = _databaseHelper.getParkingSpaces();
    return parkingSpaceList;
  }

  /// Retrieves a parking space by its ID.
  ///
  /// \param id The ID of the parking space to retrieve.
  /// \return The parking space with the specified ID, or `null` if not found.
  @override
  Future<ParkingSpace?> getById(int id) async {
    _databaseHelper.getParkingSpace(id);
  }

  /// Updates an existing parking space in the repository.
  ///
  /// \param item The parking space with updated information.
  @override
  Future<void> update(ParkingSpace item) async {
    _databaseHelper.updateParkingSpace(item);
  }

  /// Deletes a parking space from the repository.
  ///
  /// \param item The parking space to delete.
  @override
  Future<void> delete(ParkingSpace item) async {
    _databaseHelper.deleteParkingSpace(item.getID());
  }
}