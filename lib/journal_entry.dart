import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailPage extends StatefulWidget {
  final DateTime date; // Required variable

  DetailPage({required this.date}); // Constructor with required date parameter

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  SpeechToText _speechToText = SpeechToText();
    bool _speechEnabled = false;
      String _lastWords = '';
      String _totaltext = '';
      String _savedWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  bool _shouldKeepListening = true;
  
void _startListening() async {
  while (_shouldKeepListening) {
    _savedWords = _lastWords;
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
    // Small delay to prevent immediate restart and allow for any necessary cleanup
    await Future.delayed(Duration(milliseconds: 0));
    // Assuming _lastWords is updated in _onSpeechResult
    _totaltext += _lastWords.replaceFirst(_savedWords, " "); // result is "Hello, !"
    // _totaltext += _lastWords; // This will now add only new words not included in _savedWords
  }
}

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    
    setState(() {
      _shouldKeepListening = false;
    });
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
void _onSpeechResult(SpeechRecognitionResult result) {
  // Extract new words by removing _savedWords from the result
  String newWords = result.recognizedWords.replaceFirst(_savedWords, '').trim();
  setState(() {
    _lastWords = newWords;
    // Now _lastWords contains only the new words not previously saved
  });
}
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
                  child: _speechToText.isListening ? TextField(
                    controller: TextEditingController(text: '$_totaltext'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ) : _speechEnabled
                          ? TextField(
                              controller: TextEditingController(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text('Speech not available',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
    
        SizedBox(
          height: 20,
        
        ),
      Padding(
  padding: EdgeInsets.only(top: 50.0,left: 0.0), // Add space above the button
  child: ElevatedButton(
    onPressed: _speechToText.isNotListening ? _startListening : _stopListening,
    child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      shape: CircleBorder(),
      padding: EdgeInsets.all(20), // Button size
        ),
      )
        ) ],
        ),
      ),
    ));
  }



}