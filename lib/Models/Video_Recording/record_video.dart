import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoRecorder {
  late CameraController controller;
  late Future<void> initializeControllerFuture;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras.first, ResolutionPreset.medium);
    initializeControllerFuture = controller.initialize();
  }

  void dispose() {
    controller.dispose();
  }
}
