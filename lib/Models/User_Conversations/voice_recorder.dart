import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:minder/Models/User_Conversations/user_conversation_list.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class RecordingData {
  final String id;
  final String convName; 
  final String summary;
  final String fileLocation;
  final String type;
  final String date;
  final String notes;
  final String rem;
    int saved; 

  RecordingData({
    String? id,
    required this.convName,
    required this.summary,
    required this.fileLocation,
    required this.type,
    required this.notes,
    required this.date,
    required this.rem,
    this.saved = 0,
   
  }): id = id ?? Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'convName': convName,
      'summary': summary,
      'fileLocation': fileLocation,
      'type': type,
      'notes': notes,
      'date': date,
      'rem': rem,
      'saved': saved,
      
    };
  }
}

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
  late String _path;
  late Duration _duration = Duration(seconds: 0);
  late Timer _timer;
  String _id = Uuid().v4();

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    _timer.cancel();
    recorder.closeRecorder();
    super.dispose();
  }

  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Mic permission not granted';
    }

    final directory = await getApplicationDocumentsDirectory();
    _path = '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac';
    await recorder.openRecorder();

    setState(() {
      isRecorderReady = true;
      _duration = Duration(seconds: 0);
    });
  }

  Future<void> record() async {
    if (!isRecorderReady) return;

    await recorder.startRecorder(toFile: _path);

    setState(() {
      isRecording = true;
      _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        setState(() {
          _duration = Duration(seconds: _duration.inSeconds + 1);
        });
      });
    });
  }

    Future<void> stop() async {
    await recorder.stopRecorder();
    _timer.cancel();
    setState(() {
      isRecording = false;
    });

    // Save recording data to JSON file
    saveRecordingData();
  }

 Future<void> saveRecordingData() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/recordings.json';

    final recordingData = RecordingData(
      id: _id,
      convName: 'Conversation', 
      summary: '',
      fileLocation: _path,
      type: '',
      notes: '',
      date: DateTime.now().toString(),
      rem: '',
      saved: 0, 
    );

    List<dynamic> jsonRecordings = await readJsonFile(filePath);
    jsonRecordings.add(recordingData.toJson());

    await writeJsonFile(filePath, jsonRecordings);
  }


  Future<List<dynamic>> readJsonFile(String filePath) async {
  File file = File(filePath);
  if (await file.exists()) {
    String content = await file.readAsString();
    dynamic decodedContent = jsonDecode(content);
    return decodedContent is List ? decodedContent : [decodedContent];
  } else {
    return [];
  }
}


  Future<void> writeJsonFile(String filePath, List<dynamic> jsonData) async {
    File file = File(filePath);
    await file.writeAsString(jsonEncode(jsonData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
         Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConversationListScreen(),
                    ),);
          },
        ),
        title: Text('Conversation Recorder Voice'),
        
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
            Text(
              '${_duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${_duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: IconButton(
                icon: Icon(isRecording ? Icons.stop : Icons.mic),
                onPressed: () async {
                  if (recorder.isRecording) {
                    await stop();
                  } else {
                    await record();
                  }
                },
                iconSize: 100.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}