import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'file:///D:/MyFyp/vcd_final/lib/Home.dart';
import 'Database_manager.dart';



class Dictionary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VoiceDictionary(),
    );
  }
}

String temp;

class VoiceDictionary extends StatefulWidget {
  @override
  _VoiceDictionaryState createState() => _VoiceDictionaryState();
}

class _VoiceDictionaryState extends State<VoiceDictionary> {
  final SpeechToText speech = SpeechToText();
  String outputtext = "";
  bool _hasSpeech = false;
  String _currentLocaleId = "en_US";
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  double level = 0.0;
  String _url = "https://owlbot.info/api/v4/dictionary/";
  String _token = "1041e856eee82a02d72ada77cc257fad9e629d3e";
  final FlutterTts mytts = FlutterTts();
  TextEditingController _controller = TextEditingController();
  StreamController _streamController;
  Stream _stream;
  Timer _debounce;
  Words _words;
  final DbwordManager _dbwordManager = DbwordManager();
  Color starcolor;
  List<Words> _wordlist;
  int i = 0;

  _search() async {
    if (_controller.text == null || _controller.text.length == 0) {
      _streamController.add(null);
      return;
    }

    _streamController.add("waiting");

    Response response = await get(_url + _controller.text.trim(),
        headers: {"Authorization": "Token " + _token});
    if (response.statusCode == 200) {
      _streamController.add(json.decode(response.body));


      var checkk = await _dbwordManager
          .checkword(_controller.text);
      print(checkk);
      if (checkk != false) {
        setState(() {
          starcolor =
              Colors.redAccent;        });
      } else {
        if (_words == null) {
          setState(() {
            starcolor = Colors.grey;
          });
        }
      }

//      var check = _dbwordManager.checkword(_controller.text);
//      if (check != false) {
//        setState(() {
//          starcolor = Colors.redAccent;
//        });
//      } else {
//        setState(() {
//          starcolor = Colors.grey;
//        });
//      }
    } else {
      _streamController.add("empty");
    }
  }

  Future _speak(String texts) async {
    await mytts.setLanguage("en-EU");
    await mytts.setPitch(1);
    await mytts.speak(texts);
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
    initSpeechState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(

        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text("Bookmark",style: TextStyle(fontWeight: FontWeight.w400,
            fontSize: 40),),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: FutureBuilder(
                future: _dbwordManager.getWordlist(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _wordlist = snapshot.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: _wordlist == null ? 0 : _wordlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        i++;
                        Words w = _wordlist[index];

                        return Card(
                          child: Container(
                            height: 40,
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  _controller.text = w.wname;
                                  _search();
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    w.wname,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return new CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
              },icon: Icon(Icons.arrow_back,)),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.only(left: 2, bottom: 8.0, right: 2,top: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TextFormField(
                  onChanged: (String text) {
                    setState(() {
                      if (_debounce?.isActive ?? false) _debounce.cancel();
                      _debounce = Timer(const Duration(milliseconds: 1000), () {
                        _search();
                      });
                    });
                  },
                  controller: _controller,
                  decoration: InputDecoration(
                      hintText: "Search for a word",
                      contentPadding: const EdgeInsets.only(left: 24.0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                          borderRadius: BorderRadius.circular(24.0))),
                ),
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onDoubleTap: () {
          setState(() {
            _controller.clear();
            return _search();
          });
        },
        child: Container(
          child: StreamBuilder(
            stream: _stream,
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(blurRadius: .26, spreadRadius: level * 1.5)
                      ]),
                      child: IconButton(
                        onPressed: () {
                          !_hasSpeech || speech.isListening
                              ? null
                              : startListening();
                        },
                        icon: Icon(
                          Icons.mic,
                          color:
                              speech.isListening ? Colors.pink : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ));
              }

              if (snapshot.data == "waiting") {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data == "empty") {
                return GestureDetector(
                  onDoubleTap: () {
                    _controller.clear();
                    return _search();
                  },
                  child: Center(
                    child: Container(
                        height: 400,
                        width: 400,
                        child: Text(
                          "Sorry Word Is Not Found",
                          textAlign: TextAlign.center,
                        )),
                  ),
                );
              }
              return Container(
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                            color: Colors.white,
                            height: 110,
                            padding: EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                                        child: IconButton(
                                          icon: Icon(Icons.volume_up),
                                          onPressed: () {
                                            _speak(_controller.text);
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          _controller.text,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                      ),
                                      Container(
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() async {
                                              var checkk = await _dbwordManager
                                                  .checkword(_controller.text);
                                              print(checkk);
                                              if (checkk != false) {
                                                setState(() {
                                                  starcolor = Colors.grey;
                                                });

                                                _dbwordManager.deleteWord(
                                                    _controller.text);
                                              } else {
                                                if (_words == null) {
                                                  setState(() {
                                                    starcolor =
                                                        Colors.redAccent;
                                                  });

                                                  Words w = new Words(
                                                      wname: _controller.text);
                                                  _dbwordManager
                                                      .insertWord(w)
                                                      .then((id) => print(w));
                                                }
                                              }
                                            });
                                          },
                                          icon: Icon(
                                            Icons.star, color: starcolor,
//                                            color: _dbwordManager.checkword(_controller.text) == true? starcolor_y : starcolor_g
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: snapshot.data["pronunciation"] ==
                                              null
                                          ? null
                                          : Text("Pronunciation: " +
                                              snapshot.data["pronunciation"]),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: ListView.builder(
                          itemCount: snapshot.data["definitions"].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: <Widget>[
                                Divider(
                                  color: Colors.white,
                                  height: 12,
                                ),
                                ListBody(
                                  children: <Widget>[
                                    Container(
                                      color: Colors.grey[200],
                                      child: ListTile(
                                        leading: snapshot.data["definitions"]
                                                    [index]["image_url"] ==
                                                null
                                            ? null
                                            : CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    snapshot.data["definitions"]
                                                        [index]["image_url"]),
                                              ),
                                        title: Column(
                                          children: <Widget>[
                                            Container(
                                              child: snapshot.data[
                                                              "definitions"]
                                                          [index]["type"] ==
                                                      null
                                                  ? null
                                                  : Text(
                                                      "(" +
                                                          snapshot.data[
                                                                  "definitions"]
                                                              [index]["type"] +
                                                          ")",
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 12),
                                                    ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              child: Text(
                                                "Definition: " +
                                                    snapshot.data["definitions"]
                                                        [index]["definition"],
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: snapshot.data["definitions"][index]
                                                  ["example"] ==
                                              null
                                          ? null
                                          : Text(
                                              "Example: " +
                                                  snapshot.data["definitions"]
                                                      [index]["example"],
                                              style: TextStyle(wordSpacing: 2),
                                            ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
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
        _controller.text = outputtext;
        _search();
        print(outputtext);
      });
  }

  soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    setState(() {
      this.level = level;
    });
  }
}
