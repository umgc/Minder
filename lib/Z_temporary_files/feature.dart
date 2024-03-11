
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:minder/Config/amplifyconfigutation.dart';
import 'package:minder/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure flutter binding initialization

  // Initialize Amplify plugins
  AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
  
  try {
    Amplify.addPlugins([authPlugin]);
    await Amplify.configure(amplifyconfig);
    print("Successfully configured Amplify 🎉");
  } catch (e) {
    print("Could not configure Amplify: $e");
  }

  runApp(MyApp());
}
