import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class MediaPlayer extends StatefulWidget {
  final String filePath;

  const MediaPlayer({Key? key, required this.filePath}) : super(key: key);

  @override
  _MediaPlayerState createState() => _MediaPlayerState();
}
class _MediaPlayerState extends State<MediaPlayer> {
  late VideoPlayerController _videoPlayerController;
  late AudioPlayer _audioPlayer = AudioPlayer();
  late bool _isPlaying = false;
  late bool _isVideo;
  late bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    _isVideo = widget.filePath.toLowerCase().endsWith('.mp4');
    if (_isVideo) {
      _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
      _videoPlayerController.initialize().then((_) {
        setState(() {});
      });
    } else {
      // _audioPlayer = AudioPlayer();
      playAudio(widget.filePath);
      _audioPlayer.onPlayerStateChanged.listen((state) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      });
    }
  }

  @override
  void dispose() {
    _isMounted = false; 
  if (_isVideo) {
    _videoPlayerController.dispose();
  } else {
    _audioPlayer.dispose();
  }
  super.dispose();
}


  Future<void> playAudio(String path) async {
    if (path.isEmpty) {
      return; 
    }
    try {
      await _audioPlayer.play(UrlSource(path));
      _audioPlayer.onPlayerStateChanged.listen((state) {
        bool isPlaying = state == PlayerState.playing;
        if(_isMounted){
        setState(() {
          _isPlaying = isPlaying;
        });
        }
      });
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Future<void> _toggleAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
  }


  Widget _buildVideoPlayer() {
    return _videoPlayerController.value.isInitialized
        ? Column(
            children: [
              AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              ),
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  setState(() {
                    if (_isPlaying) {
                      _videoPlayerController.pause();
                    } else {
                      _videoPlayerController.play();
                    }
                    _isPlaying = !_isPlaying;
                  });
                },
              ),
            ],
          )
        : CircularProgressIndicator();
  }

  Widget _buildAudioPlayer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.audiotrack),
        const SizedBox(height: 16),
        Text('Audio Player'),
        IconButton(
          icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: _toggleAudio,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Media Player')),
      body: Center(
        child: _isVideo ? _buildVideoPlayer() : _buildAudioPlayer(),
      ),
    );
  }
}
