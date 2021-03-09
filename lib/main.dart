import 'package:flutter/material.dart';
import 'package:sorts_app/screens/SplashScreen.dart';
void main() => runApp(SortsApp());

class SortsApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Sorts",
        home: SplashScreen(),
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF000000), //setting the background colour
          accentColor: Color(0xff2EA3EA),
        ),
        debugShowMaterialGrid: false,
    );
  }
}
