import 'ParkingTime.dart';
import 'AbstractRepository.dart';

class ParkingTimeRepository extends AbstractRepository<ParkingTime> {
  List<ParkingTime> _parkingTimeList = [];
  static int _parkingTimeID = 1;

  @override
  void add(ParkingTime item) {
    item.setID(_parkingTimeID++);
    _parkingTimeList.add(item);
  }

  @override
  List<ParkingTime> getAll() {
    return _parkingTimeList;
  }

  @override
  ParkingTime? getById(int id) {
    return _parkingTimeList.firstWhere((time) => time.getID() == id, orElse: () => null as ParkingTime);
  }

  @override
  void update(ParkingTime item) {
    int index = _parkingTimeList.indexWhere((time) => time.getID() == item.getID());
    if (index != -1) {
      _parkingTimeList[index] = item;
    }






  }

  @override
  void delete(ParkingTime item) {
    _parkingTimeList.removeWhere((time) => time.getID() == item.getID());
  }
}