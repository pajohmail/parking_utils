import 'package:parking_utils/ParkingItem.dart';

abstract class AbstractRepository<T extends ParkingItem> {
 List<T> _parkingItemList = [];
 static int _ParkingSpaceID = 1;

 void add(T item) {
  if (item.getID() == 0) {
   item.setID(_ParkingSpaceID);
   _ParkingSpaceID++;
  }
  _parkingItemList.add(item);
 }

 List<T> getAll() {
  return _parkingItemList;
 }

 T? getById(int id) {
  return _parkingItemList.cast<T?>().firstWhere((space) => space?.getID() == id, orElse: () => null);
 }

 void update(T item) {
  int index = _parkingItemList.indexWhere((space) => space.getID() == item.getID());
  if (index != -1) {
   _parkingItemList[index] = item;
  }
 }

 void delete(T item) {
  _parkingItemList.removeWhere((space) => space.getID() == item.getID());
 }
}