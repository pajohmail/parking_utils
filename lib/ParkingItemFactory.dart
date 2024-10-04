import 'package:parking_utils/ParkingItem.dart';

abstract class ParkingItemFactory {
  static ParkingItem? create() {
    // Implementation for creating ParkingItem based on type
    return null;
  }
  static change(ParkingItem item) {
    // Implementation for changing type of ParkingItem
  }
  static delete(ParkingItem item) {
    // Implementation for deleting ParkingItem
  }
}