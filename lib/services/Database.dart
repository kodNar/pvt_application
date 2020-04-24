import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  /*
  Links user with a newly created document by UID(UserID)
   */

  final String uid;
  DatabaseService({this.uid});
  //a reference to a collection in our firestore database.
  final CollectionReference equipmentCollection = Firestore.instance.collection('equipment');
  final CollectionReference gymCollection = Firestore.instance.collection('gym');



  Future updateUserData(String material, String name, int reps) async{
    return await equipmentCollection.document(uid).setData({
      'material': material,
      'name' : name,
      'reps' : reps,
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
  Stream<QuerySnapshot> get gym {
    return gymCollection.snapshots();

  }
}