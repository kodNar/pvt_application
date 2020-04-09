import 'package:flutter/material.dart';
    class MenuPage extends StatelessWidget{
  @override
      Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu',
      home:Scaffold(
          appBar: AppBar(
             title: Text('hej!'),
          ),
              body: Center(
              child:Stack(
                  children: [
                    Container(

                    ),
                    Container(

                    ),
                    Container(

                    ),
                    ]


              )

            )

        )
      );
  }
    }