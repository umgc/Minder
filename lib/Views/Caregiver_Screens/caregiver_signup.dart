import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:minder/Views/Caregiver_Screens/caregiver_login.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationCodeController = TextEditingController();

  void signUp() async {
    try {
      final result = await Amplify.Auth.signUp(
        username: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        options: SignUpOptions(
          userAttributes: {
            CognitoUserAttributeKey.email: _emailController.text.trim(),
            CognitoUserAttributeKey.name: _fullNameController.text.trim(),
          },
        ),
      );

      if (result.isSignUpComplete) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up successful! Check your email for a confirmation code.')));
        _showConfirmationCodeDialog();
      } else {
        print('Sign up not complete, additional steps required.');
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  void confirmSignUp() async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: _emailController.text.trim(),
        confirmationCode: _confirmationCodeController.text.trim(),
      );

      if (result.isSignUpComplete) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email confirmed, please log in.')));
        // Assuming you have a named route for your login page, replace 'loginPageRouteName' with your actual route name
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        print('Email confirmation not complete, additional steps required.');
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  void _showConfirmationCodeDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Sign Up'),
          content: TextField(
            controller: _confirmationCodeController,
            decoration: InputDecoration(hintText: 'Confirmation Code'),
          ),
          actions: [
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                confirmSignUp();
              },
            ),
          ],
        );
      },
    );
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
                foregroundColor: Colors.white, backgroundColor: const Color.fromRGBO(47, 102, 127, 1) // Text color
                //padding: const EdgeInsets.symmetric(vertical: 15),
                //textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
