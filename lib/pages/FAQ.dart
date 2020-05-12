import 'package:flutter/material.dart';

import 'HomePage.dart';

//void main() => runApp(MaterialApp(
//  home: FAQ(),
//));

class FAQ extends StatelessWidget {
  String clickedFAQ;
  String clickedAnswer;

  createAlertDialog(BuildContext context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text(clickedFAQ),
        content: Text(clickedAnswer),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: AppBar(
        leading: BackButton(
        ),
        title: Text("Frequently Asked Questions"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
            ),
            tooltip: "Go to homepage",
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ExpansionTile(
            title: Text('Why are some gyms made from wood and some from steel?',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            children: <Widget>[
              Text('Test'),

          /*
          Container(
            padding: EdgeInsets.all(20.0),
            //color: Colors.cyan,
            alignment: Alignment.center,
            child: Text(

               "FAQ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
            ),

          ),
          Container(
            height: 400.0,
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.add,
                      ),
                      onPressed: (){
                        clickedFAQ = "Why are some gyms made from wood and some from steel?";
                        clickedAnswer = "För tycker de e bra man kan blanda och så lite ris";
                        createAlertDialog(context);
                      },
                    ),
                    Flexible(
                        child: Container(
                            padding: new EdgeInsets.all(20.0),
                            child: Text(
                              "Why are some gyms made from wood and some from steel?",
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                            )
                        )
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.add,
                      ),
                      onPressed: (){
                        //Ta fram svar
                      },
                    ),
                    Flexible(
                        child: Container(
                            padding: new EdgeInsets.all(20.0),
                            child: Text(
                              "Why is my gym not included in the app?",
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                            )
                        )
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.add,
                      ),
                      onPressed: (){
                        //Ta fram svar
                      },
                    ),
                    Flexible(
                        child: Container(
                            padding: new EdgeInsets.all(20.0),
                            child: Text(
                              "How do I give feedback on a gym I recently visited?",
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                            )
                        )
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.add,
                      ),
                      onPressed: (){
                        //Ta fram svar
                      },
                    ),
                    Flexible(
                        child: Container(
                            padding: new EdgeInsets.all(20.0),
                            child: Text(
                              "How do I report faulty equipment?",
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                            )
                        )
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.add,
                      ),
                      onPressed: (){
                        //Ta fram svar
                      },
                    ),
                    Flexible(
                        child: Container(
                            padding: new EdgeInsets.all(20.0),
                            child: Text(
                              "How do I change my nickname?",
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                            )
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),

           */
        ],
      ),
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


