import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
// Additional imports for your app's screens and models
import 'package:minder/Models/Patient_Conversations/patient_conversation_list.dart';
import 'package:minder/Views/Caregiver_Screens/caregiver_signup.dart';
import 'package:minder/Models/Reminder/caregiver_reminder_creation.dart';
import 'package:minder/Views/patient_Screens/patient_signup.dart';
import 'Models/Patient_Conversations/patient_conversation_details.dart';
import 'package:minder/Views/Caregiver_Screens/caregiver_login.dart';
import 'package:minder/Views/Welcome_screen/welcome.dart';
import 'package:minder/Views/Caregiver_Screens/end_user_license_agreement.dart';
import 'Models/Reminder/reminder_creation_screen.dart.dart';
import 'package:minder/Config/amplifyconfigutation.dart';
// Import the VoiceService
import 'package:minder/Services/voice_assistance_service.dart'; // Adjust this path to where your VoiceService is located

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure Amplify
  await _configureAmplify();

  // Initialize VoiceService
  bool isVoiceServiceAvailable = await VoiceService().initializeService();
  if (!isVoiceServiceAvailable) {
    print("Voice service is not available.");
  }

  runApp(const MyApp());
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
  const MyApp({super.key});

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
        '/conversationDetailsScreen': (context) => conversationDetailsScreen(),
        '/conversationListScreen': (context) => ConversationListScreen(),
        '/caregiversignup': (context) => SignUpScreen(),
        '/ReminderFormScreen': (context) => ReminderFormScreen(),
        '/reminder_creation_screen': (context) => CaregiverReminderCreationScreen(),
        '/caregiver_signup': (context) => SignUpScreen(),
        '/eula': (context) => const CaregiverEulaScreen(),
        '/faceidsignup': (context) => const patient_signup(),
      },
    );
  }
}
