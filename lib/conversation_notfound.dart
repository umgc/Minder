import 'package:flutter/material.dart';

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
          conversation_notfound(),
        ]),
      ),
    );
  }
}

class conversation_notfound extends StatelessWidget {
  const conversation_notfound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              width: 375,
              height: 64,
              color: Colors.white,
              child: const Center(
                child: Text(
                  'Minder',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: Color(0xFF030303),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            top: 160.5,
            left: 13,
            child: Text(
              'Conversations',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                color: Color(0xFF030303),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            top: 161,
            left: 270,
            child: Text(
              'View all',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                color: Color(0xFF030303),
              ),
            ),
          ),
          Positioned(
            top: 82.5,
            left: 24.5,
            child: Container(
              width: 326,
              height: 39,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(19.5),
                border: Border.all(
                  color: const Color(0xFFdbdbdb),
                  width: 1,
                ),
              ),
              child: const Center(
                child: Text(
                  'Meeting with Professor',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    color: Color(0xFF272727),
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            top: 292.5,
            left: 67,
            child: Text(
              'No Conversations Found',
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 605,
            left: 24,
            child: Container(
              width: 335,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF2F667F),
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A030303),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Record',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
