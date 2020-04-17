import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/User.dart';
import 'package:flutterapp/Exercise.dart';

class WorkoutSession{

  User _user;
  OutdoorGym _location;
  DateTime _dateTime;

  List <Exercise> _exercises;

  WorkoutSession(User user, OutdoorGym location){
    _user = user;
    _location = location;
  }

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