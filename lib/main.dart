import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:minder/Caregiver_Conversation/patient_conversation_list.dart';
import 'package:minder/Caregiver_Login/caregiver_patient_account_creation.dart';
import 'package:minder/Reminder/caregiver_reminder_creation.dart';
import 'package:minder/conversation_notfound.dart';
import 'package:minder/patient_login.dart';
import 'package:minder/patient_signup.dart';
import 'package:minder/patient_signupcompleted.dart';
import 'Caregiver_Conversation/patient_conversation_details.dart';
import 'Caregiver_Login/caregiver_login.dart';
import 'Caregiver_Login/caregiver_signup.dart';
import 'Reminder/caregiver_reminder_creation.dart';
import 'Welcome_screen/welcome.dart';
import 'end_user_license_agreement.dart';
import 'reminder_creation_screen.dart.dart';
import 'tour_one.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'amplifyconfiguration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  runApp(MyApp());
}

Future<void> _configureAmplify() async {
  AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
  try {
    await Amplify.addPlugin(authPlugin);
    await Amplify.configure(amplifyconfig);
    print("Successfully configured Amplify 🎉");
  } catch (e) {
    print("Could not configure Amplify: $e");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minder App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        '/Login': (context) => LoginPage(),
        '/welcome': (context) => SplashScreen(),
        '/conversationDetailsScreen': (context) => ConversationDetailsScreen(),
        '/conversationListScreen': (context) => ConversationListScreen(),
        '/caregiversignup': (context) => CaregiverSignup(),
        '/ReminderFormScreen': (context) => ReminderFormScreen(),
        '/reminder_creation_screen': (context) =>
            CaregiverReminderCreationScreen(),
        '/caregiver_signup': (context) => SignUpScreen(),
        '/eula': (context) => CaregiverEulaScreen(),
        '/faceidsignup': (context) => patient_signup(),
        '/tourone': (context) => MyHomePage(),
      },
    );
  }
}
