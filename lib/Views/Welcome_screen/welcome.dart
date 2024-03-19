import 'package:flutter/material.dart';
import 'package:minder/Views/User_Screens/user_login.dart';
import '../Caregiver_Screens/caregiver_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.network(
            'https://greaterpublic.org/app/uploads/2024/01/iStock-1801206399.jpg', // Replace with your image URL
            fit: BoxFit.cover,
          ),

          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Memory Support Text
              const Text(
                'Minder',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  
                ),
                textAlign: TextAlign.center, 
              ),

              // Subtitle
              const Text(
                'A place to record and organize conversations with doctors and reminders',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center, // Center the text
              ),

              // Space
              const SizedBox(height: 15.0),

      // Caregiver Sign-In Button
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // This remains unchanged
    );
  },
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Adjusted padding for a larger button
    textStyle: const TextStyle(
      fontSize: 18.0, // Increased font size for better readability
      fontWeight: FontWeight.bold,
       
    ),
    backgroundColor: const Color.fromRGBO(157, 220, 250, 1), // Custom background color
    disabledBackgroundColor: Color.fromRGBO(245, 246, 247, 1),
  ),
  child: const Text('Caregiver'),
),

// Space
const SizedBox(height: 15.0), // Adjust spacing as needed

// Patient Sign-In Button
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const patient_login()), // This remains unchanged
    );
  },
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Adjusted padding for a larger button
    textStyle: const TextStyle(
      fontSize: 18.0, // Increased font size for better readability
      fontWeight: FontWeight.bold,
     
    ),
    backgroundColor: const Color.fromRGBO(157, 220, 250, 1), // Custom background color
    disabledBackgroundColor: Color.fromRGBO(245, 246, 247, 1),
  ),
  child: const Text('User'),
),

            ],
          ),
        ],
      ),
    );
  }
}
