import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();

  String expression = '';

  buttonPressed(String buttonText) {
    String question = questionController.text;
    question = question.replaceAll('×', '*');
    question = question.replaceAll('÷', '/');

    if (question == 'e') {
      question = question.replaceAll('e', '${math.e}');
    } else if (question.contains('e')) {
      question = question.replaceAll('e', '*${math.e}');
    }

    if (question == 'PI') {
      question = question.replaceAll("PI", '${math.pi}');
    } else if (question.contains('PI')) {
      //List<String> expressions = question.split('PI');
      question = question.replaceAll("PI", '*${math.pi}');
    }

    question = question.replaceAll('%', '*1/100');

    setState(() {
      if (buttonText == 'ln') {
        try {
          //String question = questionController.text;
          if (question.length > 0) {
            Parser p = Parser();
            Expression exp = p.parse(question);

            Ln ln = Ln(exp);
            ContextModel cm = ContextModel();

            double eval = ln.evaluate(EvaluationType.REAL, cm);

            answerController.text = '$eval';
          }
        } catch (e) {
          answerController.text = 'ERROR';
        }
      } else if (buttonText == 'log') {
        try {
          //String question = questionController.text;
          if (question.length > 0) {
            Parser p = Parser();
            Expression exp = p.parse(question);

            Ln ln = Ln(exp);
            ContextModel cm = ContextModel();

            double eval = ln.evaluate(EvaluationType.REAL, cm) * 1 / math.ln10;

            answerController.text = '$eval';
          }
        } catch (e) {
          answerController.text = 'ERROR';
        }
      } else if (buttonText == 'DEL') {
        //String question = questionController.text;
        if (question.length > 0) {
          String q = question.substring(0, question.length - 1);
          questionController.text = q;
        }
      } else if (buttonText == 'AC') {
        questionController.text = '0';
        answerController.text = '0';
      } else if (buttonText == 'cos\u207B\u00B9') {
        try {
          String strNum = question;
          if (strNum.length > 0) {
            double radian = double.parse(strNum);

            double acos = math.acos(radian);
            answerController.text = '$acos';
          }
        } catch (e) {
          answerController.text = 'ERROR';
        }
      } else if (buttonText == 'tan\u207B\u00B9') {
        try {
          String strNum = question;
          if (strNum.length > 0) {
            double radian = double.parse(strNum);

            double atan = math.atan(radian);
            answerController.text = '$atan';
          }
        } catch (e) {
          answerController.text = 'ERROR';
        }
      } else if (buttonText == 'Rad to Deg') {
        try {
          String strNum = question;
          if (strNum.length > 0) {
            double numInRad = double.parse(strNum);

            double degree = numInRad * 57.2958;
            answerController.text = '$degree';
          }
        } catch (e) {
          answerController.text = 'ERROR';
        }
      } else if (buttonText == 'Deg to Rad') {
        try {
          String strNum = question;
          if (strNum.length > 0) {
            double numInDegree = double.parse(strNum);

            double radian = numInDegree * 0.0174533;
            answerController.text = '$radian';
          }
        } catch (e) {
          answerController.text = 'ERROR';
        }
      } else if (buttonText == 'sin') {
        try {
          String strNum = question;
          if (strNum.length > 0) {
            double radian = double.parse(strNum);

            double sin = math.sin(radian);
            answerController.text = '$sin';
          }
        } catch (e) {
          answerController.text = 'ERROR';
        }
      } else if (buttonText == 'cos') {
        try {
          String strNum = question;
          if (strNum.length > 0) {
            double radian = double.parse(strNum);

            double cos = math.cos(radian);
            answerController.text = '$cos';
          }
        } catch (e) {
          answerController.text = 'ERROR';
        }
      } else if (buttonText == 'tan') {
        try {
          String strNum = question;
          if (strNum.length > 0) {
            double radian = double.parse(strNum);

            double tan = math.tan(radian);
            answerController.text = '$tan';
          }
        } catch (e) {
          answerController.text = 'ERROR';
        }
      } else if (buttonText == 'sin\u207B\u00B9') {
        try {
          String strNum = question;
          if (strNum.length > 0) {
            double radian = double.parse(strNum);

            double asin = math.asin(radian);
            answerController.text = '$asin';
          }
        } catch (e) {
          answerController.text = 'ERROR';
        }
      } else if (buttonText == 'x\u00B2') {
        try {
          String strNum = question;
          if (strNum.length > 0) {
            double num = double.parse(strNum);
            double square = num * num;
            answerController.text = '$square';
          }
        } catch (e) {
          answerController.text = 'ERROR';
        }
      } else if (buttonText == 'x\u00B3') {
        try {
          String strNum = question;
          if (strNum.length > 0) {
            double num = double.parse(strNum);
            double square = num * num * num;
            answerController.text = '$square';
          }
        } catch (e) {
          answerController.text = 'ERROR';
        }
      } else if (buttonText == '∛') {
        try {
          String strNum = question;
          if (strNum.length > 0) {
            double num = double.parse(strNum);
            double cubeRoot = math.pow(num, (1 / 3));

            answerController.text = '$cubeRoot';
          }
        } catch (e) {
          answerController.text = 'ERROR';
        }
      } else if (buttonText == 'x!') {
        try {
          String strNum = question;
          if (strNum.length > 0) {
            double num = double.parse(strNum);

            double fact = 1;

            for (int i = 2; i <= num; i++) {
              fact *= i;
            }

            answerController.text = '$fact';
          }
        } catch (e) {
          answerController.text = 'ERROR';
        }
      } else if (buttonText == '√') {
        try {
          String strNum = question;
          if (strNum.length > 0) {
            double num = double.parse(strNum);
            double squareRoot = math.sqrt(num);

            answerController.text = '=$squareRoot';
          }
        } catch (e) {
          answerController.text = 'ERROR';
        }
      } else if (buttonText == 'About') {
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  side: BorderSide(color: Colors.deepOrange, width: 2),
                ),
                content: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Developed By'),
                      Text('Hamza Khalid'),
                      Divider(),
                      Text('University of Lahore'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              );
            });
      } else if (buttonText == '=') {
        try {
          Parser p = Parser();

          Expression exp = p.parse(question);

          ContextModel cm = ContextModel();

          double eval = exp.evaluate(EvaluationType.REAL, cm);

          answerController.text = '$eval';
        } catch (e) {
          answerController.text = 'ERROR';
        }
      } else {
        if (questionController.text == '0') {
          questionController.text = buttonText;
        } else {
          questionController.text = questionController.text + buttonText;
        }
      }
    });
  }
