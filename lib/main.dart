import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:minder/Models/Caregiver_Conversation/patient_conversation_list.dart';
import 'package:minder/Views/Caregiver_Screens/caregiver_signup.dart'; 
import 'package:minder/Models/Reminder/caregiver_reminder_creation.dart';
import 'package:minder/Views/patient_Screens/patient_signup.dart';
import 'Models/Caregiver_Conversation/patient_conversation_details.dart';
import 'package:minder/Views/Caregiver_Screens/caregiver_login.dart'; 
import 'package:minder/Views/Welcome_screen/welcome.dart';
import 'package:minder/Views/Caregiver_Screens/end_user_license_agreement.dart';
import 'Models/Reminder/reminder_creation_screen.dart.dart';
import 'package:minder/Config/amplifyconfiguration.dart';


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
  const MyApp({super.key}); // Constructor for MyApp class

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minder App', // The title of the application
      theme: ThemeData(
        primarySwatch: Colors.blue, // Sets the primary color of the app theme
      ),
      home: SplashScreen(), // The initial screen displayed when the app is launched
      routes: {
        '/Login': (context) => LoginPage(), // Navigates to the login page
        '/welcome': (context) => SplashScreen(), // Displays the splash/welcome screen
        '/conversationDetailsScreen': (context) => conversationDetailsScreen(), // Displays details of a specific conversation
        '/conversationListScreen': (context) => ConversationListScreen(), // Lists all conversations
        '/caregiversignup': (context) => SignUpScreen(), // Navigates to the caregiver signup page
        '/ReminderFormScreen': (context) => ReminderFormScreen(), // Displays the form for creating a new reminder
        '/reminder_creation_screen': (context) => CaregiverReminderCreationScreen(), // Screen for caregivers to create reminders
        '/caregiver_signup': (context) => SignUpScreen(), // Caregiver signup screen
        '/eula': (context) => const CaregiverEulaScreen(), // End User License Agreement screen
        '/faceidsignup': (context) => const patient_signup(), // Patient signup screen with face ID
      },
    );
  }
}
