import 'package:flutter/material.dart';

import 'Caregiver_Conversation/conversationDetailsScreen.dart';
import 'Caregiver_Conversation/conversationListScreen.dart';
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
      home: ConversationListScreen(),
      routes: {
      //  '/Settings' : (context) => FigmaToCodeApp(),
         '/Login': (context) => LoginPage(), // Add this line
        '/welcome': (context) => SplashScreen(), // Add this line
         '/conversationDetailsScreen': (context) => conversationDetailsScreen(),
          '/conversationListScreen': (context) => ConversationListScreen(),
          '/caregiversignup': (context) => caregiversignup(),
      },
    );
  }
}
