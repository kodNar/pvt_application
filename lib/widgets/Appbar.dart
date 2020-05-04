import 'package:flutter/material.dart';
import 'package:flutterapp/pages/MapsTest.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.red;
  final Text title;
  final AppBar appBar;
  final List<Widget> widgets;

  /// you can add more fields that meet your needs

  const BaseAppBar({Key key, this.title, this.appBar, this.widgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      title: Container(
        padding: EdgeInsets.only(right: 50),
        child: Center(
          child: Text(
            'Workouts',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
      ),
      leading: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => MapSample()));
        },
        child: Icon(
          Icons.home,
          color: Colors.black,
          size: 40,
          semanticLabel: 'Home button',
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}