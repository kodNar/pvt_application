import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const MaterialColor themeColor = const MaterialColor(
    0xFF84329B,
    const <int, Color>{
      50: const Color(0xFF84329B),
      100: const Color(0xFF84329B),
      200: const Color(0xFF84329B),
      300: const Color(0xFF84329B),
      400: const Color(0xFF84329B),
      500: const Color(0xFF84329B),
      600: const Color(0xFF84329B),
      700: const Color(0xFF84329B),
      800: const Color(0xFF84329B),
      900: const Color(0xFF84329B),
    },
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black, //Sätter statusbarfärgen till svart
    ));
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: themeColor,
      ),
      home: HomePage(title: 'Stockholm Outdoor Gyms'),
    );
  }
}
