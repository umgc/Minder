import 'dart:async';
import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

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

  const MobileFrame({required this.child});

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
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
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
          SizedBox(height: 10.0),
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
          SizedBox(height: 10.0),
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
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
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
          secondsElapsed = 0;
        });

        timer = Timer.periodic(Duration(seconds: 1), (timer) {
          setState(() {
            secondsElapsed++;
          });
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

      setState(() {
        isRecording = false;
      });

      // Wait for the video upload to complete
      await uploadVideoToS3(path);

    } catch (e) {
      print(e);
    }
  }
}

Future<void> uploadVideoToS3(String filePath) async {
  try {
    final key = 'uploaded_video_${DateTime.now().millisecondsSinceEpoch}.mp4';
    final File videoFile = File(filePath);

    final UploadFileResult result = await Amplify.Storage.uploadFile(
      local: videoFile,
      key: key,
    );

    print('Upload successful: ${result.key}');

    // Once uploaded, you can perform any further actions
    // such as updating UI or navigating to another screen
  } catch (e) {
    print('Error uploading video: $e');
  }
}
}
