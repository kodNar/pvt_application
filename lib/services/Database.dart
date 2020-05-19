import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/Exercise.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/WorkoutSession.dart';

import 'package:flutterapp/models/user.dart';

class DatabaseService {
  /*
  Links user with a newly created document by UID(UserID)
   */

  final String uid;
  static List<WorkoutSession> _worksession = [];
  DatabaseService({this.uid});
  bool changedWorkout = false;

  //a reference to a collection in our firestore database.
  final CollectionReference userCollection =
  Firestore.instance.collection('users'); //Creates/references a collection

  final CollectionReference outdoorGymsCollection =
  Firestore.instance.collection('OutdoorGyms');

  Future updateUserData(String userID, String email, String nickName) async {
    userCollection
        .document(uid)
        .collection('workoutCollection')
        .document(uid)
        .setData({'Name': 'Test', 'blomman': 'snälla fungera'});
    return await userCollection.document(uid).setData({
      'userID': userID,
      'email': email,
      'nickName': nickName,
    });
  }

  Future addWorkout(name) async {
    userCollection
        .document(uid)
        .collection('workoutCollection')
        .document()
        .setData({
      'Name': name ?? '',
    });
  }

  Future<List<String>> _referencesToUsersWorkoutsSessions(var doc) async {
    List<String> referenceList = [];
    if (doc.data['Reference'] != null) {
      List<Object> objectList = doc.data['Reference'];
      for (Object o in objectList) {
        String reference = o.toString();
        referenceList.add(reference);
      }
    }
    return referenceList;
  }

  Future<Equipment> _getSessionEquipment(String ref) async {
    List<Exercise> exercises = [];
    Equipment equipment;
    var temp =
    (await Firestore.instance.collection('Equipment').document(ref).get());
    var exerTemp = await Firestore.instance
        .collection('Equipment')
        .document(ref)
        .collection("Exercises")
        .getDocuments();
    for (var doc in exerTemp.documents) {
      Exercise e = Exercise(doc.data['Name'], doc.data['Desc']);
      if (e != null) {
        exercises.add(e);
      }
    }
    equipment = Equipment(temp.documentID.toString(), exercises);
    return equipment;
  }

  Future<List<WorkoutSession>> getUserWorkoutSessions() async {
      if(_worksession.length == 0 || changedWorkout){
      QuerySnapshot collectionReference = await Firestore.instance
          .collection('users')
          .document(uid)
          .collection("workoutCollection")
          .getDocuments();
      for (var doc in collectionReference.documents) {

        List<Exercise> exerList = await getExercisesWorkoutSession(doc.documentID);
        try {
          List<Equipment> equipments = [];
          for (String ref in await _referencesToUsersWorkoutsSessions(doc)) {
            Equipment e = await _getSessionEquipment(ref);
            equipments.add(e);
          }
          WorkoutSession w = WorkoutSession(
              //name
              doc.data['Name'],
              //User
              null,
              //location
              doc.data["Location"],
              //time
              (doc.data['Date'] as Timestamp).toDate(),
              //gym
              null,
              //list equipments
              equipments,
              //List exercises
              exerList);
          _worksession.add(w);
        }catch(e){
          print(e.toString());

      }
    }
      }
      changedWorkout = false;
    return _worksession;
  }

  Future <List<Exercise>>getExercisesWorkoutSession(var ref)async{
    List <Exercise> exercises = [];
    QuerySnapshot collectionReference = await Firestore.instance
        .collection('users')
        .document(uid)
        .collection("workoutCollection").document(ref.toString()).collection("Exercises").getDocuments();

    for(var doc in collectionReference.documents){
      try {
        Exercise e = (Exercise(doc.data['Name'], null));
        e.setReps(doc.data['Reps'],);
        e.setSets(doc.data['Sets']);
        exercises.add(e);
      }catch(e){
      print("Error message"+e.toString());
      }
    }
    return exercises;
  }


  void createNewExercises(List<Exercise> list, OutdoorGym gym, String name) {
    String referennce = userCollection.document(uid).collection("workoutCollection").document().documentID;
    userCollection.document(uid).collection("workoutCollection").document(referennce).setData({'Location': gym.name, 'Name': name,
      'Date': DateTime.now()
    });
    for(int i = 0; i< list.length; i++){
      userCollection
          .document(uid).collection('workoutCollection').document(referennce).collection("Exercises").add(({'Sets':list[i].sets , 'Reps':list[i].reps,'Name':list[i].name}));
    }
    changedWorkout = true;
  }


  Future<String> getNickname() async {
    var nickname =
    await Firestore.instance.collection('users').document(uid).get();
    String unickName = nickname.data['nickName'];
    return unickName;
  }

  /// Returnerar en stream för utegymmen
  Stream<QuerySnapshot> get OutdoorGyms {
    return outdoorGymsCollection.snapshots();
  }

  // Returning an iterable with as many documents as the collection has.
  List<User> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return User(
        email: doc.data['email'] ?? '',
        userID: doc.data['userID'] ?? '',
        nickName: doc.data['nickName'] ?? '',
      );
      //conver the iterable to a list
    }).toList();
  }

  //get the users stream Notifying any changes in the users collection
  Stream<List<User>> get users {
    //gives us a snapshot of the current documents in the users collection
    return userCollection
        .snapshots()
        .map(_userListFromSnapshot); //returns us a stream
    //Everytime we get a new snapshot we want to call the list instead
  }

/*
  Future updateOutdoorGym(List<String> equipment, String name, GeoPoint position) async{
    return await gymCollection.document(name).setData({
      'equipment': equipment,
      'name': name,
      'position': position,
    });
  }

 */
//get User stream

}
