import 'ParkingSpace.dart';
import 'AbstractRepository.dart';

class ParkingSpaceRepository extends AbstractRepository<ParkingSpace> {
  List<ParkingSpace> _parkingSpaceList = [];
  static int _ParkingSpaceID = 1;

  @override
  void add(ParkingSpace item) {
    if (item.getID() == 0) {
      item.setID(_ParkingSpaceID);
      _ParkingSpaceID++;
    }
    _parkingSpaceList.add(item);
  }

  @override
  List<ParkingSpace> getAll() {
    return _parkingSpaceList;
  }

  @override
  ParkingSpace getById(int id) {
    return _parkingSpaceList.firstWhere((space) => space.getID() == id);
  }

  @override
  void update(ParkingSpace item) {
    int index = _parkingSpaceList.indexWhere((space) => space.getID() == item.getID());
    if (index != -1) {
      _parkingSpaceList[index] = item;
    }
  }

  @override
  void delete(ParkingSpace item) {
    _parkingSpaceList.removeWhere((space) => space.getID() == item.getID());
  }
}