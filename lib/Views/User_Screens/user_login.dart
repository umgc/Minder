import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:minder/Models/User_Conversations/user_conversation_list.dart';

void main() => runApp(const ReminderApp());

class ReminderApp extends StatelessWidget {
  const ReminderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true, // Enable Material 3 features
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        primaryColor: const Color(0xFFaad3ff),
        textTheme: TextTheme(
          headlineMedium: const TextStyle(
            fontFamily: 'Source Sans Pro',
            fontSize: 24,
            color: Color(0xFF030303),
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16,
            color: Color(0xFF030303),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFaad3ff),
        ),
      ),
      home: const user_signin(),
    );
  }
}

class user_signin extends StatefulWidget {
  const user_signin({Key? key}) : super(key: key);

  @override
  State<user_signin> createState() => _user_signinState();
}

class _user_signinState extends State<user_signin> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your face to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print(e.toString());
    }

    if (!mounted) return;

    if (authenticated) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  ConversationListScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                child: Image.network(
                  'https://assets.api.uizard.io/api/cdn/stream/40264403-5d53-44bd-8dcf-5ad147ce1b6e.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  height: 140,
                ),
              ),
              
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const SizedBox(height: 16),
    Text(
      'Welcome Back!',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 28, // Increased font size for a more impactful appearance
            fontWeight: FontWeight.bold, // Make text bold for emphasis
            color: Color(0xFF030303), // Custom color, can adjust as needed
          ),
    ),
    const SizedBox(height: 8), // Adjusted spacing between the texts
    Text(
      'Authenticate to continue',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 20, // Slightly smaller than the welcome text for hierarchy
            fontWeight: FontWeight.bold, // Also make this text bold for emphasis
            color: Color(0xFF030303), // Consistent color for clear readability
          ),
    ),
    const SizedBox(height: 40), // Space before the button
    ElevatedButton(
      onPressed: _authenticateWithBiometrics,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2F667F),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Button padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners for the button
        ),
      ),
      child: const Text(
        'Authenticate',
        style: TextStyle(
          fontFamily: 'Montserrat', // Font family for consistency
          fontSize: 14, // Font size for the button text
          color: Color.fromARGB(255, 243, 242, 242), // Color for the button text
          fontWeight: FontWeight.bold, // Bold button text for emphasis
        ),
      ),
    ),
  ],
)



            ],
          ),
        ),
      ),
    );
  }
}
