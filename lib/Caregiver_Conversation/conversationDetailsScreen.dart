import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: conversationDetailsScreen(),
    );
  }
}

class conversationDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: Text('Doctor Appointment'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Handle delete button press
            },
          ),
        ],
        elevation: 8, // Add shadow to the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color.fromARGB(255, 190, 190, 190)),
              ),
              padding: EdgeInsets.all(8),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('01/19/2024 10:45 AM', style: TextStyle(fontSize: 10)),
                  Text('Duration: 00:35', style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
            SizedBox(height: 12),
           Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    buildTileButton('Full Conversation', Icons.message, Colors.white, const Color.fromRGBO(47, 102, 127, 1), fontSize: 10),
     buildTileButton('Summary', Icons.notifications, Colors.black, Colors.white, fontSize: 10),
    buildTileButton('Reminder', Icons.notifications, Colors.black, Colors.white, fontSize: 10),
    buildTileButton('Note', Icons.note, Colors.black, Colors.white, fontSize: 10),
  ],
),
            SizedBox(height: 16),
            const Text(
              'Patient: "some questions"\nDoctor: "some response"',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle play button press
                },
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(16),
                  backgroundColor: Color.fromRGBO(47, 102, 127, 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Play', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTileButton(String text, IconData icon, Color iconColor, Color backgroundColor, {double fontSize = 12.0}) {
  return Expanded(
    child: Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 24),
            SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(fontSize: fontSize, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
}