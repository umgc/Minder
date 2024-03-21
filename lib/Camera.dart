import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:minder/video_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraPage(),
    );
  }
}class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isLoading = true;
  bool _isRecording = false;
  int _timerSeconds = 0;
  late Timer _timer;

  @override
  void initState() {
    _initCamera();
    super.initState();
      _timer = Timer(Duration(seconds: 0), () {});
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _timer.cancel();
    super.dispose();
  }

  _initCamera() async {
    final cameras = await availableCameras();
    final back = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
    _cameraController = CameraController(back, ResolutionPreset.low); // Set resolution to low
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

 _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timerSeconds++;
      });
    });
  }
  _stopTimer() {
    _timer.cancel();
    setState(() {
      _timerSeconds = 0;
    });
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      _stopTimer();
      setState(() => _isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(filePath: file.path),
      );
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      _startTimer();
      setState(() => _isRecording = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Video Recorder - Timer: $_timerSeconds seconds'),
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CameraPreview(_cameraController),
              Padding(
                padding: const EdgeInsets.all(25),
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: Icon(_isRecording ? Icons.stop : Icons.circle),
                  onPressed: () => _recordVideo(),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
