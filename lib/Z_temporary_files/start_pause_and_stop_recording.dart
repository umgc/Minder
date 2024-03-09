import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import '../Config/amplifyconfiguration.dart'; // Ensure this contains your Amplify project configuration

void main() {
  runApp(VideoRecordingApp());
}

class VideoRecordingApp extends StatefulWidget {
  @override
  _VideoRecordingAppState createState() => _VideoRecordingAppState();
}

class _VideoRecordingAppState extends State<VideoRecordingApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    if (!Amplify.isConfigured) {
      Amplify.addPlugins([AmplifyAuthCognito(), AmplifyStorageS3()]);
      try {
        await Amplify.configure(amplifyconfig);
        print("Amplify successfully configured");
      } catch (e) {
        print("Failed to configure Amplify: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Video Upload Demo')),
        body: Center(child: VideoRecordingScreen()),
      ),
    );
  }
}

class VideoRecordingScreen extends StatefulWidget {
  @override
  _VideoRecordingScreenState createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras.first, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startRecording() async {
    await _initializeControllerFuture;
    await _controller.startVideoRecording();
    setState(() {});
  }

  void _stopAndUploadRecording() async {
    final videoFile = await _controller.stopVideoRecording();
    final processedFilePath = await compute(_processVideo, videoFile.path);
    _uploadVideoToS3(processedFilePath);
    setState(() {});
  }

  static Future<String> _processVideo(String filePath) async {
    // Placeholder for processing logic
    await Future.delayed(Duration(seconds: 1)); // Simulate processing
    return filePath;
  }

  Future<void> _uploadVideoToS3(String filePath) async {
    final key = 'Uploads/${DateTime.now().millisecondsSinceEpoch}.mp4';
    try {
      await Amplify.Storage.uploadFile(local: File(filePath), key: key);
      print('Video successfully uploaded: $key');
    } catch (e) {
      print('Error uploading video: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              Expanded(child: CameraPreview(_controller)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _startRecording,
                    child: Text('Start Recording'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _stopAndUploadRecording,
                    child: Text('Stop & Upload'),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
