import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:minder/Models/amplify_models/ModelProvider.dart'; // Adjust this import to your generated models location

class PatientRegistrationScreen extends StatefulWidget {
  @override
  _PatientRegistrationScreenState createState() => _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool _isLoading = false; // To control loading state UI

  Future<String?> _getCurrentUserId() async {
    try {
      AuthUser authUser = await Amplify.Auth.getCurrentUser();
      return authUser.userId;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  Future<void> _createPatientRecord(String caregiverId) async {
    final patient = Patient(
      patientsFirstName: _firstNameController.text.trim(),
      patientsLastName: _lastNameController.text.trim(),
      caregiverId: caregiverId,
    );

    try {
      await Amplify.DataStore.save(patient);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Patient record created successfully.')));
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

    String? caregiverId = await _getCurrentUserId();
    if (caregiverId != null) {
      await _createPatientRecord(caregiverId);
    } else {
      print("Failed to obtain caregiver ID");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to obtain caregiver ID.')));
      setState(() {
        _isLoading = false; // Reset loading state
      });
    }
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
                foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
