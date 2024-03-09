import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _emailController = TextEditingController();
  String _resetError = '';
  bool _isResetInitiated = false;

  Future<void> _resetPassword() async {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _resetError = 'Please enter your email address';
      });
      return;
    }

    try {
      await Amplify.Auth.resetPassword(username: email);
      setState(() {
        _isResetInitiated = true;
        _resetError = '';
      });
    } on AuthException catch (e) {
      setState(() {
        _resetError = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Reset'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (!_isResetInitiated) ...[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetPassword,
                child: Text('Reset Password'),
              ),
              if (_resetError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    _resetError,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
            ] else ...[
              Text(
                'A password reset link has been sent to your email. Please check your inbox and follow the instructions to reset your password.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Back to Login'),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
