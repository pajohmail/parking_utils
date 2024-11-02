import 'package:parking_utils/parking_item/parking_item.dart';

/// An abstract repository class for managing parking items.
///
/// This class provides basic CRUD operations for parking items.
abstract class AbstractRepository<T extends ParkingItem> {
  /// A list to store parking items.
  List<T> _parkingItemList = [];

  /// A static variable to generate unique IDs for parking spaces.
  static int _ParkingSpaceID = 1;

  /// Adds a new parking item to the repository.
  ///
  /// If the item does not have an ID, it assigns a new unique ID.
  ///
  /// \param item The parking item to add.
  Future<void> add(T item) async {
    if (item.getID() == 0) {
      item.setID(_ParkingSpaceID);
      _ParkingSpaceID++;
    }
    _parkingItemList.add(item);
  }

  /// Retrieves all parking items from the repository.
  ///
  /// \return A list of all parking items.
  Future<List<T>> getAll() async {
    return _parkingItemList;
  }

  /// Retrieves a parking item by its ID.
  ///
  /// \param id The ID of the parking item to retrieve.
  /// \return The parking item with the specified ID, or null if not found.
  Future<T?> getById(int id) async {
    return _parkingItemList
        .cast<T?>()
        .firstWhere((space) => space?.getID() == id, orElse: () => null);
  }

  /// Updates an existing parking item in the repository.
  ///
  /// \param item The parking item to update.
  Future<void> update(T item) async {
    int index =
    _parkingItemList.indexWhere((space) => space.getID() == item.getID());
    if (index != -1) {
      _parkingItemList[index] = item;
    }
  }

  /// Deletes a parking item from the repository.
  ///
  /// \param item The parking item to delete.
  Future<void> delete(T item) async {
    _parkingItemList.removeWhere((space) => space.getID() == item.getID());
  }
}