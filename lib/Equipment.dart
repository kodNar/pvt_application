import 'package:flutterapp/FaultyEquipmentReport.dart';
import 'package:flutterapp/OutdoorGym.dart';

abstract class Equipment{

  int _id;
  OutdoorGym _location;
  List <FaultyEquipmentReport> _faultyReports;

  //param id shall be changed to something a bit more autogenerated, smart and sexy
  Equipment(int id, OutdoorGym location){
    _id = id;
    _location = location;

  }

  int getId(){
    return _id;
  }

  OutdoorGym getLocation(){
    return _location;
  }

  List getReports(){
    return _faultyReports;
  }

}

class ChinUpBar extends Equipment{
  int _height;
  //param id shall be changed to something a bit more autogenerated, smart and sexy
  ChinUpBar(int id, OutdoorGym location, int height) :
        _height = height,
        super(id, location);
  int getHeight(){
    return _height;
  }
}

class Stump extends Equipment{
  int _height;
  //param id shall be changed to something a bit faster, harder, scooter
  Stump(int id, OutdoorGym location, int height) :
        _height = height,
        super(id, location);

}
