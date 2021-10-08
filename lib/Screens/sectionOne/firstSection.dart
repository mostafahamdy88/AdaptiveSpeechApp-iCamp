// ignore_for_file: non_constant_identifier_names, avoid_unnecessary_containers, prefer_const_constructors, file_names

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'message_style.dart';

class SpeechScreen extends StatefulWidget {
  static String routeName = "/SpeechScreen";
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  List<MessageStyle> message = [
    MessageStyle('Press the button and start speaking', 0)
  ];
  String _message = '';
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void add(String str, int i) {
    setState(() {
      message.add(MessageStyle(str, i));
    });
  }

  _dialogCreator(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          TextEditingController CustomController = TextEditingController();
          return AlertDialog(
            title: const Text("Enter your Message"),
            content: TextField(
              controller: CustomController,
            ),
            actions: [
              Container(
                child: TextButton(
                  child: Text('Confirm'),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context)
                          .pop(add(CustomController.text.toString(), 1));
                    });
                  },
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        backgroundColor: Color.fromRGBO(113, 48, 148, 1),
      ),
      backgroundColor: const Color.fromRGBO(36, 36, 62, 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Wrap(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AvatarGlow(
                animate: _isListening,
                glowColor: Theme.of(context).primaryColor,
                endRadius: 75.0,
                duration: const Duration(milliseconds: 2000),
                repeatPauseDuration: const Duration(milliseconds: 100),
                repeat: true,
                child: FloatingActionButton.extended(
                  heroTag: 'Listen',
                  onPressed: _listen,
                  icon: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    size: 30,
                  ),
                  label: Text("Listen"),
                ),
              ),
              FloatingActionButton.extended(
                heroTag: 'Text',
                onPressed: () {
                  _dialogCreator(context);
                },
                label: Text(
                  " Text",
                ),
                icon: Icon(
                  Icons.message,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 600,
              child: ListView.separated(
                  itemBuilder: (context, index) => message[index],
                  separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsetsDirectional.only(start: 20),
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                  itemCount: message.length),
            ),
          ],
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      print('ana hana');
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      print(available);
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            print(_text);

            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      add(_text, 0);
    }
  }
}
