import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideoPage extends StatelessWidget {
  final String videoPath;

  const PlayVideoPage({required this.videoPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play Video'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _initializeVideoPlayer(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return AspectRatio(
                aspectRatio: 16 / 9,
                child: VideoPlayer(snapshot.data as VideoPlayerController),
              );
            }
          },
        ),
      ),
    );
  }

  Future<VideoPlayerController> _initializeVideoPlayer() async {
    final File videoFile = File(videoPath);
    final controller = VideoPlayerController.file(videoFile);

    await controller.initialize();

    // Start playing the video
    controller.play();

    return controller;
  }
}

void main() {
  runApp(MaterialApp(
    home: PlayVideoPage(videoPath: 'YOUR_VIDEO_PATH_HERE'),
  ));
}
