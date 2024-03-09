import 'package:flutter/material.dart';

import 'patient_signupcompleted.dart';

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
        body: ListView(children: const [
          patient_signup(),
        ]),
      ),
    );
  }
}

class patient_signup extends StatelessWidget {
  const patient_signup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 375,
            height: 667,
            child: Stack(
              children: [
                // First image
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 387,
                    height: 180,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://assets.api.uizard.io/api/cdn/stream/40264403-5d53-44bd-8dcf-5ad147ce1b6e.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // Welcome text
                const Positioned(
                  left: 24, // Align with left edge
                  top: 180, // Positioned below the first image
                  child: SizedBox(
                    width: 375 - 48, // Match the width of the screen
                    child: Text(
                      'Welcome to Minder!',
                      textAlign: TextAlign.center, // Align text to center
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        fontSize: 24,
                        color: Color(0xFF030303),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Second image
                Positioned(
                  left: (375 - 200) / 2, // Center horizontally
                  top: 250, // Positioned below the welcome text
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://assets.api.uizard.io/api/cdn/stream/a855b4aa-8e5c-4ff0-8966-a696cb7818d5.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ),

                // "Move your head..." text
                const Positioned(
                  left: (375 - 200) / 2, // Center horizontally
                  top: 460, // Positioned below the second image
                  child: Padding(
                    padding: EdgeInsets.only(left: 24, top: 16),
                    child: SizedBox(
                      width: 200, // Match the width of the second image
                      child: Text(
                        'Move your head slowly to complete the circle',
                        textAlign: TextAlign.center, // Align text to center
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          color: Color(0xFF030303),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),

                // "Set up your Face ID" button
                Positioned(
                  left: 24,
                  bottom: 24, // Placed at the bottom of the screen
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: GestureDetector(
                      onTap: () {
                        // Handle the tap on the button, e.g., navigate to the Face ID setup screen
                        // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => FaceIDSetupScreen()));
                         Navigator.push(context, MaterialPageRoute(builder: (context) => const PatientSignupCompleted()));
                        print('Set up your Face ID button tapped!');
                      },
                      child: Container(
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
          ),
        ),
      ),
    );
  }
}
