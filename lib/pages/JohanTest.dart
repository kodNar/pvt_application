import 'package:flutter/material.dart';


class JohanTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.backspace,
            ),
            tooltip: "Go back one step",
            onPressed: () {
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
              onPressed: () {
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
                        onPressed: () {
                          //Ta fram svar
                        },
                      ),
                      Container(
                        child: new Text(
                            "Why are some gyms made from wood and others from steel?",
                            softWrap: true, overflow: TextOverflow.clip),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}