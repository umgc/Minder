import 'package:flutter/material.dart';
import 'package:minder/conversation_notfound.dart';
import 'package:minder/patient_login.dart';
import 'package:minder/patient_signup.dart';
import 'package:minder/patient_signupcompleted.dart';
import 'Caregiver_Conversation/conversationDetailsScreen.dart';
import 'Caregiver_Login/caregiverlogin.dart';
import 'Caregiver_Login/caregiversignup.dart';
import 'Welcome_screen/welcome.dart';

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
      home: conversation_notfound(),
      routes: {
        //  '/Settings' : (context) => FigmaToCodeApp(),
        '/Login': (context) => LoginPage(), // Add this line
        '/welcome': (context) => SplashScreen(), // Add this line
        '/conversationDetailsScreen': (context) => conversation_notfound(),
        '/conversationListScreen': (context) => conversation_notfound(),
        '/caregiversignup': (context) => caregiversignup(),
      },
    );
  }
}
