import 'package:parking_utils/ParkingItem.dart';

abstract class AbstractRepository<T> {
 List<ParkingItem> _parkingItemList = [];
 static int _ParkingSpaceID = 1;

 void add(ParkingItem item) {
  if (item.getID() == 0) {
   item.setID(_ParkingSpaceID);
   _ParkingSpaceID++;
  }
  _parkingItemList.add(item);
 }



  List<T> getAll();
  T getById(int id);
  void update(T item);
  void delete(T item);
}