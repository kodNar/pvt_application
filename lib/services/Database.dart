import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/WorkoutSession.dart';

import 'package:flutterapp/models/user.dart';

class DatabaseService {
  /*
  Links user with a newly created document by UID(UserID)
   */

  final String uid;

  DatabaseService({this.uid});

  //a reference to a collection in our firestore database.
  final CollectionReference userCollection =
      Firestore.instance.collection('users'); //Creates/references a collection

  final CollectionReference outdoorGymsCollection =
      Firestore.instance.collection('OutdoorGyms');


  Future updateUserData(String userID, String email, String nickName) async {
    userCollection.document(uid).collection('workoutCollection').document(uid).setData({
      'Name': 'Test',
      'kuken': 'snälla fungera'

    });
    return await userCollection.document(uid).setData({
      'userID': userID,
      'email': email,
      'nickName': nickName,

    });
  }

  Future addWorkout(name) async{
    userCollection.document(uid).collection('workoutCollection').document().setData({
      'Name': name ?? '',
    });
  }



  Future<List<WorkoutSession>> getWorkouts() async {
    List<WorkoutSession> workouts = [];
    QuerySnapshot collectionReference = await Firestore.instance.collection('users').document(uid).collection("workoutCollection").getDocuments();
   for(var doc in collectionReference.documents){
     WorkoutSession w = WorkoutSession(doc.data['Name'],null,null,(doc.data['Date'] as Timestamp).toDate());
     print(doc.data.toString());
     workouts.add(w);
   }
   return workouts;
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
