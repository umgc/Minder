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
          CaregiverSettingScreen(),
        ]),
      ),
    );
  }
}

class CaregiverSettingScreen extends StatelessWidget {
  const CaregiverSettingScreen({super.key});

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
                 'Settings',
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
                  width: 250,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 250,
                  height: 56,
                  child: 
                  
                  ElevatedButton(
                    onPressed: () {
                      // Handle Agree button press
                      print('Profile button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 234, 237, 240), // Change color as needed
                    ),
                    child: const Text(
                      'Profile Information',
                      
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        
                      ),
                    ),
                  ),
                  
                ),
                const SizedBox(height: 20),
                Container(
                  width: 250,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Agree button press
                      print('Guided TOur button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 241, 243, 245), // Change color as needed
                    ),
                
                    child: const Text(
                      'Guided Tour',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 250,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Agree button press
                      print('Support Center button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 241, 243, 245), // Change color as needed
                    ),
                
                    child: const Text(
                      'Support Center',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
               Container(
                  width: 0,
                  height: 300,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                Container(
                  
                  
                  width: 250,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Disagree button press
                      print('Sign Out button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      primary:  Color.fromARGB(255, 100, 139, 179),// Change color as needed
                    ),
                    child: const Text(
                      'Sign Out',
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



 
   