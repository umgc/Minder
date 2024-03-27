//Contributors 
  // Functionality and UI Development Input Lensa Gemeda
  // Functionality and UI Development Input - Elsa Bushen
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:minder/Models/Video_Recording/video_page.dart';

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
        title: Text('Timer: $_timerSeconds seconds'),
      ),
      body: Stack(
        children: [
          CameraPreview(_cameraController),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: _recordVideo,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _isRecording ? Colors.transparent :  const Color.fromRGBO(47, 102, 127, 1), width: 4),
                  ),
                  child: Material( // Wrap with Material widget
                    elevation: _isRecording ? 0 : 4, // Set elevation based on recording state
                    shape: CircleBorder(),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        _isRecording
                            ? Container()
                            : Icon(
                                Icons.circle,
                                size: 25,
                                color:  const Color.fromRGBO(47, 102, 127, 1),
                              ),
                        _isRecording
                            ? Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.redAccent, width: 4),
                                ),
                                child: Icon(
                                  Icons.stop,
                                  size: 40,
                                  color: Colors.redAccent,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

}

  
