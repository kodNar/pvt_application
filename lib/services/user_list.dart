


/** This WIDGET responsible for cycling through and outputting them on the page **/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

    /** Trying to access the data from the stream **/
    final userCollection = Provider.of<QuerySnapshot>(context); //Gets a snapshot of the userCollection
    print(userCollection.documents);
    for(var doc in userCollection.documents){
      print(doc.data);
    }

    return Container();
  }
}
