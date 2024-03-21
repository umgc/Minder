import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minder/Caregiver_Conversation/patient_conversation_list.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';




class VideoPage extends StatefulWidget {
  final String filePath;

  const VideoPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
String _id = Uuid().v4();
  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

Future<void> _saveVideo() async {
  final Directory appDirectory = await getApplicationDocumentsDirectory();
  final String appPath = appDirectory.path;
  final String fileName = 'vrecording_${DateTime.now().millisecondsSinceEpoch}.mp4'; // You can customize the file name

  final String destinationPath = '$appPath/$fileName';

  // Copy the video file to the destination path
  await File(widget.filePath).copy(destinationPath);

  // Save the video file path to recordings.json
  saveRecordingData(destinationPath); // Pass the destination path

  // Show a message indicating that the video has been saved
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Video saved successfully!'),
    ),
  );
    Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConversationListScreen(),
              ),
            );
}

Future<void> saveRecordingData(String filePath) async {
  final Directory appDirectory = await getApplicationDocumentsDirectory();
  final String recordingsFilePath = '${appDirectory.path}/recordings.json';

  final recordingData = {
    'id': _id,
    'convName': 'Video Conversation',
    'summary': 'A video recording',
    'fileLocation': filePath, // Assign the video file path here
    'type': 'video',
    'date': DateTime.now().toString(),
    'notes': '',
    'rem': '',
    'saved': 0,
  };

  List<dynamic> jsonRecordings = await readJsonFile(recordingsFilePath);
  jsonRecordings.add(recordingData);
  await writeJsonFile(recordingsFilePath, jsonRecordings);
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
        title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () { 
            _videoPlayerController.pause();
            //  _videoPlayerController.dispose(); 
            _saveVideo();
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _videoPlayerController.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return VideoPlayer(_videoPlayerController);
          }
        },
      ),
    );
  }
}
