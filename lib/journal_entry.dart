import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class DetailPage extends StatefulWidget {
  final DateTime date; // Required variable

  DetailPage({required this.date}); // Constructor with required date parameter

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final SpeechToText speech = SpeechToText();

  var errors = StreamController<SpeechRecognitionError>();
  var statuses = BehaviorSubject<String>();
  var words = StreamController<SpeechRecognitionResult>();

  var _localeId = '';
  bool _continueListening = false; // Flag to control continuous listening

  Future<bool> initSpeech() async {
    bool hasSpeech = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener,
    );

    if (hasSpeech) {
      var systemLocale = await speech.systemLocale();
      _localeId = systemLocale!.localeId;
    }

    return hasSpeech;
  }

  void startListening() {
    _continueListening = true; // Enable continuous listening
    _listen();
  }

  void _listen() {
    speech.stop(); // Ensure any previous session is stopped
    speech.listen(
      onResult: resultListener,
      listenFor: Duration(minutes: 3),
      localeId: _localeId,
      onSoundLevelChange: null,
      cancelOnError: true,
      partialResults: true,
    );
  }

  void errorListener(SpeechRecognitionError error) {
    errors.add(error);
  }

  void statusListener(String status) {
    statuses.add(status);
    if (status == "notListening" && _continueListening) {
      _listen(); // Restart listening if it was stopped unintentionally
    }
  }

  void resultListener(SpeechRecognitionResult result) {
    words.add(result);
  }

  void stopListening() {
    _continueListening = false; // Disable continuous listening
    speech.stop();
  }

  void cancelListening() {
    _continueListening = false; // Ensure listening doesn't restart
    speech.cancel();
  }

  @override
  

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  height: 500,
                  width: 330, // Set your desired height here
                  child: StreamBuilder<SpeechRecognitionResult>(
                    stream: words.stream, // Your StreamController's stream
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // Extracting text from the SpeechRecognitionResult
                        String textToShow = snapshot.data!.recognizedWords; // Assuming recognizedWords is the text
                        return Text(
                          textToShow,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        // Placeholder text or an empty Container when there's no data
                        return Text(
                          "Listening...",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),

    
        SizedBox(
          height: 20,
        
        ),
      ElevatedButton(
        onPressed: () {
          startListening();
        },
        child: Icon(Icons.mic),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Corrected from primary to backgroundColor
          foregroundColor: Colors.white, // Corrected from onPrimary to foregroundColor
          shape: CircleBorder(), // Circular button
          padding: EdgeInsets.all(20), // Button size
        ),
      )
        ],),
        ),
      ),
    );
  }



}