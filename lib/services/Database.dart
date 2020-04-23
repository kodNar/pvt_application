import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  /*
  Links user with a newly created document by UID(UserID)
   */

  final String uid;
  DatabaseService({this.uid});
  //a reference to a collection in our firestore database.
  final CollectionReference equipmentCollection = Firestore.instance.collection('equipment');

  Future updateUserData(String material, String name, int reps) async{
    return await equipmentCollection.document(uid).setData({
      'material': material,
      'name' : name,
      'reps' : reps,
    });

  }
}