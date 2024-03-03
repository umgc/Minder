import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VoiceRecognitionScreen(),
    );
  }
}

class VoiceRecognitionScreen extends StatefulWidget {
  @override
  _VoiceRecognitionScreenState createState() => _VoiceRecognitionScreenState();
}

class _VoiceRecognitionScreenState extends State<VoiceRecognitionScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and tell Minder your name!';
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _audioPlayer = AudioPlayer();
    _requestPermissions();
  }

  void _requestPermissions() async {
    await Permission.microphone.request();
  }

  void _startListening() {
    if (!_isListening) {
      _speech.listen(
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });
          _saveToFile(result.recognizedWords);
        },
        listenFor: Duration(seconds: 10),
      );

      setState(() {
        _isListening = true;
      });
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  void _saveToFile(String text) {
    File file = File('${Directory.systemTemp.path}/voice_recognition.txt');
    file.writeAsStringSync(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Voice Recognition')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('asset/images/speech-recognition.jpg', height: 300, width: 300),
            SizedBox(height: 20.0),
            Text(
              _text,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isListening ? _stopListening : _startListening,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isListening ? Colors.red : Color.fromARGB(255, 157, 201, 236), // Change colors as needed
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(_isListening ? Icons.stop : Icons.mic),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            // Add your custom screen widget here
            NewScreen1(),
          ],
        ),
      ),
    );
  }
}

class NewScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // Your existing NewScreen1 widget code
          // ...
        ),
      ],
    );
  }
}
