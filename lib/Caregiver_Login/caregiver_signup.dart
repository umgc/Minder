import 'package:flutter/material.dart';
import 'package:minder/Caregiver_Login/caregiver_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatelessWidget {
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
      body: Column(
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
          buildInputWithIcon('Enter your full name', 'Full Name',Icons.person),
          buildInputWithIcon('Enter your Relationship', 'Relationship',Icons.person),
          buildInputWithIcon('Enter your e-mail', '' ,Icons.email),
          buildInputWithIcon('Create a username', 'username',Icons.person),
          buildPasswordInputWithIcon('Create a password', '',Icons.lock),
          SizedBox(height: 8),
          Spacer(),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child:
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
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
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildInputWithIcon(String labelText, String hinttext, IconData icon) {
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
              border: Border.all(color: const Color.fromARGB(255, 199, 199, 199)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hinttext,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Icon(icon,  size: 18, color: Colors.grey,),
                    Text(" "),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget buildPasswordInputWithIcon(String labelText, String hinttext, IconData icon) {
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
              border: Border.all(color: const Color.fromARGB(255, 199, 199, 199)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
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
                  child: Row(children: [
                    Icon(icon,  size: 18, color: Colors.grey,),
                    Text(" "),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
