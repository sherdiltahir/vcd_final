import 'package:flutter/material.dart';
import 'calculator_screen.dart';
import '../Home.dart';

class MyCalculatorScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scientific Calculator',
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                ),
                Expanded(
                    child: Center(
                  child: Text(
                    "Calculator",
                    style: TextStyle(color: Colors.black),
                  ),
                ))
              ],
            ),
          ),
          body: CalculatorScreen()),
    );
  }
}
