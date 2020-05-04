import 'package:flutter/material.dart';
import 'package:flutterapp/pages/MapsTest.dart';
import 'package:flutterapp/pages/WorkoutPortal.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const BaseAppBar({Key key, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      backgroundColor:  Color.fromARGB(255, 132, 50, 155),
      title: Container(
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
      ),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context,
              MaterialPageRoute(builder: (context) => WorkoutPortal()));
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 40,
          semanticLabel: 'Back',
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.home,
            size: 40,
            color: Colors.white,
          ),
          tooltip: 'Go to homepage',
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MapSample()));
          },
        ),
      ],
    );
  }
  @override
  Size get preferredSize => new Size.fromHeight(59);
}