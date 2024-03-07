import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MobileFrame(child: RecordingScreen()),
    );
  }
}

class MobileFrame extends StatelessWidget {
  final Widget child;

  const MobileFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border(
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
        boxShadow: const [],
      ),
      child: child,
    );
  }
}

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  bool isRecording = false;
  bool isPaused = false;
  int secondsElapsed = 0;

  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Timer at the top
          const SizedBox(height: 0),
          Text(
            _formatDuration(Duration(seconds: secondsElapsed)),
            style: const TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 350.0),
          // Record/pause/stop buttons at the bottom
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
              const SizedBox(width: 20.0),
              if (isRecording) // Show pause button only during recording
                FloatingActionButton(
                  onPressed: () {
                    pauseRecording();
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
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  void startRecording() {
    // Your logic for starting recording
    timer?.cancel(); // Cancel the existing timer
    setState(() {
      isRecording = true;
      isPaused = false;
      secondsElapsed = 0;
    });

    // Start timer
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused) {
        setState(() {
          secondsElapsed++;
        });
      }
    });
  }

  void stopRecording() {
    // Your logic for stopping recording
    timer?.cancel(); // Cancel the timer
    setState(() {
      isRecording = false;
      isPaused = false;
    });
  }

  void pauseRecording() {
    // Your logic for pausing recording
    setState(() {
      isPaused = !isPaused;
    });
  }
}
