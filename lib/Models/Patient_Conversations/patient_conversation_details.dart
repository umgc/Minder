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

class conversationDetailsScreen extends StatefulWidget {
  @override
  _ConversationDetailsScreenState createState() => _ConversationDetailsScreenState();
}

class _ConversationDetailsScreenState extends State<conversationDetailsScreen> {
   String selectedButton = 'Full Conversation'; // Initial selected button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
           Navigator.pop(context);
          },
        ),
        title: const Text('Doctor Appointment'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDeleteConfirmationDialog(context);
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
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('01/19/2024 10:45 AM', style: TextStyle(fontSize: 10)),
                  Text('Duration: 00:35', style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTileButton(
                  'Full Conversation',
                  Icons.message,
                  fontSize: 10,
                ),
                buildTileButton(
                  'Summary              ',
                  Icons.notifications,
                  fontSize: 10,
                ),
                buildTileButton(
                  'Reminder             ',
                  Icons.notifications,
                  fontSize: 10,
                ),
                buildTileButton(
                  'Note                         ',
                  Icons.note,
                  fontSize: 10,
                ),
              ],
            ),
            const SizedBox(height: 16),
            buildContentContainer(selectedButton),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle play button press
                },
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.all(16),
                  backgroundColor: const Color.fromRGBO(47, 102, 127, 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.play_arrow, color: Colors.white),
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

  Widget buildTileButton(String text, IconData icon, {double fontSize = 12.0}) {
    bool isActive = selectedButton == text;
    Color backgroundColor = isActive ? const Color.fromRGBO(47, 102, 127, 1) : Colors.white;
    Color iconColor = isActive ? Colors.white : Colors.black;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Handle button click
          setState(() {
            selectedButton = text;
          });
        },
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
                const SizedBox(height: 8),
                Text(
                  text,
                  style: TextStyle(fontSize: fontSize, color: iconColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContentContainer(String selectedButton) {
    switch (selectedButton) {
      case 'Full Conversation':
        return Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(16),
          child: Text('Content for Full Conversation'),
        );
      case 'Summary              ':
        return Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(16),
          child: Text('This Section will show summary for the conversation'),
        );
      case 'Reminder             ':
        return Container(
          color: const Color.fromARGB(0, 238, 238, 238),
          padding: const EdgeInsets.all(16),
          child: Text('◉ Reminder 1 \n◉ Reminder 2 \n◉ Reminder 3'),
          
        );
      case 'Note                         ':
        return Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(16),
          child: Text('This Section will show notes for the conversation'),
        );
      default:
        return Container();
    }
  }

  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          content: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(151, 228, 241, 1),
                      ),
                      child: const Center(
                        child: Text(
                          '?',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Flexible(
                      child: Text(
                        'Are you sure you want to remove this conversation permanently?',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Handle delete button press
                Navigator.of(context).pop();
                // Add your delete logic here
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                // Handle cancel button press
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}