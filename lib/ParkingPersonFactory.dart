import 'package:parking_utils/ParkingItemFactory.dart';
import 'package:parking_utils/ParkingPerson.dart';
import 'package:parking_utils/CreditCardDetails.dart';

class ParkingPersonFactory extends ParkingItemFactory {
  @override
  static ParkingPerson? create(String name, String email, String phone, List<String> owenedVehicleList, List<CreditCardDetails> creditCardList, int id) {
    //Some implementation for creating ParkingPerson
    return null;
  }
  @override
  static change(ParkingPerson item, int id) {
    //Some implementation for changing ParkingPerson
  }

  @override
  static delete(ParkingPerson item) {

      //Some implementation for deleting ParkingPerson
  }

}