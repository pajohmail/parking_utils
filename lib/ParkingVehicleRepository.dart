import 'AbstractRepository.dart';
import 'ParkingVehicle.dart';

class ParkingVehicleRepository extends AbstractRepository<ParkingVehicle> {
  List<ParkingVehicle> _parkingVehicleList = [];
  static int _ParkingVehicleID = 1;

  @override
  void add(ParkingVehicle item) {
    if (item.getID() == 0) {
      item.setID(_ParkingVehicleID);
      _ParkingVehicleID++;
    }
    _parkingVehicleList.add(item);
  }

  @override
  List<ParkingVehicle> getAll() {
    return _parkingVehicleList;
  }

  @override
  ParkingVehicle getById(int id) {
    return _parkingVehicleList.firstWhere((vehicle) => vehicle.getID() == id);
  }

  @override
  void update(ParkingVehicle item) {
    int index = _parkingVehicleList.indexWhere((vehicle) => vehicle.getID() == item.getID());
    if (index != -1) {
      _parkingVehicleList[index] = item;
    }
  }

  @override
  void delete(ParkingVehicle item) {
    _parkingVehicleList.removeWhere((vehicle) => vehicle.getID() == item.getID());
  }
}