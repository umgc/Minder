import 'dart:async';
import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
//import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MobileFrame(child: RecordingScreen()),
    );
  }
}

class MobileFrame extends StatelessWidget {
  final Widget child;

  MobileFrame({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
          right: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

class RecordingScreen extends StatefulWidget {
  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  bool isRecording = false;
  bool isPaused = false;
  int secondsElapsed = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = initializeCamera();
  }

  Future<void> initializeCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    _controller = CameraController(
      cameras[0],
      ResolutionPreset.medium,
    );
    return _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20.0),
          Container(
            alignment: Alignment.center,
            child: Text(
              _formatDuration(Duration(seconds: secondsElapsed)),
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          SizedBox(height: 20.0),
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: CameraPreview(_controller),
                );
              } else {
                return Expanded(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                  if (isRecording) {
                    stopRecording();
                  } else {
                    startRecording();
                  }
                },
                backgroundColor: isRecording ? Colors.red : Colors.green,
                child: Icon(
                  isRecording ? Icons.stop : Icons.fiber_manual_record,
                  size: 40.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 20.0),
              if (isRecording)
                FloatingActionButton(
                  onPressed: () {
                    pauseOrResumeRecording();
                  },
                  backgroundColor: Colors.blue,
                  child: Icon(
                    isPaused ? Icons.play_arrow : Icons.pause,
                    size: 40.0,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
          SizedBox(height: 50.0),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void startRecording() {
    try {
      _initializeControllerFuture.then((_) async {
        await _controller.startVideoRecording();
        setState(() {
          isRecording = true;
          isPaused = false;
          secondsElapsed = 0;
        });

        timer = Timer.periodic(Duration(seconds: 1), (timer) {
          if (!isPaused) {
            setState(() {
              secondsElapsed++;
            });
          }
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void stopRecording() async {
    if (isRecording) {
      try {
        XFile videoFile = await _controller.stopVideoRecording();
        String path = videoFile.path;
        print("Video saved at: $path");

        // Upload video to S3
        await uploadVideoToS3(path);

        setState(() {
          isRecording = false;
          isPaused = false;
        });
        timer?.cancel();
      } catch (e) {
        print(e);
      }
    }
  }

  void pauseOrResumeRecording() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  Future<void> uploadVideoToS3(String filePath) async {
    try {
      File localFile = File(filePath);
      final key = 'Uploads/${DateTime.now().millisecondsSinceEpoch}.mp4';
      UploadFileResult result = await Amplify.Storage.uploadFile(
        local: localFile,
        key: key,
      );
      print('Successfully uploaded video: ${result.key}');
    } catch (e) {
      print('Error uploading video: $e');
    }
  }
}
