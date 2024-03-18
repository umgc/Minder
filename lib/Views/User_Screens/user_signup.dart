import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'patient_signupcompleted.dart'; // Ensure this is correctly imported based on your project structure

void main() => runApp(const ReminderApp());

class ReminderApp extends StatelessWidget {
  const ReminderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const patient_signup(),
    );
  }
}

class patient_signup extends StatelessWidget {
  const patient_signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Your previous widgets here
          // "Set up your Face ID" button with modified onTap
          Positioned(
            left: 24,
            bottom: 24,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FaceIDSetupPage())),
                child: Container(
                  width: 338,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFaad3ff),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FaceIDSetupPage extends StatefulWidget {
  const FaceIDSetupPage({Key? key}) : super(key: key);

  @override
  State<FaceIDSetupPage> createState() => _FaceIDSetupPageState();
}

class _FaceIDSetupPageState extends State<FaceIDSetupPage> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your face to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print(e.toString());
    }

    if (!mounted) return;

    if (authenticated) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PatientSignupCompleted()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face ID Setup'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _authenticateWithBiometrics,
          child: const Text('Authenticate'),
        ),
      ),
    );
  }
}
