import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:camera/camera.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure widgets are initialized
  GoogleMlKit.vision; // Initialize Google ML Kit Vision
  runApp(const ReminderApp());
}

class ReminderApp extends StatelessWidget {
  const ReminderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: PatientSignup(),
      ),
    );
  }
}

class PatientSignup extends StatefulWidget {
  const PatientSignup({Key? key}) : super(key: key);

  @override
  _PatientSignupState createState() => _PatientSignupState();
}

class _PatientSignupState extends State<PatientSignup> {
  bool isFaceDetected = false;
  final FaceDetector faceDetector = GoogleMlKit.vision.faceDetector();
  late CameraController _cameraController;
  late Future<void> _initializeCameraControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCameraController();
  }

  Future<void> _initializeCameraController() async {
    try {
      final cameras = await availableCameras();
      _cameraController = CameraController(
        cameras[0],
        ResolutionPreset.medium,
      );
      _initializeCameraControllerFuture = _cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } catch (e) {
      print('Error initializing camera controller: $e');
      // Handle the error or provide user feedback as needed.
    }
  }

  Future<void> _onCapturePressed() async {
    try {
      await _initializeCameraControllerFuture;
      final XFile file = await _cameraController.takePicture();
      final InputImage inputImage = InputImage.fromFilePath(file.path);
      await detectFace(inputImage);
    } catch (e) {
      print('Error during capture: $e');
    }
  }

  Future<void> detectFace(InputImage inputImage) async {
    try {
      final List<Face> faces = await faceDetector.processImage(inputImage);

      if (faces.isNotEmpty) {
        setState(() {
          isFaceDetected = true;
        });
      } else {
        setState(() {
          isFaceDetected = false;
        });
      }
    } catch (e) {
      print('Error during face detection: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 375,
        height: 667,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First image
            Container(
              width: 375,
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://assets.api.uizard.io/api/cdn/stream/40264403-5d53-44bd-8dcf-5ad147ce1b6e.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Welcome text
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to Minder!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 24,
                  color: Color(0xFF030303),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Add Face Recognition Widget
            Container(
              width: 200,
              height: 200,
              child: FaceRecognitionWidget(
                onFaceDetected: detectFace,
              ),
            ),

            // "Move your head..." text
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Move your head slowly to complete the circle',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  color: Color(0xFF030303),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),

            // Capture button
            ElevatedButton(
              onPressed: _onCapturePressed,
              child: Text('Capture'),
            ),

            // "Set up your Face ID" button
            Container(
              width: 338,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFaad3ff),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Set up your Face ID',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    faceDetector.close();
    _cameraController.dispose();
    super.dispose();
  }
}

class FaceRecognitionWidget extends StatelessWidget {
  final Function(InputImage) onFaceDetected;

  const FaceRecognitionWidget({
    Key? key,
    required this.onFaceDetected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CameraView(),
        // Add face detection overlay UI elements here (e.g., graphics, feedback).
      ],
    );
  }
}

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _cameraController;
  late Future<void> _initializeCameraControllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      // Initialize the camera controller (you need to configure this)
      // For example, use CameraController.from...
      // See the camera package documentation for more details.
      // https://pub.dev/packages/camera
      CameraDescription(
        name: "0",
        lensDirection: CameraLensDirection.front,
        sensorOrientation: 0,
      ),
      ResolutionPreset.medium,
    );
    _initializeCameraControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeCameraControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(_cameraController);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
