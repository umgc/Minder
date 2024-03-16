import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:minder/Views/patient_Screens/patient_signup.dart';

class PatientRegistrationScreen extends StatefulWidget {
  @override
  _PatientRegistrationScreenState createState() => _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool _isLoading = false; // To control loading state UI

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/patient_data.txt');
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

  Future<void> _createPatientRecord() async {
    final patientData = {
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
    };

    String dataToWrite = patientData.toString();

    try {
      await _writeDataToFile(dataToWrite);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Patient record created successfully.')));
      // Navigate to the other screen after successful record creation
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const patient_signup()), // Replace NextScreen with the actual screen you want to navigate to
      );
      // Optionally, navigate to another page or reset form
      _firstNameController.clear();
      _lastNameController.clear();
    } catch (e) {
      print("Failed to create patient record: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create patient record.')));
    } finally {
      setState(() {
        _isLoading = false; // Reset loading state
      });
    }
  }

  void _registerPatient() async {
    setState(() {
      _isLoading = true; // Set loading state
    });

    await _createPatientRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register a Patient'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: "Patient's First Name"),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: "Patient's Last Name"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _registerPatient,
              child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Register Patient'),
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
