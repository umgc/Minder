//Contributors 
  // UI and Functionality Developed by Elsa Bushen
  

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:minder/Views/User_Screens/user_signup.dart';

class UserRegistrationScreen extends StatefulWidget {
  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool _isLoading = false; 

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/user_data.txt');
  }

  Future<void> _writeDataToFile(String data) async {
    final file = await _localFile;
    await file.writeAsString(data);
  }

  Future<String> _readDataFromFile() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      print("Error reading file: $e");
      return '';
    }
  }

  Future<void> _createUserRecord() async {
    final patientData = {
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
    };

    String dataToWrite = patientData.toString();

    try {
      await _writeDataToFile(dataToWrite);
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SetupFaceIDScreen()),
      );
      _firstNameController.clear();
      _lastNameController.clear();
    } catch (e) {
      print("Failed to create user record: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create user record.')));
    } finally {
      setState(() {
        _isLoading = false; // Reset loading state
      });
    }
  }

  void _registerUser() async {
    setState(() {
      _isLoading = true; // Set loading state
    });

    await _createUserRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register the User'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: "User's First Name"),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: "User's Last Name"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _registerUser,
              child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Register User'),
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
