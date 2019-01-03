import 'package:flutter/material.dart';
import 'login.dart';
import 'TaskScreen.dart';
void main() => runApp(new MyApp());//one-line function

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "This is my first Flutter App",
      home: LoginPage()
      // home:TodoScreen()
    );  }
}
