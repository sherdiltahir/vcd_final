import 'package:flutter/material.dart';
import 'package:vcd_final/Home.dart';



void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "VCD",
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
