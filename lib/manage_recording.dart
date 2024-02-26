import 'dart:async';
import 'package:flutter/material.dart';

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

  MobileFrame({required this.child});

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
        boxShadow: [],
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
  bool isRecording = false;
  bool isPaused = false;
  int secondsElapsed = 0;

  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Timer at the top
          SizedBox(height: 0),
          Text(
            _formatDuration(Duration(seconds: secondsElapsed)),
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 350.0),
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
              SizedBox(width: 20.0),
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
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
