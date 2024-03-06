import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import '../patient_signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CaregiverSignup(),
    );
  }
}

class CaregiverSignup extends StatefulWidget {
  @override
  _CaregiverSignupState createState() => _CaregiverSignupState();
}

class _CaregiverSignupState extends State<CaregiverSignup> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  Future<void> signUp() async {
    try {
      final result = await Amplify.Auth.signUp(
        username: _firstNameController.text.trim() +
            _lastNameController.text.trim(), // Adjust as needed
        password:
            'your_default_password', // Use a default password or generate one
        options: CognitoSignUpOptions(
          userAttributes: {
            CognitoUserAttributeKey.name: _firstNameController.text.trim() +
                ' ' +
                _lastNameController.text.trim(),
            // Add other attributes as needed
          },
        ),
      );

      if (result.isSignUpComplete) {
        print('Sign up successful!');
        // Navigate to the next screen or show a success message
      } else {
        print('Sign up not complete, additional steps required.');
        // Handle additional steps if necessary
      }
    } catch (e) {
      print('Sign up failed: $e');
      // Show an error message or handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Create an Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Sign up for Patient account',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),
            buildFormField('Patient\'s First Name *', _firstNameController),
            buildFormField('Patient\'s Last Name *', _lastNameController),
            Spacer(),
            ElevatedButton(
              onPressed: signUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(47, 102, 127, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildFormField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
