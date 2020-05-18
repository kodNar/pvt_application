import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/Exercise.dart';

class EquipmentExercisePair{
  Exercise _exercise;
  Equipment _equipment;

  EquipmentExercisePair(Equipment equipment, Exercise exercise){
    _exercise = exercise;
    _equipment = equipment;
  }

  Equipment get equipment => _equipment;

  Exercise get exercise => _exercise;

  @override
  String toString() {
    return 'EquipmentExercisePair{_exercise: $_exercise, _equipment: $_equipment}';
  }

}