import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:minder/Views/Caregiver_Screens/care_giver_setting.dart';
import 'package:minder/Views/Caregiver_Screens/password_reset.dart';
import 'package:minder/Views/patient_Screens/end_user_license_agreement_patient.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  String _loginError = '';

  @override
  void initState() {
    super.initState();
    _checkSignedInStatus();
  }

  void _checkSignedInStatus() async {
    try {
      AuthSession session = await Amplify.Auth.fetchAuthSession();
      if (session.isSignedIn) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Settings()));
      }
    } catch (e) {
      print("Error checking sign in status: $e");
    }
  }

  void _login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    try {
      final result = await Amplify.Auth.signIn(username: username, password: password);
      if (result.isSignedIn) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Settings()));
      } 
    } on AuthException catch (e) {
      _handleLoginException(e);
    }
  }

  void _handleLoginException(AuthException e) {
    String errorMessage = "Incorrect username or password. Please try again";
    if (e is UserNotConfirmedException) {
      errorMessage = "User not confirmed. Please check your email for a confirmation code.";
    } else if (e.message.contains('NotAuthorizedException')) {
      errorMessage = "Incorrect username or password. Please try again.";
    } 
    setState(() {
      _loginError = errorMessage;
    });
  }

  void _forgotPassword() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordResetPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: SingleChildScrollView( // Allows the content to be scrollable
        padding: const EdgeInsets.all(16.0),
        child: Center( // Added to center the content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 250.0,
                width: 250.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('asset/images/caregiver_login.jpg'),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 20),
              Text('Welcome Back!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  textStyle: TextStyle(color: Colors.white),
                ),
                child: Text('Login'),
              ),
              SizedBox(height: 16),
              Row(
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
                  TextButton(onPressed: _forgotPassword, child: Text('Forgot Password?')),
                ],
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CaregiverEulaScreen1())),
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                ),
              ),
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
}
