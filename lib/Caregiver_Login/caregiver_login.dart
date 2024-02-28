import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  void _login() {
    
    String username = _usernameController.text;
    String password = _passwordController.text;

    
    if (username == 'admin' && password == 'password') {
      
      print('Login successful!');
    } else {
      
      print('Invalid credentials');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/images/Caregiver_loginimg.png'), 
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 16.0),

           //
            Text(
              'Welcome Back!',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),

    
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            
                SizedBox(
      width: double.infinity, 
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color.fromRGBO( 47, 102, 127,0.5),
        ),
        child: ElevatedButton(
          onPressed: _login,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO( 47, 102, 127,0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.0),
          ),
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
              
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                    ),
                    Text('Remember Me'),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    
                    print('Forgot your password clicked');
                  },
                  child: Text('Forgot your password'),
                ),
              ],
            ),

            SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
