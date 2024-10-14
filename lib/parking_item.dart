/// An abstract class representing a parking item.
///
/// This class provides basic functionality for managing the ID of a parking item.
abstract class ParkingItem {
  /// The unique identifier for the parking item.
  int _id = 0;

  /// Sets the ID of the parking item.
  ///
  /// \param id The new ID to set.
  void setID(int id) {
    this._id = id;
  }

  /// Gets the ID of the parking item.
  ///
  /// \return The current ID of the parking item.
  int getID() {
    return this._id;
  }
}
