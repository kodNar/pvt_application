import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AboutUs extends StatelessWidget {


  Future<String> getAboutPage() async{
   var fireStore = Firestore.instance;
    QuerySnapshot docs = await fireStore.collection("Documents").getDocuments();
    String about;
    for (var doc in docs.documents) {
      about = doc.data['AboutUs'];
    }
    return about;
  }

  @override
  Widget build(BuildContext context){
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 132, 50, 155),
          appBar: AppBar(
            title: Text('About us'),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 132, 50, 155),
          ),

              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                  alignment: Alignment.center,
                    child: Text('Welcome!', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                      child: FutureBuilder(
                        future: getAboutPage(),
                            builder: (context, snapshot)  {
                          return snapshot.hasData
                          ? Container(child: Text(
                            snapshot.data, style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'OpenSans',
                            fontStyle: FontStyle.normal,
                          ),
                          softWrap: true,

                            textAlign: TextAlign.center,
                          ),
                            padding: EdgeInsets.all(20),
                          ):
                              Center(
                                child: Text('Loading...', style: TextStyle(

                                ),)
                              );
                        },
                      )
                  ),
                  Container(
                    width: 75,
                    height: 75,
                    child: Image(
                     image: AssetImage('assets/images/Stockholm_endast_logga_vit.png'),
                    )
                  ),
                ],
            )
        );

        
  }


  }

