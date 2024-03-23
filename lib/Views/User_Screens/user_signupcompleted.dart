import 'package:flutter/material.dart';
import 'package:minder/Views/Caregiver_Screens/care_giver_setting.dart';

void main() {
  runApp(const ReminderApp());
}

class ReminderApp extends StatelessWidget {
  const ReminderApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: Center(
          child: UserSignupCompleted(),
        ),
      ),
    );
  }
}

class UserSignupCompleted extends StatelessWidget {
  const UserSignupCompleted({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white, // Changed to white background color
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sign Up Completed!',
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 24,
              color: const Color(0xFF030303),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 60),
          Text(
            'You can now enhance your app experience by setting the support features!',
            
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 14,
              color: const Color(0xFF030303),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage('asset/images/signupcomplete.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          GestureDetector(
            onTap: () {
              // Navigate to the settings page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
            child: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                color: const Color(0xFF2F667F),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Continue to Settings',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
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
