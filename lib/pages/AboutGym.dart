import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/OutdoorGym.dart';

class AboutGym extends StatelessWidget {
  String name;
  OutdoorGym gym;
  String about;
  String picURL;

  AboutGym(String name) {
    this.name = name;
  }

  Future<String> getAboutPage() async {
    QuerySnapshot outdoorGymCollection =
        await Firestore.instance.collection("OutdoorGyms").getDocuments();
    for (var doc in outdoorGymCollection.documents) {
      if (doc.data['Name'] == name && doc.data['About'] != null) {
        about = doc.data['About'];
        picURL = doc.data['PictureURL'];
        print(picURL);
      }
    }
    return about;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
//            picURL != null ?
          Container(
            child: FutureBuilder(
              future: getAboutPage(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Container(
                        child: Container(
                          padding: EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(picURL), fit: BoxFit.fill),
                          ),
                        ),
                      )
                    : Container(
                        child: Container(
                          padding: EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/OutdoorGymPicture.png'), fit: BoxFit.fill),
                          ),
                        ),
                      );
              },
            ),
          ),
//          Container(
//            padding: EdgeInsets.only(top: 20),
//            width: MediaQuery.of(context).size.width,
//            height: MediaQuery.of(context).size.height * 0.5,
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                  image: NetworkImage(picURL), fit: BoxFit.fill),
//            ),
//          ),
//            :Container(
//              padding: EdgeInsets.only(top: 20),
//              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height * 0.5,
//              decoration: BoxDecoration(
//                image: DecorationImage(
//
//                    image: AssetImage('assets/images/OutdoorGymPicture.png'),
//                    fit: BoxFit.fill
//
//                ),
//              ),
//            ),

          Container(
            child: FutureBuilder(
              future: getAboutPage(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Container(
                        child: Text(
                          snapshot.data,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'OpenSans',
                            fontStyle: FontStyle.normal,
                          ),
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.all(20),
                      )
                    : Center(
                        child: Text(
                          'Loading...',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
              },
            ),
          ),
          Container(
              width: 75,
              height: 75,
              child: Image(
                image:
                    AssetImage('assets/images/Stockholm_endast_logga_vit.png'),
              )),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
