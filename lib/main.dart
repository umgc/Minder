import 'package:flutter/material.dart';
 
import 'package:minder/conversation_notfound.dart';
import 'package:minder/patient_login.dart';
import 'package:minder/patient_signup.dart';
import 'package:minder/patient_signupcompleted.dart';
import 'Caregiver_Conversation/conversationDetailsScreen.dart';
import 'Caregiver_Login/caregiverlogin.dart';
import 'Caregiver_Login/caregiversignup.dart';
import 'Welcome_screen/welcome.dart';
import 'reminder_creation_screen.dart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minder App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: SignUpScreen(),
      routes: {
        //  '/Settings' : (context) => FigmaToCodeApp(),
        '/Login': (context) => LoginPage(), // Add this line
        '/welcome': (context) => SplashScreen(), // Add this line
         '/conversationDetailsScreen': (context) => conversationDetailsScreen(),
          '/conversationListScreen': (context) => ConversationListScreen(),
          '/caregiversignup': (context) => caregiversignup(),
          '/ReminderFormScreen': (context) => ReminderFormScreen(),
          '/reminder_creation_screen' : (context) => CaregiverReminderCreationScreen(),
          '/caregiver_signup' : (context) => SignUpScreen(),

      },
    );
  }
}
