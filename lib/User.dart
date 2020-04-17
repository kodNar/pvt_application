import 'package:flutterapp/FaultyEquipmentReport.dart';
import 'package:flutterapp/WorkoutSession.dart';
import 'package:flutterapp/Suggestion.dart';

class User {
  String _email;
  String _password;
  String _nickName;

  List<FaultyEquipmentReport> _faultyReports = [];
  List<WorkoutSession> _workoutSessions = [];
  List<Suggestion> _suggestions = [];

  User (email, password, nickName){
    this._email = email;
    this._password = password;
    this._nickName = nickName;
  }

  String getEmail(){
    return _email;
  }
//VERY probable that this method is SUPER bad. Quickfixxx4Now
  String getPassword(){
    return _password;
  }

  String getNickName(){
    return _nickName;
  }

  //////////////////////// FAULTY REPORTS ////////////////////////
  //String shall be changed to FaultyEquipmentReport

  List getFaultyReport(){
    return _faultyReports;
  }
  void addFaultyReport(FaultyEquipmentReport report){
    _faultyReports.add(report);
  }
  void removeFaultyReport(String report){
    _faultyReports.remove(report);
  }

  //////////////////////// WORKOUT SESSIONS ////////////////////////
  //String shall be changed to WorkoutSession

  List getWorkoutSessions(){
    return _workoutSessions;
  }

  void addWorkoutSession(WorkoutSession session){
    _workoutSessions.add(session);
  }

  void removeWorkoutSessions(WorkoutSession session){
    _workoutSessions.remove(session);
  }

  ////////////////////////// SUGGESTIONS ///////////////////////////
  //String shall be changed to Suggestion

  List getSuggestions(){
    return _suggestions;
  }

  void addSuggestion(Suggestion suggestion){
    _suggestions.add(suggestion);
  }

  void removeSuggestion(String suggestion){
    _suggestions.remove(suggestion);
  }

}