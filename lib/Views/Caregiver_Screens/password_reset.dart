import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _emailController = TextEditingController();
  final _confirmationCodeController = TextEditingController();
  final _newPasswordController = TextEditingController();
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

  Future<void> _confirmResetPassword() async {
    String confirmationCode = _confirmationCodeController.text.trim();
    String newPassword = _newPasswordController.text.trim();

    if (confirmationCode.isEmpty || newPassword.isEmpty) {
      setState(() {
        _resetError = 'Please fill all fields';
      });
      return;
    }

    try {
      await Amplify.Auth.confirmResetPassword(
        username: _emailController.text.trim(),
        newPassword: newPassword,
        confirmationCode: confirmationCode,
      );
      // Navigate back to login page on success
      Navigator.pop(context); 
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
            ] else ...[
              Text(
                'Enter the confirmation code sent to your email and your new password.',
                textAlign: TextAlign.center,
              ),
              TextField(
                controller: _confirmationCodeController,
                decoration: InputDecoration(
                  labelText: 'Confirmation Code',
                  hintText: 'Enter the confirmation code',
                ),
              ),
              TextField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Enter your new password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _confirmResetPassword,
                child: Text('Confirm New Password'),
              ),
            ],
            if (_resetError.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _resetError,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
