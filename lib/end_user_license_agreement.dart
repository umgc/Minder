import 'package:flutter/material.dart';
 

void main() {
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
        body: ListView(children: const [
          CaregiverEulaScreen(),
        ]),
      ),
    );
  }
}

class CaregiverEulaScreen extends StatelessWidget {
  const CaregiverEulaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap on the screen (optional).
      },
      child: Column(
        children: [
          Container(
            width: 375,
            height: 667,
            color: Colors.white, // Set the background color to white
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Minder',
                  style: TextStyle(
                    color: Color(0xFF030303),
                    fontSize: 38,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 327,
                  height: 321,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'By using the Short-Term Memory',
                        style: TextStyle(
                          color: Color(0xFF030303),
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'Support App, you are granted a',
                        style: TextStyle(
                          color: Color(0xFF030303),
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'personal use license for a single',
                        style: TextStyle(
                          color: Color(0xFF030303),
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'device. The app is designed to',
                        style: TextStyle(
                          color: Color(0xFF030303),
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'provide support for individuals',
                        style: TextStyle(
                          color: Color(0xFF030303),
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'with short-term memory',
                        style: TextStyle(
                          color: Color(0xFF030303),
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'challenges through video analysis.',
                        style: TextStyle(
                          color: Color(0xFF030303),
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'Your responsibilities include',
                        style: TextStyle(
                          color: Color(0xFF030303),
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'refraining from modifications,',
                        style: TextStyle(
                          color: Color(0xFF030303),
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'distribution, and maintaining the',
                        style: TextStyle(
                          color: Color(0xFF030303),
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'confidentiality. By using the app,',
                        style: TextStyle(
                          color: Color(0xFF030303),
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'you agree to the recording and',
                        style: TextStyle(
                          color: Color(0xFF030303),
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'analysis of video content as',
                        style: TextStyle(
                          color: Color(0xFF030303),
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'outlined in the privacy policy.',
                        style: TextStyle(
                          color: Color(0xFF030303),
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 335,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Agree button press
                      print('Agree button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 152, 199, 238), // Change color as needed
                    ),
                    child: const Text(
                      'Agree',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 335,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Disagree button press
                      print('Disagree button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  const Color.fromARGB(255, 24, 65, 99),// Change color as needed
                    ),
                    child: const Text(
                      'Disagree',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
