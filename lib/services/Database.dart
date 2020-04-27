import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  /*
  Links user with a newly created document by UID(UserID)
   */

  final String uid;
  DatabaseService({this.uid});

  //a reference to a collection in our firestore database.
 final CollectionReference userCollection = Firestore.instance.collection('users'); //Creates a collection
  Future updateUserData(String userID, String email, String nickName) async{
    return await userCollection.document(uid).setData({
      'userID': userID,
      'email': email,
      'nickName': nickName,
    });

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