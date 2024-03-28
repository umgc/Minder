import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:minder/Views/Caregiver_Screens/caregiver_user_account_creation.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _confirmationCodeController = TextEditingController();

  Future<void> signUp() async {
    try {
      final result = await Amplify.Auth.signUp(
        username: _emailController.text.trim(), // Use email as the username
        password: _passwordController.text.trim(),
        options: CognitoSignUpOptions(
          userAttributes: {
            CognitoUserAttributeKey.email: _emailController.text.trim(),
            CognitoUserAttributeKey.name: _fullNameController.text.trim(),
            CognitoUserAttributeKey.custom('Relationship'): _relationshipController.text.trim(),
          },
        ),
      );

      // If signUp succeeds, show the confirmation code dialog
      if (result.isSignUpComplete) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up successful. Please check your email for the confirmation code.')));
        _showConfirmationCodeDialog();
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  void _showConfirmationCodeDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Makes dialog modal
      builder: (context) => AlertDialog(
        title: Text('Enter Confirmation Code'),
        content: TextField(
          controller: _confirmationCodeController,
          decoration: InputDecoration(hintText: 'Confirmation Code'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Confirm'),
            onPressed: () async {
              Navigator.of(context).pop(); 
              await confirmSignUp(_confirmationCodeController.text.trim());
            },
          ),
        ],
      ),
    );
  }

  Future<void> confirmSignUp(String confirmationCode) async {
    try {
      await Amplify.Auth.confirmSignUp(
        username: _emailController.text.trim(),
        confirmationCode: confirmationCode,
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up confirmed!')));
      // Navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PatientRegistrationScreen()), // Adjust this as needed
      );
    } on CodeMismatchException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Incorrect confirmation code.")));
      _showConfirmationCodeDialog(); // Show the dialog again for another attempt
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
            Image.asset(
              'asset/images/caregiver_signup.jpg',
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Enter Your Full Name'),
            ),
            TextFormField(
              controller: _relationshipController,
              decoration: InputDecoration(labelText: 'Enter Your Relationship'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Enter Your Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Create a Password'),
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
