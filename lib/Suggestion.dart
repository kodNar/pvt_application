import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/User.dart';

class Suggestion{

  OutdoorGym _gym;
  User _user;
  String _description;
  DateTime _dateTime;

  Suggestion(OutdoorGym gym, User user, String desc, ){
    _gym = gym;
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

  DateTime getDatetime(){
    return _dateTime;
  }

}