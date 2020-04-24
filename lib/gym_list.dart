import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class gymList extends StatefulWidget {
  @override
  _gymListState createState() => _gymListState();
}

class _gymListState extends State<gymList> {
  @override
  Widget build(BuildContext context) {

    final gym = Provider.of<QuerySnapshot>(context);
    print(gym);
    print("bananer");


    return Container();
  }
}
