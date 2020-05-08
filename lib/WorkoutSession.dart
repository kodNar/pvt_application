import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/User.dart';
import 'package:flutterapp/Exercise.dart';

class WorkoutSession{
  String _name;
  String _user;
  String _location;
  DateTime _dateTime;
  int _likes = 0;

  List <Exercise> _exercises;

  WorkoutSession(String name,String user, String location,DateTime dateTime){
    _user = user;
    _location = location;
    _name = name;
    _dateTime = dateTime;

  }
  void addLike(){
    _likes += 1;
  }
  void removeLike(){
    _likes -= 1;
  }
  int get likes => _likes;

  String get name => _name;

  String getUser(){
    return _user;
  }

  String getGym(){
    return _location;
  }

  DateTime getDateTime(){
    return _dateTime;
  }

  List getExercises(){
    return _exercises;
  }

}