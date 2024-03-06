import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:minder/Caregiver_Login/caregiver_login.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signUp() async {
    try {
      final result = await Amplify.Auth.signUp(
        username: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        options: CognitoSignUpOptions(
          userAttributes: {
            CognitoUserAttributeKey.email: _emailController.text.trim(),
            CognitoUserAttributeKey.name: _fullNameController.text.trim(),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  color: Colors.blue,
                  child: Image.asset(
                    '../asset/images/caregiversignup.png', // image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 7),
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            buildInputWithIcon(_fullNameController, 'Enter your full name',
                'Full Name', Icons.person),
            buildInputWithIcon(_relationshipController,
                'Enter your Relationship', 'Relationship', Icons.person),
            buildInputWithIcon(
                _emailController, 'Enter your e-mail', 'Email', Icons.email),
            buildInputWithIcon(_usernameController, 'Create a username',
                'Username', Icons.person),
            buildPasswordInputWithIcon(_passwordController, 'Create a password',
                'Password', Icons.lock),
            SizedBox(height: 8),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ElevatedButton(
                onPressed: signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(47, 102, 127, 1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildInputWithIcon(TextEditingController controller, String labelText,
      String hinttext, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            labelText,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border:
                  Border.all(color: const Color.fromARGB(255, 199, 199, 199)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hinttext,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    icon,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPasswordInputWithIcon(TextEditingController controller,
      String labelText, String hinttext, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            labelText,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border:
                  Border.all(color: const Color.fromARGB(255, 199, 199, 199)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: controller,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hinttext,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    icon,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
