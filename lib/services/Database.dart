import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/OutdoorGym.dart';

import 'package:flutterapp/models/user.dart';

class DatabaseService {
  /*
  Links user with a newly created document by UID(UserID)
   */

  final String uid;

  DatabaseService({this.uid});

  //a reference to a collection in our firestore database.
  final CollectionReference userCollection = Firestore.instance.collection('users'); //Creates/references a collection
  
  final CollectionReference outdoorGymsCollection = Firestore.instance.collection('OutdoorGyms');




  Future updateUserData(String userID, String email, String nickName) async {
    return await userCollection.document(uid).setData({
      'userID': userID,
      'email': email,
      'nickName': nickName,
    });
  }

/// Returnerar en stream för utegymmen
  Stream<QuerySnapshot> get OutdoorGyms {
    return outdoorGymsCollection.snapshots();
  }


  // Returning an iterable with as many documents as the collection has.
  List<User> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
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
    return userCollection.snapshots().map(_userListFromSnapshot); //returns us a stream
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