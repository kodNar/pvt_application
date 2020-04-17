import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/User.dart';

class FaultyEquipmentReport{

  OutdoorGym _gym;
  Equipment _eq;
  User _user;
  String _description;
  DateTime _dateTime;
  bool _solved;

  FaultyEquipmentReport(OutdoorGym gym, Equipment eq, User user, String desc, ){
    _gym = gym;
    _eq = eq;
    _user = user;
    _description = desc;

    _dateTime = new DateTime.now();

  }
  OutdoorGym getOutdoorGym(){
    return _gym;
  }

  User getUser(){
    return _user;
  }

  String getDescription(){
    return _description;
  }

  Equipment getEQ(){
    return _eq;
  }

  DateTime getDatetime(){
    return _dateTime;
  }

  bool getSolved(){
    return _solved;
  }

  void setSolved(bool solved){
    _solved = solved;
  }

}