//Custom widget
  Widget buildButton(String buttonText, Color buttonColor) {
    double fontSize = 16.0;
    if (buttonText == 'Rad to Deg' ||
        buttonText == 'Deg to Rad' ||
        buttonText == 'About') {
      fontSize = 14.0;
    }

    return Expanded(
      child: Container(
        margin: MediaQuery.of(context).orientation == Orientation.portrait
            ? EdgeInsets.all(3)
            : EdgeInsets.all(1),
        child: RaisedButton(
          color: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white, fontSize: fontSize),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
         /* color: Color(0xFFEFF0F1),*/

          child: Column(
            children: <Widget>[
              //Screen Container
              Container(

                margin: EdgeInsets.all(3.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  color: Color(0xFFD1D1D2),
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: Color(0xFFD1D1D2)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Container(

                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        child: TextField(
                          maxLines: 3,
                          controller: questionController,
                          enabled: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 35,
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                      child: TextField(
                        controller: answerController,
                        style: TextStyle(fontSize: 24),
                        enabled: false,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Buttons container
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            buildButton('log', Colors.deepOrange),
                            buildButton('ln', Colors.deepOrange),
                            buildButton('√', Colors.deepOrange),
                            buildButton('∛', Colors.deepOrange),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            buildButton('sin\u207B\u00B9', Colors.deepOrange),
                            buildButton('cos\u207B\u00B9', Colors.deepOrange),
                            buildButton('tan\u207B\u00B9', Colors.deepOrange),
                            buildButton('Rad to Deg', Colors.deepOrange),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            buildButton('sin', Colors.deepOrange),
                            buildButton('cos', Colors.deepOrange),
                            buildButton('tan', Colors.deepOrange),
                            buildButton('Deg to Rad', Colors.deepOrange),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            buildButton('x\u00B2', Colors.deepOrange),
                            buildButton('x\u00B3', Colors.deepOrange),
                            buildButton('x!', Colors.deepOrange),
                            buildButton('About', Colors.deepOrange),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            buildButton('(', Colors.blueGrey),
                            buildButton(')', Colors.blueGrey),
                            buildButton('^', Colors.blueGrey),
                            buildButton('AC', Colors.red),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            buildButton('%', Colors.blueGrey),
                            buildButton('e', Colors.blueGrey),
                            buildButton('PIE', Colors.blueGrey),
                            buildButton('DEL', Colors.orange),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            buildButton('7', Colors.blueGrey),
                            buildButton('8', Colors.blueGrey),
                            buildButton('9', Colors.blueGrey),
                            buildButton('+', Colors.blueGrey),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            buildButton('4', Colors.blueGrey),
                            buildButton('5', Colors.blueGrey),
                            buildButton('6', Colors.blueGrey),
                            buildButton('-', Colors.blueGrey),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            buildButton('1', Colors.blueGrey),
                            buildButton('2', Colors.blueGrey),
                            buildButton('3', Colors.blueGrey),
                            buildButton('×', Colors.blueGrey),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            buildButton('0', Colors.blueGrey),
                            buildButton('.', Colors.blueGrey),
                            buildButton('=', Colors.blueGrey),
                            buildButton('÷', Colors.blueGrey),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}
