import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ReminderFormScreen extends StatefulWidget {
  @override
  _ReminderFormScreenState createState() => _ReminderFormScreenState();
}

class _ReminderFormScreenState extends State<ReminderFormScreen> {
  final TextEditingController _typeOfEventController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _discussionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? _imageUrl;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageUrl = image.path;
      });
    }
  }

  Future<void> _createReminder() async {
    final reminder = {
      'typeOfEvent': _typeOfEventController.text,
      'date': _dateController.text,
      'time': _timeController.text,
      'discussion': _discussionController.text,
      'imageUrl': _imageUrl ?? '',
    };

    final url = Uri.parse(
        'https://<your-api-id>.execute-api.us-east-2.amazonaws.com/<stage>/reminders'); // need an API added here JN
    final response = await http.post(
      url,
      body: json.encode(reminder),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Reminder created successfully');
      // Navigate to another screen or show a success message
    } else {
      print('Failed to create reminder');
      // Show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Create a Reminder',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color.fromARGB(255, 247, 247, 247),
                    backgroundImage:
                        _imageUrl != null ? FileImage(File(_imageUrl!)) : null,
                  ),
                  InkWell(
                    onTap: _pickImage,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 183, 213, 230),
                      ),
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Choose a Reminder Name',
              style: TextStyle(
                  fontSize: 12, color: Color.fromRGBO(197, 196, 196, 1)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            CustomTextInput(
              controller: _typeOfEventController,
              placeholder: 'Type of Event',
            ),
            InkWell(
              onTap: _selectDate,
              child: CustomTextInput(
                controller: _dateController,
                placeholder: 'Date',
                enabled: false,
              ),
            ),
            InkWell(
              onTap: _selectTime,
              child: CustomTextInput(
                controller: _timeController,
                placeholder: 'Time',
                enabled: false,
              ),
            ),
            CustomTextInput(
              controller: _discussionController,
              placeholder: 'Discussion',
              isMultiline: true,
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 218, 217, 217)
                        .withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.videocam,
                        size: 40,
                        color: const Color.fromARGB(255, 212, 212, 212)),
                    SizedBox(height: 8),
                    Text(
                      'Upload a Video Analysis',
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 146, 144, 144),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createReminder,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(47, 102, 127, 1),
                foregroundColor: Colors.white,
                padding: EdgeInsets.all(25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'Create a Reminder',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final bool isMultiline;
  final bool enabled;

  CustomTextInput({
    required this.controller,
    required this.placeholder,
    this.isMultiline = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color.fromARGB(255, 201, 200, 200)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 230, 230, 230).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: placeholder,
            contentPadding: EdgeInsets.all(16),
            border: InputBorder.none,
          ),
          maxLines: isMultiline ? 4 : 1,
          enabled: enabled,
        ),
      ),
    );
  }
}
