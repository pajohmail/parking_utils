import 'ParkingItem.dart';
import 'AbstractRepository.dart';

class ParkingTime extends ParkingItem {
  int id;
  DateTime startTime;
  DateTime endTime;

  ParkingTime({required this.id, required this.startTime, required this.endTime});

  int getID() => id;
  void setID(int id) => this.id = id;
}





