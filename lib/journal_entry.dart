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
  String _text = '';
  late TextEditingController _textController; // Declare a TextEditingController

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(); // Initialize the TextEditingController
    _listen();
  }

  @override
  void dispose() {
    _textController.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

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
          _textController.text = _text; // Update the controller's text
        }),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                width: 350, // Specify your desired width
                height: 550, // Specify your desired height
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: TextField(
                      controller: _textController, // Use the TextEditingController
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: null, // Allows the text field to expand vertically
                      keyboardType: TextInputType.multiline, // Facilitates multiline input
                      decoration: InputDecoration(
                        hintText: "Start speaking...", // Placeholder text
                        border: InputBorder.none, // Removes the underline
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  _listen();
                },
                child: Container(
                  alignment: Alignment.center,
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 5.0),
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        child: Icon(
                          Icons.mic,
                          color: Color.fromARGB(255, 144, 202, 255), // Lighter shade
                          size: 45,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add your save functionality here
                },
                child: Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}


