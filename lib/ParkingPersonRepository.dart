import 'package:parking_utils/RepositoryInterface.dart';
import 'package:parking_utils/ParkingPerson.dart';

class ParkingPersonRepository extends RepositoryInterface<ParkingPerson> {
  List<ParkingPerson> _parkingPersonList = [];
  static int _ParkingPersonID = 1;

  @override
  void add(ParkingPerson item) {
    if (item.getID() == 0) {
      item.setID(_ParkingPersonID);
      _ParkingPersonID++;
    }
    _parkingPersonList.add(item);
  }


  @override
  List<ParkingPerson> getAll() {
    return _parkingPersonList;
  }

  @override
  ParkingPerson getById(int id) {
    return _parkingPersonList.firstWhere((person) => person.getID() == id);
  }

  @override
  void update(ParkingPerson item) {
    int index = _parkingPersonList.indexWhere((person) => person.getID() == item.getID());
    if (index != -1) {
      _parkingPersonList[index] = item;
    }
  }

  @override
  void delete(ParkingPerson item) {
    _parkingPersonList.removeWhere((person) => person.getID() == item.getID());
  }
}