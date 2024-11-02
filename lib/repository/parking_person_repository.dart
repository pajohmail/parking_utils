import 'package:parking_utils/repository/abstract_repository.dart';
import 'package:parking_utils/parking_item/parking_person.dart';

/// Repository class for managing `ParkingPerson` objects.
class ParkingPersonRepository extends AbstractRepository<ParkingPerson> {
  List<ParkingPerson> _parkingPersonList = [];
  static int _ParkingPersonID = 1;

  /// Adds a `ParkingPerson` to the repository.
  ///
  /// If the `ParkingPerson` has an ID of 0, it assigns a new unique ID.
  ///
  /// [item] - The `ParkingPerson` to add.
  @override
  Future<void> add(ParkingPerson item) async {
    if (item.getID() == 0) {
      item.setID(_ParkingPersonID);
      _ParkingPersonID++;
    }
    _parkingPersonList.add(item);
  }

  /// Retrieves all `ParkingPerson` objects from the repository.
  ///
  /// Returns a list of all `ParkingPerson` objects.
  @override
  Future<List<ParkingPerson>> getAll() async {
    return _parkingPersonList;
  }

  /// Retrieves a `ParkingPerson` by its ID.
  ///
  /// [id] - The ID of the `ParkingPerson` to retrieve.
  ///
  /// Returns the `ParkingPerson` with the specified ID.
  @override
  Future<ParkingPerson?> getById(int id) async {
    //return _parkingPersonList.firstWhere((person) => person.getID() == id, orElse: () => null);
  }

  /// Updates an existing `ParkingPerson` in the repository.
  ///
  /// [item] - The `ParkingPerson` with updated information.
  @override
  Future<void> update(ParkingPerson item) async {
    int index = _parkingPersonList.indexWhere((person) => person.getID() == item.getID());
    if (index != -1) {
      _parkingPersonList[index] = item;
    }
  }

  /// Deletes a `ParkingPerson` from the repository.
  ///
  /// [item] - The `ParkingPerson` to delete.
  @override
  Future<void> delete(ParkingPerson item) async {
    _parkingPersonList.removeWhere((person) => person.getID() == item.getID());
  }
}