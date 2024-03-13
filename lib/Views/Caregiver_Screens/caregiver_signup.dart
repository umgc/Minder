import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:minder/Views/Caregiver_Screens/caregiver_patient_account_creation.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationCodeController = TextEditingController();

  Future<void> signUp() async {
    try {
      final result = await Amplify.Auth.signUp(
        username: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        options: CognitoSignUpOptions(
          userAttributes: {
            CognitoUserAttributeKey.email: _emailController.text.trim(),
            CognitoUserAttributeKey.name: _fullNameController.text.trim(),
          },
        ),
      );

      if (result.isSignUpComplete) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up successful!')));
        // Navigate to the home screen after successful sign-up
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PatientRegistrationScreen()), // Replace HomeScreen() with your actual home screen widget
        );
      } else {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Enter Confirmation Code'),
            content: TextField(
              controller: _confirmationCodeController,
              decoration: InputDecoration(labelText: 'Confirmation Code'),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await confirmSignUp(_confirmationCodeController.text.trim());
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('Confirm'),
              ),
            ],
          ),
        );
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Future<void> confirmSignUp(String confirmationCode) async {
    try {
      await Amplify.Auth.confirmSignUp(
        username: _emailController.text.trim(),
        confirmationCode: confirmationCode,
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up confirmed!')));
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: signUp,
              child: Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromRGBO(47, 102, 127, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
