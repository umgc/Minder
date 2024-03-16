import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConversationDetailsScreen(),
    );
  }
}

class ConversationDetailsScreen extends StatefulWidget {
  @override
  _ConversationDetailsScreenState createState() =>
      _ConversationDetailsScreenState();
}

class _ConversationDetailsScreenState extends State<ConversationDetailsScreen> {
  List<String> notes = [];

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
        title: Text('Doctor Appointment'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDeleteConfirmationDialog(context);
            },
          ),
        ],
        elevation: 8,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: const Color.fromARGB(255, 190, 190, 190)),
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('01/19/2024 10:45 AM', style: TextStyle(fontSize: 14)),
                  Text('Duration: 00:35', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTileButton('Full Conversation', Icons.message,
                    Colors.white, const Color.fromRGBO(47, 102, 127, 1),
                    fontSize: 12),
                buildTileButton(
                    'Summary', Icons.notifications, Colors.black, Colors.white,
                    fontSize: 12),
                buildTileButton(
                    'Reminder', Icons.notifications, Colors.black, Colors.white,
                    fontSize: 12),
                buildTileButton(
                  'Note',
                  Icons.note,
                  Colors.black,
                  Colors.white,
                  fontSize: 12,
                  onTap: () async {
                    final String? newNote = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return NoteDialog();
                      },
                    );
                    if (newNote != null && newNote.isNotEmpty) {
                      setState(() {
                        notes.add(newNote);
                      });
                    }
                  },
                ),
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
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.all(16),
                  backgroundColor: Color.fromRGBO(47, 102, 127, 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Play',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTileButton(
      String text, IconData icon, Color iconColor, Color backgroundColor,
      {double fontSize = 12.0, Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
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
      ),
    );
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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(151, 228, 241, 1),
                      ),
                      child: Center(
                        child: Text(
                          '?',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Flexible(
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
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
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

class NoteDialog extends StatefulWidget {
  @override
  _NoteDialogState createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Note'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(hintText: 'Enter your note here'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_controller.text);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
