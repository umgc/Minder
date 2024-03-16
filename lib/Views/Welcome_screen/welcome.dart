import 'package:flutter/material.dart';
import 'package:minder/Views/patient_Screens/patient_login.dart';
import '../Caregiver_Screens/caregiver_login.dart';
import 'package:minder/Views/patient_Screens/patient_signup.dart';

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
            'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png', // Replace with your image URL
            fit: BoxFit.cover,
          ),

          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Memory Support Text
              Text(
                'Minder',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  
                ),
                textAlign: TextAlign.center, 
              ),

              // Subtitle
              Text(
                'A place to record and organize conversations with doctors and reminders',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center, // Center the text
              ),

              // Space
              SizedBox(height: 15.0),

      // Caregiver Sign-In Button
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // This remains unchanged
    );
  },
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Adjusted padding for a larger button
    textStyle: TextStyle(
      fontSize: 18.0, // Increased font size for better readability
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Color.fromRGBO(157, 220, 250, 1), // Custom background color
  ),
  child: Text('Caregiver'),
),

// Space
SizedBox(height: 15.0), // Adjust spacing as needed

// Patient Sign-In Button
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => patient_login()), // This remains unchanged
    );
  },
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Adjusted padding for a larger button
    textStyle: TextStyle(
      fontSize: 18.0, // Increased font size for better readability
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Color.fromRGBO(157, 220, 250, 1), // Custom background color
  ),
  child: Text('Patient'),
),

            ],
          ),
        ],
      ),
    );
  }
}
