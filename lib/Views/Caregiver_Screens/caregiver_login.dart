import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:minder/Views/Caregiver_Screens/caregiver_patient_account_creation.dart';
import 'package:minder/Views/Caregiver_Screens/caregiver_signup.dart';
import 'package:minder/Views/Caregiver_Screens/password_reset.dart'; // Ensure this is the correct path to your PasswordResetPage

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  String _loginError = '';

  void _login() async {
  String username = _usernameController.text.trim();
  String password = _passwordController.text.trim();

  try {
    // First, check if there's already a user signed in
    AuthSession session = await Amplify.Auth.fetchAuthSession();
    if (session.isSignedIn) {
      // Optionally, sign out the current user before signing in another user
      await Amplify.Auth.signOut();
    }
    
    // Attempt to sign in with the provided credentials
    final result = await Amplify.Auth.signIn(username: username, password: password);

    if (result.isSignedIn) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => CaregiverSignup()));
    } else {
      setState(() {
        _loginError = 'Login not complete, additional steps required.';
      });
    }
  } on AuthException catch (e) {
    String errorMessage;
    if (e is UserNotConfirmedException) {
      errorMessage = 'User not confirmed. Please check your email for confirmation code.';
    } else if (e is NotAuthorizedException) {
      errorMessage = 'Incorrect username or password.';
    } else {
      errorMessage = 'An error occurred during login: ${e.message}';
    }

    setState(() {
      _loginError = errorMessage;
    });
  }
}


  void _forgotPassword() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordResetPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 250.0,
                width: 250.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('asset/images/caregiver_login.jpg'), // Ensure this asset path is correct
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _textFieldContainer(
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
              SizedBox(height: 16),
              _textFieldContainer(
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
              SizedBox(height: 8),
              if (_loginError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(_loginError, style: TextStyle(color: Colors.red, fontSize: 16)),
                ),
              _loginButton(),
              SizedBox(height: 16),
              _rememberMeAndForgotPassword(),
              SizedBox(height: 16),
              _createAccountText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: child,
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: _login,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        disabledBackgroundColor: Colors.white,
      ),
      child: Text('Login'),
    );
  }

  Widget _rememberMeAndForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (bool? value) {
                setState(() {
                  _rememberMe = value ?? false;
                });
              },
            ),
            Text('Remember me'),
          ],
        ),
        TextButton(
          onPressed: _forgotPassword,
          child: Text('Forgot Password?'),
        ),
      ],
    );
  }

  Widget _createAccountText() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
      },
      child: Text(
        'Don\'t have an account? Sign Up',
        style: TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

mixin NotAuthorizedException {
}
