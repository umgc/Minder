import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AudioRecorderScreen(),
    );
  }
}

class AudioRecorderScreen extends StatefulWidget {
  @override
  _AudioRecorderScreenState createState() => _AudioRecorderScreenState();
}

class _AudioRecorderScreenState extends State<AudioRecorderScreen> {
  final recorder = FlutterSoundRecorder();
  bool isRecording = false;
  bool isRecorderReady = false;
String _path = '';
  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Mic permission not granted';
    }

    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(const Duration(microseconds: 500));
  }

  Future record() async {
    if (!isRecorderReady) return;

    final directory = await getApplicationDocumentsDirectory();
    _path = '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac';
  
    await recorder.startRecorder(toFile: _path);
    setState(() {
      isRecording = true;
    });
  }

  Future stop() async {
    await recorder.stopRecorder();
    final directory = await getApplicationDocumentsDirectory();
    final audioFile = File(_path);
    print('Recorded audio: $audioFile');
    setState(() {
      isRecording = false;
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Tap on mic icon to start recording',
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 20),
          StreamBuilder <RecordingDisposition>(stream: recorder.onProgress, builder: (context, snapshot){
            final duration = snapshot.hasData
            ? snapshot.data!.duration
            : Duration.zero;

            String twoDigits(int n) => n.toString().padLeft(2);
            final twoDigitMinutes = 
                      twoDigits(duration.inMinutes.remainder(60));
            final twoDigitSeconds = 
                      twoDigits(duration.inMinutes.remainder(60));                      
            return Text('${duration.inSeconds}s', style: const TextStyle(fontSize: 25), );

          }),
          const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue, // Adjust the color according to your preference
            ),
            child: IconButton(
              icon: Icon(isRecording ? Icons.stop : Icons.mic),
              onPressed: () async {
                if(recorder.isRecording){
                  await stop();
                }
                else {await record();
                }

                setState((){});
              },
              iconSize: 100.0,
              color: Colors.white, // Adjust the color of the icon
            ),
          ),
          // Add a Text widget to display recording duration (optional)
        ],
      ),
    ),
  );
}

}
