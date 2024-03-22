//work on progress 
  //Drafted by: Elsa Bushen

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(MyApp());
}

/// Main application widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner for a cleaner UI.
      home: VoiceTestScreen(), // Sets the home screen of the app.
    );
  }
}

/// A screen that demonstrates speech to text capabilities.
class VoiceTestScreen extends StatefulWidget {
  @override
  _VoiceTestScreenState createState() => _VoiceTestScreenState();
}

class _VoiceTestScreenState extends State<VoiceTestScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText(); // Instance of SpeechToText.
  bool _isListening = false; // Flag to track if the app is currently listening.
  String _text = 'Press the button and start speaking'; // Text to display the speech result.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech to Text Demo'), // App bar title.
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _listen, // Calls the _listen function when pressed.
        child: Icon(_isListening ? Icons.mic_off : Icons.mic), // Changes icon based on listening state.
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: Text(
            _text, // Displays the recognized text.
            style: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  /// Toggles the speech listening state.
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(); // Initialize speech recognition.
      if (available) {
        setState(() => _isListening = true); // Start listening.
        _speech.listen(
          onResult: (result) => setState(() {
            _text = result.recognizedWords; // Updates the UI with the recognized words.
            // Optionally, you can also use result.confidence here if needed.
          }),
        );
      }
    } else {
      setState(() => _isListening = false); // Stop listening.
      _speech.stop(); // Stop the speech recognition.
    }
  }
}

 