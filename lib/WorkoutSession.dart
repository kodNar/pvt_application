import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/User.dart';
import 'package:flutterapp/Exercise.dart';

class WorkoutSession{
  String _name;
  User _user;
  OutdoorGym _location;
  DateTime _dateTime;

  List <Exercise> _exercises;

  WorkoutSession(String name,User user, OutdoorGym location,DateTime dateTime){
    _user = user;
    _location = location;
    _name = name;
    _dateTime = dateTime;

  }

  String get name => _name;

  User getUser(){
    return _user;
  }

  OutdoorGym getGym(){
    return _location;
  }

  DateTime getDateTime(){
    return _dateTime;
  }

  List getExercises(){
    return _exercises;
  }

}