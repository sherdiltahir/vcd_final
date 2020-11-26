import 'package:flutter/material.dart';
import 'dart:async';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;
import '../Home.dart';

class Voicecalculator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VCD',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SpeechToText speech = SpeechToText();
  String outputtext = "";
  bool _hasSpeech = false;
  String _currentLocaleId = "en_US";
  double minSoundLevel = 500;
  double maxSoundLevel = -500;
  double level = 0.0;
  var answer = '';
  var _Solution = '';

  // calculations

  final List operator_list = [
    '+',
    '-',
    'x',
    '÷',
    'sin',
    'sine',
    'cosine',
    'cos',
    'cosin',
    'tan',
    'tangent',
    '!',
    'factorial',
    'power',
    '^',
    'square root',
    'ln',
    'log',
    'divide'
  ];
// list of operations are use in calculator

  ContextModel cm = ContextModel();

  String calculation(String _exp) {
    var my_exp = _exp.split(' ');
    print(my_exp);

    if (my_exp[1] == operator_list[0] ||
        my_exp[1] == operator_list[1] ||
        my_exp[1] == operator_list[2] ||
        my_exp[1] == operator_list[3] ||
        my_exp[1] == operator_list[18]) {
      try {
        String myexp = _exp.replaceAll('x', '*');
        String myexp1 = myexp.replaceAll('÷', '/');
        String myexp2 = myexp1.replaceAll('divide', '/');

        Parser p = Parser();
        Expression exp = p.parse(myexp2);
        var Eval = exp.evaluate(EvaluationType.REAL, cm);
        print(Eval);
        return "$Eval";
      } catch (e) {
        return "invalid";
      }
    } else if (my_exp[0] == operator_list[4] || my_exp[0] == operator_list[5]) {
      my_exp.add('');

      if (my_exp[2].isEmpty) {
        var string_to_int = double.parse(my_exp[1]);

        var Eval = math.sin(string_to_int);

        print(Eval);

        return "$Eval";
      } else {
        print('error');
        return "invalid";
      }
    } else if (my_exp[0] == operator_list[6] ||
        my_exp[0] == operator_list[7] ||
        my_exp[0] == operator_list[8]) {
      my_exp.add('');

      print(my_exp);

      if (my_exp[2].isEmpty) {
        var string_to_int = double.parse(my_exp[1]);

        var Eval = math.cos(string_to_int);

        print(Eval);

        return "$Eval";
      } else {
        print('error');
        return "invalid";
      }
    } else if (my_exp[0] == operator_list[9] ||
        my_exp[0] == operator_list[10]) {
      my_exp.add('');

      if (my_exp[2].isEmpty) {
        var string_to_int = double.parse(my_exp[1]);

        var Eval = math.tan(string_to_int);

        print(Eval);

        return "$Eval";
      } else {
        print('error');
        return "invalid";
      }
    } else if (my_exp[1] == operator_list[11] ||
        my_exp[1] == operator_list[12]) {
      my_exp.add('');
      if (my_exp[2].isEmpty) {
        var string_to_int = double.parse(my_exp[0]);
        double factorial = 1;
        for (int i = 1; i <= string_to_int; i++) {
          factorial = i * factorial;
        }
        print(factorial);

        return "$factorial";
      } else {
        print('error');
        return "invalid";
      }
    } else if (my_exp[1] == operator_list[13] ||
        my_exp[1] == operator_list[14]) {
      my_exp.add('');
      if (my_exp[3].isEmpty) {
        var string_to_int = double.parse(my_exp[0]);

        var string_to_int1 = double.parse(my_exp[2]);

        double power = math.pow(string_to_int, string_to_int1);

        print(power);

        return "$power";
      } else {
        print('error');
        return "invalid";
      }
    } else if (my_exp[0] + " " + my_exp[1] == operator_list[15]) {
      my_exp.add('');

      if (my_exp[3].isEmpty) {
        var string_to_int1 = double.parse(my_exp[2]);

        double squraeroot = math.sqrt(string_to_int1);

        print(squraeroot);

        return "$squraeroot";
      } else {
        print('error');
        return "invalid";
      }
    } else if (my_exp[0] == operator_list[16] ||
        my_exp[0] == operator_list[17]) {
      my_exp.add('');

      if (my_exp[2].isEmpty) {
        var string_to_int1 = double.parse(my_exp[1]);

        double logrithm = math.log(string_to_int1);

        print(logrithm);

        return "$logrithm";
      } else {
        print('error');
        return "invalid";
      }
    } else {
      print('error');
      return "invalid";
    }
  }


  @override
  void initState() {

    super.initState();

    initSpeechState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            Expanded(
                child: Center(
              child: Text("VCD"),
            ))
          ],
        ),
        backgroundColor: Color(0xFFCCCCCC),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(blurRadius: .26, spreadRadius: level * 2.4)
              ], borderRadius: BorderRadius.circular(90)),
              child: IconButton(
                iconSize: 45,
                onPressed: () {
                  _Solution = '';

                  !_hasSpeech || speech.isListening ? null : startListening();
                },
                icon: Icon(
                  Icons.mic,
                  color: speech.isListening ? Colors.pink : Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              child: Text(
                _Solution,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  void statusListener(String status) {
    print(status);
  }

  void errorListener(SpeechRecognitionError errorNotification) {
    print(errorNotification);
  }

  startListening() {
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 10),
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        partialResults: true,
        onDevice: true,
        listenMode: ListenMode.confirmation);
  }

  void resultListener(SpeechRecognitionResult result) {
    if (result.finalResult)
      setState(() {
        outputtext = result.recognizedWords;
        print(outputtext);
        //   outputtext = outputtext.replaceAll('divide', '/');
        answer = calculation(outputtext);
        outputtext = outputtext.replaceAll('divide', '/');
        outputtext = outputtext.replaceAll('factorial', '!');
        outputtext = outputtext.replaceAll('power', '^');

        if (answer != 'invalid') {
          _Solution = outputtext + " =" + answer;
        } else {
          _Solution = 'invalid';
        }
      });
  }

  soundLevelListener(double level) {
    minSoundLevel = math.min(minSoundLevel, level);
    maxSoundLevel = math.max(maxSoundLevel, level);
    setState(() {
      this.level = level;
    });
  }
}
