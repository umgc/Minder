import 'dart:async';
import 'dart:io';
//import 'package:amplify_flutter/amplify_flutter.dart'; // Amplify core package for Flutter
import 'package:flutter/material.dart'; // Material Design package for Flutter
import 'package:camera/camera.dart'; // Camera package for accessing device cameras
//import 'package:amplify_storage_s3/amplify_storage_s3.dart';
//import 'package:minder/amplifyconfiguration.dart'; // Amplify Storage package for S3




void main() {
  runApp(MyApp()); // Entry point of the application, running the MyApp widget
}

Future<void> _configureAmplify() async {
  try {
    // Add Amplify plugins
  //  await Amplify.addPlugins([AmplifyStorageS3()]);
    // Configure
    //await Amplify.configure(amplifyconfig);
    print("Successfully configured Amplify 🎉");
  } catch (e) {
    print("Could not configure Amplify: $e");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Builds the MaterialApp with RecordingScreen as the home page
    return MaterialApp(
      home: RecordingScreen(),
    );
  }
}

class RecordingScreen extends StatefulWidget {
  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  late CameraController _controller; // Controller for camera operations
  late Future<void> _initializeControllerFuture; // Future to wait for camera initialization

  bool isRecording = false; // Flag to track recording state
  int secondsElapsed = 0; // Counter for elapsed seconds during recording

  Timer? timer; // Timer to update elapsed recording time

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = initializeCamera(); // Initialize camera on widget initialization
  }

  Future<void> initializeCamera() async {
    // Asynchronously initializes the camera
    final cameras = await availableCameras(); // Gets a list of available cameras
    _controller = CameraController(
      cameras.first, // Selects the first camera
      ResolutionPreset.medium, // Sets the resolution preset to medium
    );
    await _controller.initialize(); // Initializes the controller with the selected camera
  }

  @override
  void dispose() {
    // Cleans up controller when the widget is disposed
    _controller.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Builds the UI of the recording screen
    return Scaffold(
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20.0),
          Container(
            alignment: Alignment.center,
            child: Text(
              _formatDuration(Duration(seconds: secondsElapsed)), // Displays formatted duration of recording
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          SizedBox(height: 20.0),
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If camera is initialized, display the camera preview
                return Expanded(
                  child: CameraPreview(_controller),
                );
              } else {
                // While waiting for camera to initialize, display a loading indicator
                return Expanded(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
          SizedBox(height: 20.0),
          FloatingActionButton(
            onPressed: startOrStopRecording,
            backgroundColor: isRecording ? Colors.red : Colors.green,
            child: Icon(
              isRecording ? Icons.stop : Icons.fiber_manual_record,
              size: 40.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 50.0),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void startOrStopRecording() {
    if (isRecording) {
      stopRecording();
    } else {
      startRecording();
    }
  }

  void startRecording() async {
    try {
      await _initializeControllerFuture;
      await _controller.startVideoRecording();
      setState(() {
        isRecording = true;
        secondsElapsed = 0;
      });
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() {
          secondsElapsed++;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void stopRecording() async {
    if (isRecording) {
      try {
        final videoFile = await _controller.stopVideoRecording();
        final path = videoFile.path;
        print("Video saved at: $path");
      //  uploadVideoToS3(path);
        setState(() {
          isRecording = false;
        });
        timer?.cancel();
      } catch (e) {
        print(e);
      }
    }
  }

  //Future<void> uploadVideoToS3(String filePath) async {
  //try {
    // Create a File instance from the given filePath
    //final file = File(filePath);

    // Generate a unique key (file name in S3) using the current timestamp
   // final fileName = DateTime.now().millisecondsSinceEpoch.toString() + ".mp4";
    //final s3Key = "uploaded_videos/$fileName";

    // Upload the file to S3
   // final result = await Amplify.Storage.uploadFile(
    //  local: file,
    //  key: s3Key,
    //  onProgress: (progress) {
        // Optionally, print upload progress
        //print("Upload Progress: ${progress.getFractionCompleted() * 100}%");
    //  },
  //  );

    // Log the success of the upload
  //  print('Successfully uploaded video: ${result.key}');
//  } catch (e) {
    // Log any errors that occur during the upload
    //print('Error uploading video: $e');
 // }
//}

}
