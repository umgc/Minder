import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  bool isRecording = false;
  Timer? timer;
  int secondsElapsed = 0;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.high);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    controller?.dispose();
    super.dispose();
  }

  void startRecording() async {
    if (!controller!.value.isInitialized) {
      return;
    }
    try {
      await controller!.startVideoRecording();
      setState(() {
        isRecording = true;
        secondsElapsed = 0;
      });
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          secondsElapsed++;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void stopRecording() async {
    if (!controller!.value.isRecordingVideo) {
      return;
    }
    try {
      timer?.cancel();
      XFile videoFile = await controller!.stopVideoRecording();
      setState(() {
        isRecording = false;
      });
      // Optionally, save the video to the gallery or show a preview
      final String filePath = videoFile.path;
      print('Video recorded to $filePath');

      // Implement video saving or playback logic here
    } catch (e) {
      print(e);
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}';
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Camera Recording')),
      body: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: controller!.value.aspectRatio,
              child: CameraPreview(controller!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Timer: ${_formatDuration(Duration(seconds: secondsElapsed))}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: Icon(isRecording ? Icons.stop : Icons.camera),
                label: Text(isRecording ? 'Stop' : 'Record'),
                onPressed: () {
                  if (isRecording) {
                    stopRecording();
                  } else {
                    startRecording();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
