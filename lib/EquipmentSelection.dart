import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EquipmentSelection {

/*
Skapar en ListView.builder, en oändligt stor lista som läser in och skapar knappar
utifrån en intagen lista.
 */
}

class MyTestPage extends StatefulWidget {
  MyTestPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyTestPageState createState() => _MyTestPageState();
}

class _MyTestPageState extends State<MyTestPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Please just work"),
      ),
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  Future _data;

  Future getGyms() async {
    //ska hämta en samling beroende på vad du utför, måste skickas med en string
    var firestore = Firestore.instance;
    // namnet på samlingen du hämtar
    QuerySnapshot qn = await firestore.collection("OutdoorGyms").getDocuments();


    return qn.documents;
  }

  @override
  void initState() {
    super.initState();

    _data = getGyms();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading... "),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      /*
                      Namnet på fältet du hämtar. Ska även ha en string med sig
                      så rätt fält hämtas beroende på vad du vill utföra
                       */
                      title: Text(snapshot.data[index].data["Equipment"].toString()),
                    );
                  });
            }
          }),
    );
  }
}

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
