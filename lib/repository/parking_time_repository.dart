import '../parking_item/parking_time.dart';
import 'abstract_repository.dart';

/// Repository class for managing `ParkingTime` objects.
///
/// This class extends `AbstractRepository` and provides methods to add, retrieve, update, and delete parking times.
class ParkingTimeRepository extends AbstractRepository<ParkingTime> {
  /// List of parking times.
  List<ParkingTime> _parkingTimeList = [];

  /// Static ID counter for parking times.
  static int _parkingTimeID = 1;

  /// Adds a new parking time to the repository.
  ///
  /// If the parking time does not have an ID, it assigns a new unique ID.
  /// \param item The parking time to add.
  @override
  Future<void> add(ParkingTime item) async {
    item.setID(_parkingTimeID++);
    _parkingTimeList.add(item);
  }

  /// Retrieves all parking times from the repository.
  ///
  /// \return A list of all parking times.
  @override
  Future<List<ParkingTime>> getAll() async {
    return _parkingTimeList;
  }

  /// Retrieves a parking time by its ID.
  ///
  /// \param id The ID of the parking time to retrieve.
  /// \return The parking time with the specified ID, or `null` if not found.
  @override
  Future<ParkingTime?> getById(int id) async {
    //return _parkingTimeList.firstWhere((time) => time.getID() == id
       // orElse: () => null);
  }

  /// Updates an existing parking time in the repository.
  ///
  /// \param item The parking time with updated information.
  @override
  Future<void> update(ParkingTime item) async {
    int index =
    _parkingTimeList.indexWhere((time) => time.getID() == item.getID());
    if (index != -1) {
      _parkingTimeList[index] = item;
    }
  }

  /// Deletes a parking time from the repository.
  ///
  /// \param item The parking time to delete.
  @override
  Future<void> delete(ParkingTime item) async {
    _parkingTimeList.removeWhere((time) => time.getID() == item.getID());
  }
}