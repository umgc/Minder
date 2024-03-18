import 'package:flutter/material.dart';

import 'package:minder/Views/patient_Screens/voice_recognition_setup.dart';

void main() {
  runApp(const ReminderApp());
}

class ReminderApp extends StatelessWidget {
  const ReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(
          children: const [
            PatientSignupCompleted(),
          ],
        ),
      ),
    );
  }
}

class PatientSignupCompleted extends StatelessWidget {
  const PatientSignupCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 375,
        height: 667,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 16,
              bottom: 20,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  // Navigate to the desired screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  VoiceRecognitionSetupScreen()),
                  );
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2F667F),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x00000014),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: Colors.white,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              top: 496.5, // Keep the vertical position as it is
              child: Center(
                // Center the text horizontally
                child: Column(
                  children: [
                    Text(
                      'Face ID is now',
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        fontSize: 24,
                        color: Color(0xFF030303),
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    Text(
                      'Set Up.',
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        fontSize: 24,
                        color: Color(0xFF030303),
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 178,
              child: 
              Container(
                width: 329,
                height: 312,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x00000014),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://assets.api.uizard.io/api/cdn/stream/1fff051a-5cd3-4e5f-b941-dc2e1991da48.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
