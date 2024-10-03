abstract class ParkingItem {
  String _name= '';
  int _id = 0;

  setID(int id){
    this._id = id;
  }
  setName(String name){
    this._name = name;
  }
  getID(){
    return this._id;
  }
  getName(){
    return this._name;
  }
}