import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.backspace,
          ),
          tooltip: "Go back one step",
          onPressed: (){
            //Bakåt
          },
        ),
        title: Text("Frequently Asked Questions"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
            ),
            tooltip: "Go to homepage",
            onPressed: (){
              //HEM
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.cyan,
            alignment: Alignment.center,
            child: Text("Rubrik"),
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
                        //Ta fram svar
                      },
                    ),
                    Flexible(
                        child: Container(
                            padding: new EdgeInsets.only(right: 13.0),
                            child: Text(
                              "Why are some gyms made from wood and some from steel?",
                              overflow: TextOverflow.clip,
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
                            padding: new EdgeInsets.only(right: 13.0),
                            child: Text(
                              "Why is my gym not included in the app?",
                              overflow: TextOverflow.clip,
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
                            padding: new EdgeInsets.only(right: 13.0),
                            child: Text(
                              "How do I give feedback on a gym I recently visited?",
                              overflow: TextOverflow.clip,
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
                            padding: new EdgeInsets.only(right: 13.0),
                            child: Text(
                              "How do I report faulty equipment?",
                              overflow: TextOverflow.clip,
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
                            padding: new EdgeInsets.only(right: 13.0),
                            child: Text(
                              "How do I change my nickname?",
                              overflow: TextOverflow.clip,
                            )
                        )
                    ),
                  ],
                ),
                Container(
                  child: Image(
                    alignment: Alignment.center,
                    image: AssetImage('assets/images/Stockholm_endast_logga_vit.png'),
                  ),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


