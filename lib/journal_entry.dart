import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class DetailPage extends StatefulWidget {
  final DateTime date; // Required variable

  DetailPage({required this.date}); // Constructor with required date parameter

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  stt.SpeechToText _speech = stt.SpeechToText();
  String _text = 'Speak Now';

  @override
  void initState() {
    super.initState();
    _listen();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Center(
        child: Container(alignment: Alignment.center
        ,
        child: Column(children: [
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              _text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        
        ),
        GestureDetector(
                    onTap: () {
                  _listen();                },
                  child: Container(
                    alignment: Alignment.center,
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 5.0),

                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          child: Icon(
                            Icons.mic,
                            color: Color.fromARGB(255, 144, 202, 255), // Lighter shade
                            size: 45,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
        ],),
        ),
      ),
    );
  }


// Ensure _listen is a Future<void> function
Future<void> _listen() async {
  var status = await Permission.microphone.status;
  if (!status.isGranted) {
    await Permission.microphone.request();
  }
  bool available = await _speech.initialize(
    onStatus: (val) => print('onStatus: $val'),
    onError: (val) => print('onError: $val'),
  );
  if (available) {
    await _speech.listen(
      onResult: (val) => setState(() {
        _text = val.recognizedWords;
      }),
    );
    // Assuming _speech.listen is asynchronous and you wait for it to finish
    // You might need to adjust this based on how your speech to text package signals completion
  }
}
}