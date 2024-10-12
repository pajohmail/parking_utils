import 'ParkingItem.dart';
import 'AbstractRepository.dart';

class ParkingTime extends ParkingItem {
  int id = 0;
  DateTime startTime = DateTime.now();
  DateTime endTime;
  int personID;
  int spaceID;
  int vehicleID;

  ParkingTime({required this.endTime, required this.personID, required this.spaceID, required this.vehicleID});

  int getID() => id;
  void setID(int id) => this.id = id;

}