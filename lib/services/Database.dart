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
  static List<WorkoutSession> _favsession =[];
  static List<String> _likedRef =[];
  static List<String> _favRef = [];
  static set worksession(WorkoutSession value) {
    _worksession.add(value);
  }

  DatabaseService({this.uid});

  bool changedWorkout = false;


  Future <List<String>> getLikedRef()async {
    try {
        var doc = await userCollection.document(uid).get();
        _likedRef = doc.data["Liked"].cast<String>() as List<String>;
    }catch(e){
      print(e + "Liked error");
    }
    return _likedRef;
  }

  Future <List<String>> getFavRef()async {
    try{
      var doc = await  userCollection.document(uid).get();
      _favRef = doc.data["Favorits"].cast<String>() as List<String>;
    }catch(e){
      print(e+ "Fav error");
    }
    return _favRef;
  }


  final CollectionReference userCollection =
      Firestore.instance.collection('users'); //Creates/references a collection

  final CollectionReference outdoorGymsCollection =
      Firestore.instance.collection('OutdoorGyms');





  likeExercise(WorkoutSession s){
    userCollection.document(uid).updateData({
        'Liked': FieldValue.arrayUnion(([s.reference]))});
  }

  favExercise(WorkoutSession s){
    userCollection.document(uid).updateData({
      'Favorits': FieldValue.arrayUnion(([s.reference]))});
  }

  removeFavorit(String ref,WorkoutSession value) async {
    DocumentReference documentSnapshot =  userCollection.document(uid);
    documentSnapshot.updateData({"Favorits":FieldValue.arrayRemove([ref])});
    _favsession.remove(value);
    _favRef.remove(ref);
  }
  removeLiked(String ref,WorkoutSession value) async {
    DocumentReference documentSnapshot =  userCollection.document(uid);
    documentSnapshot.updateData({"Liked":FieldValue.arrayRemove([ref])});
    _likedRef.remove(ref);
  }

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
    if (_worksession.length == 0 || changedWorkout) {
      QuerySnapshot collectionReference = await Firestore.instance
          .collection('users')
          .document(uid)
          .collection("workoutCollection")
          .getDocuments();
      for (var doc in collectionReference.documents) {
        List<Exercise> exerList =
            await getExercisesWorkoutSession(doc.documentID);
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
              exerList,
              //is shared?
              doc.data['Shared'],
              doc.data['Difficulty']);
          _worksession.add(w);
          w.setLikes(doc.data['Likes']);
          w.favoris = (doc.data['Favorits']);
        } catch (e) {
          print(e.toString());
        }
      }
    }
    changedWorkout = false;
    return _worksession;
  }

  Future<List<Exercise>> getExercisesWorkoutSession(var ref) async {
    List<Exercise> exercises = [];
    QuerySnapshot collectionReference = await Firestore.instance
        .collection('users')
        .document(uid)
        .collection("workoutCollection")
        .document(ref.toString())
        .collection("Exercises")
        .getDocuments();

    for (var doc in collectionReference.documents) {
      try {
        Exercise e = (Exercise(doc.data['Name'], null));
        e.setReps(
          doc.data['Reps'],
        );
        e.setSets(doc.data['Sets']);
        exercises.add(e);
      } catch (e) {
        print("Error message" + e.toString());
      }
    }
    return exercises;
  }

  Future<List<Exercise>> getExercisesWorkoutSessionFavorit(var ref) async {
    List<Exercise> exercises = [];
    QuerySnapshot collectionReference = await Firestore.instance
        .collection('Workouts')
        .document(ref).collection("Exercises").getDocuments();

    for (var doc in collectionReference.documents) {
      try {
        Exercise e = (Exercise(doc.data['Name'], null));
        e.setReps(
          doc.data['Reps'],
        );
        e.setSets(doc.data['Sets']);
        exercises.add(e);
      } catch (e) {
        print("Error message" + e.toString());
      }
    }
    return exercises;
  }




  Future<List<WorkoutSession>> getFavoritedWorkouts() async {
    _favsession =[];
    List<WorkoutSession> sessions = [];
    DocumentSnapshot documentSnapshot = await userCollection
        .document(uid).get();
   try{
    for (String ref in documentSnapshot.data['Favorits'].cast<String>() as List<String>) {
      var document = await Firestore.instance.collection('Workouts').document(ref).get();
      List<Exercise> exerList = await getExercisesWorkoutSessionFavorit(document.documentID);
      print(exerList.length);
        WorkoutSession w = WorkoutSession(
          //name
            document.data['Name'],
            //User
            null,
            //location
            document.data["Location"],
            //time
            (document.data['Published'] as Timestamp).toDate(),
            //gym
            null,
            //list equipments
            null,
            //List exercises
            exerList,
            //is shared?
            document.data['Shared'],
            document.data['Difficulty']);
        w.reference = document.documentID;
        w.setLikes(document.data['Likes']);
        w.favoris = document.data['Favorites'];
        _favsession.add(w);

    }}catch(e){
     print(e);
   }
    return _favsession;
  }

  void createNewExercises(List<Exercise> list, OutdoorGym gym, String name, int difficulty) {
    String referennce = userCollection
        .document(uid)
        .collection("workoutCollection")
        .document()
        .documentID;
    userCollection
        .document(uid)
        .collection("workoutCollection")
        .document(referennce)
        .setData({
      'Location': gym.name,
      'Name': name,
      'Date': DateTime.now(),
      'Shared': false,
      'Difficulty':difficulty,
    });
    for (int i = 0; i < list.length; i++) {
      userCollection
          .document(uid)
          .collection('workoutCollection')
          .document(referennce)
          .collection("Exercises")
          .add(({
            'Sets': list[i].sets,
            'Reps': list[i].reps,
            'Name': list[i].name,
          }));
    }
    _worksession.add(WorkoutSession(
        name, null, gym.name, DateTime.now(), null, null, list, false,difficulty));
  }

  /// Updates a users nickname
  void updateNickname(String newNickname) async {
    await Firestore.instance.collection('users').document(uid).updateData({
      'nickName': newNickname,
    });
  }

  /// Updates a users email
  void updateEmail(String _email) async {
    await Firestore.instance.collection('users').document(uid).updateData({
      'email': _email,
    });
  }

  /// Returns a users nickname
  Future<String> getNickname() async {
    var nickname =
        await Firestore.instance.collection('users').document(uid).get();
    String unickName = nickname.data['nickName'];
    return unickName;
  }

  /// Returns a users data
  Future<List<String>> getUserData() async {
    var document =
        await Firestore.instance.collection('users').document(uid).get();
    String unickName = document.data['nickName'];
    String email = document.data['email'];
    String userid = uid;
    List<String> dataList = new List<String>();
    dataList.add(unickName);
    dataList.add(email);
    dataList.add(userid);
    return dataList;
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
