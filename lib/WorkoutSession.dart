import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/User.dart';
import 'package:flutterapp/Exercise.dart';

class WorkoutSession{
  String _name;
  String _user;
  String _location; //Ändra till att location är ett Gym inte en String
  DateTime _dateTime;
  int _likes = 0;
  List <Equipment> _equipment =[];
  OutdoorGym _outdoorGym;
  List <Exercise> _exercises;

  WorkoutSession(String name,String user, String location,DateTime dateTime, OutdoorGym outdoorGym, List <Equipment> equipments){
    _user = user;
    _location = location;
    _name = name;
    _dateTime = dateTime;
    _outdoorGym = outdoorGym;
    _equipment = equipments;
  }

  String get location => _location;

  void addLike(){
    _likes += 1;
  }
  void setLikes(int likes){
    _likes = likes;
  }
  void addEquipment(Equipment e){
    _equipment.add(e);
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