import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/Appbar.dart';

import 'HomePage.dart';



class FAQ extends StatelessWidget {
  String clickedFAQ;
  String clickedAnswer;
  String answer1 = "";

//  createAlertDialog(BuildContext context) {
//    return showDialog(context: context, builder: (context) {
//      return AlertDialog(
//        title: Text(clickedFAQ),
//        content: Text(clickedAnswer),
//      );
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: BaseAppBar(
        title: "Frequently Asked Questions",
      ),
//      appBar: AppBar(
//        leading: BackButton(
//        ),
//        title: Text("Frequently Asked Questions"),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              Icons.home,
//            ),
//            tooltip: "Go to homepage",
//            onPressed: (){
//              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//            },
//          )
//        ],
//      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: Text(
               "FAQ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0, color: Colors.white),
            ),

          ),
          ExpansionTile(
            title: Text("Why are some gyms made from wood and some from steel?", style: TextStyle( color: Colors.white),),
//            leading: ExpandIcon(
//              color: Colors.black,
//            ),


            children: <Widget>[
              Text("Svar",style: TextStyle( color: Colors.white),),

            ],
          ),
          ExpansionTile(
            title: Text("Why is my gym not included in the app?", style: TextStyle( color: Colors.white),),
            children: <Widget>[
              Text("Svar",style: TextStyle( color: Colors.white),),
            ],
          ),
          ExpansionTile(
            title: Text("How do I give feedback on a gym I recently visited?", style: TextStyle( color: Colors.white),),
            children: <Widget>[
              Text("Svar",style: TextStyle( color: Colors.white),),
            ],
          ),ExpansionTile(
            title: Text("How do I report faulty equipment?", style: TextStyle( color: Colors.white),),
            children: <Widget>[
              Text("Svar",style: TextStyle( color: Colors.white),),
            ],
          ),ExpansionTile(
            title: Text("How do I change my nickname?", style: TextStyle( color: Colors.white),),
            children: <Widget>[
              Text("Svar",style: TextStyle( color: Colors.white),),
            ],
          ),


//          Container(
//            height: 400.0,
//            child: ListView(
//              children: <Widget>[
//                Row(
//                  children: <Widget>[
//                    IconButton(
//                      icon: Icon(
//                        Icons.add,
//                      ),
//                      onPressed: (){
//                        clickedFAQ = "Why are some gyms made from wood and some from steel?";
//                        answer1 = "För tycker de e bra man kan blanda och så lite ris";
//                        //Create container
//                        //createAlertDialog(context);
//                      },
//                    ),
//                    Flexible(
//                        child: Container(
//                            padding: new EdgeInsets.all(20.0),
//                            child: Text(
//                              "Why are some gyms made from wood and some from steel?",
//                              overflow: TextOverflow.clip,
//                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
//
//                            )
//                        )
//                    ),
//
//                  ],
//                ),
//                Row(
//                  children: <Widget>[
//                    IconButton(
//                      icon: Icon(
//                        Icons.add,
//                      ),
//                      onPressed: (){
//                        //Ta fram svar
//                      },
//                    ),
//                    Flexible(
//                        child: Container(
//                            padding: new EdgeInsets.all(20.0),
//                            child: Text(
//                              "Why is my gym not included in the app?",
//                              overflow: TextOverflow.clip,
//                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
//                            )
//                        )
//                    ),
//                  ],
//                ),
//                Row(
//                  children: <Widget>[
//                    IconButton(
//                      icon: Icon(
//                        Icons.add,
//                      ),
//                      onPressed: (){
//                        //Ta fram svar
//                      },
//                    ),
//                    Flexible(
//                        child: Container(
//                            padding: new EdgeInsets.all(20.0),
//                            child: Text(
//                              "How do I give feedback on a gym I recently visited?",
//                              overflow: TextOverflow.clip,
//                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
//                            )
//                        )
//                    ),
//                  ],
//                ),
//                Row(
//                  children: <Widget>[
//                    IconButton(
//                      icon: Icon(
//                        Icons.add,
//                      ),
//                      onPressed: (){
//                        //Ta fram svar
//                      },
//                    ),
//                    Flexible(
//                        child: Container(
//                            padding: new EdgeInsets.all(20.0),
//                            child: Text(
//                              "How do I report faulty equipment?",
//                              overflow: TextOverflow.clip,
//                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
//                            )
//                        )
//                    ),
//                  ],
//                ),
//                Row(
//                  children: <Widget>[
//                    IconButton(
//                      icon: Icon(
//                        Icons.add,
//                      ),
//                      onPressed: (){
//                        //Ta fram svar
//                      },
//                    ),
//                    Flexible(
//                        child: Container(
//                            padding: new EdgeInsets.all(20.0),
//                            child: Text(
//                              "How do I change my nickname?",
//                              overflow: TextOverflow.clip,
//                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
//                            )
//                        )
//                    ),
//                  ],
//                ),
//              ],
//            ),
//          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 132, 50, 155),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Image(
            height: 100, width: 50,
            alignment: Alignment.topCenter,
            image: AssetImage('assets/images/Stockholm_endast_logga_vit.png'),
            fit: BoxFit.fitHeight,
            //fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}


