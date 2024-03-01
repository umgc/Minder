import 'package:flutter/material.dart';

import '../Caregiver_Login/caregiver_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReminderFormScreen(),
    );
  }
}

class ReminderFormScreen extends StatefulWidget {
  @override
  _ReminderFormScreenState createState() => _ReminderFormScreenState();
}

class _ReminderFormScreenState extends State<ReminderFormScreen> {
  String imageUrl = "https://clipart.com/thumbs.php?f=/093/batch_02/bird_tnb.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
          
          },
        ),
        title: Text(
    'Create a Reminder',
    style: TextStyle(
      fontSize: 24,
      
      color: Colors.black, // Set text color
    ),
  ),
  centerTitle: true, // Center the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            SizedBox(height: 16),
            Container(
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color.fromARGB(255, 247, 247, 247),
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  InkWell(
                    onTap: () {
                      // Handle image change
                    },
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
            
           Center(
            child: Text(
              'Choose a Reminder Name',
              style: TextStyle(fontSize: 12,  color: Color.fromRGBO(197, 196, 196, 1)),
            ),
          ),
            SizedBox(height: 24),
            CustomTextInput(
              placeholder: 'Type of Event',
              isMultiline: false, // Set to true for multiline input
            ),
            
            CustomTextInput(
              placeholder: 'Date',
              isMultiline: false, // Set to true for multiline input
            ),
            
            CustomTextInput(
              placeholder: 'Time',
              isMultiline: false, // Set to true for multiline input
            ),
            
            CustomTextInput(
              placeholder: 'Discussion',
              isMultiline: true, // Set to true for multiline input
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
        color: const Color.fromARGB(255, 218, 217, 217).withOpacity(0.5),
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
        Icon(Icons.videocam, size: 40, color: const Color.fromARGB(255, 212, 212, 212)),
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
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle Create Reminder button press
              },
              style: ElevatedButton.styleFrom(
                                
                backgroundColor: Color.fromRGBO(47, 102, 127, 1),
                foregroundColor : Colors.white,
                
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
  final String placeholder;
  final bool isMultiline;

  CustomTextInput({required this.placeholder, this.isMultiline = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color.fromARGB(255, 201, 200, 200)), // Set the border color
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
        child: Container(
          color: Colors.white, // Set the background color
          child: TextFormField(
            decoration: InputDecoration(
              hintText: placeholder,
              contentPadding: EdgeInsets.all(16),
              border: InputBorder.none, // Remove the default border
            ),
            maxLines: isMultiline ? 4 : 1,
          ),
        ),
      ),
    );
  }
}
