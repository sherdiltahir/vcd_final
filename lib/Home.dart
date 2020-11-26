import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Calculator/CalculatorPage.dart';
import 'Voicecalculator/VoiceCalculator.dart';
import 'Dictionary/VoiceDictionary.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MyHomeScreen()
    ;
  }
}

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      scrollDirection: Axis.vertical,
      children: [
        SizedBox(
          height: 18,
        ),
        FlatButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Voicecalculator()));
            },
            child: Card(
              color: Colors.brown[300],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Container(
                height: 180,
                width: 400,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.microphone,
                        color: Colors.white,
                        size: 90,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "VoiceCalculator",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            )),
        SizedBox(
          height: 18,
        ),
        FlatButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyCalculatorScreen()));
            },
            child: Card(
              color: Colors.green[300],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Container(
                height: 180,
                width: 400,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.calculator,
                        color: Colors.white,
                        size: 90,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Calculator",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            )),
        SizedBox(
          height: 18,
        ),
        FlatButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dictionary()));
            },
            child: Card(
              color: Colors.grey[300],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Container(
                height: 180,
                width: 400,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.book,
                        color: Colors.white,
                        size: 90,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Dictionary",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            )),
        SizedBox(
          height: 18,
        ),
      ],
    ));
  }
}
