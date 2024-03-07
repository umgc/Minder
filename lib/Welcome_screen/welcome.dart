import 'package:flutter/material.dart';
import 'package:minder/end_user_license_agreement_patient.dart';

import '../Caregiver_Login/caregiver_login.dart';
import '../end_user_license_agreement.dart';

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
                'Memory Support',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  
                ),
                textAlign: TextAlign.center, 
              ),

              // Subtitle
              Text(
                'A place to record and organize conversations with doctors and reminders',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center, // Center the text
              ),

              // Space
              SizedBox(height: 20.0),

              // Caregiver Sign-In Button
              ElevatedButton(
                onPressed: () {
                   Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CaregiverEulaScreen()),
              );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: EdgeInsets.all(10.0),
                  textStyle: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('Caregiver Sign-In'),
              ),

              // Space
              SizedBox(height: 20.0),

              // Patient Sign-In Button
              ElevatedButton(
                onPressed: () {
                  // Handle Patient Sign-In button press
                  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CaregiverEulaScreen()),
              );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: EdgeInsets.all(10.0),
                  textStyle: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('Patient Sign-In'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
