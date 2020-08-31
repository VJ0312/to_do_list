import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _myApp createState() => _myApp();
}

// ignore: camel_case_types
class _myApp extends State<MyApp> {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(fontFamily: 'BalsamiqSans'),
    );
  }
}

