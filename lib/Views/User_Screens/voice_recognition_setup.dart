import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:minder/Views/Caregiver_Screens/care_giver_setting.dart';

class VoiceRecognitionSetupScreen extends StatefulWidget {
  @override
  _AudioRecorderScreenState createState() => _AudioRecorderScreenState();
}

class _AudioRecorderScreenState extends State<VoiceRecognitionSetupScreen> {
  final recorder = FlutterSoundRecorder();
  bool isRecording = false;
  bool isRecorderReady = false;
  String _path = '';

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Mic permission not granted';
    }

    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future<void> record() async {
    if (!isRecorderReady) return;

    final directory = await getApplicationDocumentsDirectory();
    _path = '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac';

    await recorder.startRecorder(toFile: _path);
    setState(() {
      isRecording = true;
    });
  }

  Future<void> stop() async {
    await recorder.stopRecorder();
    setState(() {
      isRecording = false;
    });

    // Optionally, confirm the file exists and is not empty before navigating
    final recordedFile = File(_path);
    if (await recordedFile.exists() && await recordedFile.length() > 0) {
      // Navigate to the next screen only if the file is successfully recorded
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Settings()), // Assuming Settings is your target screen
      );
    } else {
      // Handle the error or inform the user
      print("Recording failed or file is empty.");
    }
  }

  @override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
            ),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Image.asset('asset/images/speech-recognition.jpg'), // Ensure your asset path is correct
                    const SizedBox(height: 20),
                    const Text(
                        'Tap on mic icon to start recording',
                        style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    StreamBuilder<RecordingDisposition>(
                        stream: recorder.onProgress,
                        builder: (context, snapshot) {
                            final duration = snapshot.hasData ? snapshot.data!.duration : Duration.zero;
                            return Text('${duration.inSeconds}s', style: const TextStyle(fontSize: 25));
                        },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: isRecording ? stop : record,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: isRecording ? Colors.red : const Color.fromARGB(255, 157, 201, 236), // Adjust colors as needed
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Icon(isRecording ? Icons.stop : Icons.mic),
                        ),
                    ),
                ],
            ),
        ),
    );
}
}