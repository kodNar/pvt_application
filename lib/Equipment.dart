import 'package:flutterapp/Exercise.dart';
import 'package:flutterapp/FaultyEquipmentReport.dart';
import 'package:flutterapp/OutdoorGym.dart';

class Equipment{
  List<Exercise> _exercises;
  String _name;
  List <FaultyEquipmentReport> _faultyReports;

  //param id shall be changed to something a bit more autogenerated, smart and sexy
  Equipment(String name,List <Exercise> exercises){
    this._name = name;
    this._exercises =exercises;
  }


  String getName() {
    return _name;
  }


  List<Exercise> get exercises => _exercises;

  //Behövs tydligen se "Equipment or exercise".
  List<Exercise> getExercises(){
   return _exercises;
  }

  List getReports(){
    return _faultyReports;
  }

  @override
  String toString() {
    return 'Equipment{_name: $_name}';
  }

}

//class ChinUpBar extends Equipment{
//  int _height;
//  //param id shall be changed to something a bit more autogenerated, smart and sexy
//  ChinUpBar(int id, OutdoorGym location, int height) :
//        _height = height,
//        super(id, location);
//  int getHeight(){
//    return _height;
//  }
//}
//
//class Stump extends Equipment{
//  int _height;
//  //param id shall be changed to something a bit faster, harder, scooter
//  Stump(int id, OutdoorGym location, int height) :
//        _height = height,
//        super(id, location);
//}

