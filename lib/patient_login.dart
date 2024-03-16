import 'package:flutter/material.dart';
import 'package:minder/Caregiver_Conversation/patient_conversation_list.dart';

void main() {
  runApp(const ReminderApp());
}

class ReminderApp extends StatelessWidget {
  const ReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor:
            Colors.white, // Changed background color to white
      ),
      home: Scaffold(
        body: ListView(
          children: const [
            patient_login(),
          ],
        ),
      ),
    );
  }
}

class patient_login extends StatelessWidget {
  const patient_login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: SizedBox(
          width: 375,
          height: 667,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
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
              Positioned(
                left: 22,
                bottom: 83,
                child: GestureDetector(
  onTap: () {
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  const ConversationListScreen()),
              );
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
                      'Log in',
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
              const Positioned(
                left: 90,
                top: 200,
                child: Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 24,
                    color: Color(0xFF030303),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Positioned(
                left: 70,
                top: 230,
                child: Text(
                  'We\'re glad to see you again',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: Color(0xFF030303),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 512,
                child: Container(
                  width: 105,
                  height: 1,
                  color: const Color(0xFFd3d3d3),
                ),
              ),
              Positioned(
                left: 258,
                top: 512,
                child: Container(
                  width: 105,
                  height: 1,
                  color: const Color(0xFFd3d3d3),
                ),
              ),
              Positioned(
                left: 49,
                top: 286,
                child: Container(
                  width: 277,
                  height: 241,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://assets.api.uizard.io/api/cdn/stream/73b2653b-6556-474d-a368-12e16d8d2546.png'),
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
              Positioned(
                left: 279,
                top: 482,
                child: Container(
                  width: 42,
                  height: 39,
                  decoration: BoxDecoration(
                    color: const Color(0xFF14dc34),
                    borderRadius: BorderRadius.circular(19.5),
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
            ],
          ),
        ),
      ),
    );
  }
}
