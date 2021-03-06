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
  bool _shared = false;
  String _reference ="";
  bool _liked =false;
  bool _fav = false;
  int _favoris = 0;
  int _difficulty;


  WorkoutSession(String name,String user, String location,DateTime dateTime, OutdoorGym outdoorGym, List <Equipment> equipments,List <Exercise> exercise,bool shared,int difficulty){
    _user = user;
    _location = location;
    _name = name;
    _dateTime = dateTime;
    _outdoorGym = outdoorGym;
    _equipment = equipments;
    _exercises = exercise;
    _shared = shared;
    _difficulty = difficulty;
  }


  int get difficulty => _difficulty;

  set difficulty(int value) {
    _difficulty = value;
  }

  int get favoris => _favoris;


  bool get fav => _fav;

  set fav(bool value) {
    _fav = value;
  }

  bool get liked => _liked;

  set liked(bool value) {
    _liked = value;
  }

  void addFavorits(){
    _favoris += 1;
  }

  set favoris(int value) {
    _favoris = value;
  }

  bool get shared => _shared;


  String get reference => _reference;

  set reference(String value) {
    _reference = value;
  }

  set shared(bool value) {
    _shared = value;
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

  @override
  String toString() {
    return 'WorkoutSession{_name: $_name, _user: $_user, _location: $_location, _likes: $_likes}';
  }

  List<Equipment> get equipment => _equipment;

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