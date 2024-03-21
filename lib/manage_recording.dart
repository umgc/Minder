import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:minder/Models/User_Conversations/user_conversation_list.dart';

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
  }) : id = id ?? Uuid().v4();

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
      debugShowCheckedModeBanner: false,
      home: VideoRecordingScreen(),
    );
  }
}

class VideoRecordingScreen extends StatefulWidget {
  @override
  _VideoRecordingScreenState createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  late CameraController _controller;
  bool isRecording = false;
  Timer? timer;
  int secondsElapsed = 0;
  String _id = Uuid().v4();
  late String _path;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras.first, ResolutionPreset.medium);
    await _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    timer?.cancel();
    super.dispose();
  }

  Future<void> startRecording() async {
    if (!isRecording && _controller.value.isInitialized) {
      final directory = await getApplicationDocumentsDirectory();
      _path = '${directory.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';
      await _controller.startVideoRecording();
      setState(() {
        isRecording = true;
        secondsElapsed = 0;
      });

      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          secondsElapsed++;
        });
      });
    }
  }

Future<void> stopRecording() async {
  if (isRecording) {
    await _controller.stopVideoRecording();
    setState(() {
      isRecording = false;
      timer?.cancel();
      secondsElapsed = 0;
    });
    // Save recording data to JSON file
    saveRecordingData();
  }
}

  Future<void> saveRecordingData() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/recordings.json';
    final recordingData = RecordingData(
      id: _id,
      convName: 'Video Conversation',
      summary: 'A video recording',
      fileLocation: _path,
      type: 'video',
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
      return jsonDecode(content) as List<dynamic>;
    }
    return [];
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
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConversationListScreen(),
            ),
          );
        },
      ),
      title: Text('Video Recorder'),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (secondsElapsed > 0)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _formatDuration(Duration(seconds: secondsElapsed)),
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
        Expanded(
          child: FutureBuilder<void>(
            future: Future<void>.delayed(Duration.zero, () {}),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                width: 4,
              ),
            ),
            child: FloatingActionButton(
              onPressed: () {
                if (isRecording) {
                  stopRecording();
                } else {
                  startRecording();
                }
              },
              elevation: 0,
              backgroundColor: Color.fromARGB(0, 177, 176, 176),
              child: Icon(
                isRecording ? Icons.stop : Icons.circle,
                size: 28.0,
                color: isRecording ? Colors.red[400] : Color.fromARGB(255, 93, 124, 150),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

}

String _formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  return "${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
}
       
  
