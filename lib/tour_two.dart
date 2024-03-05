import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minder Guided Tour: Part 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getCurrentTime() {
      return DateFormat('HH:mm:ss').format(DateTime.now());
    }

    String getCurrentDate() {
      return DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());
    }

    void _showPlayPopup(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Guided Tour: Play Recording'),
            content: const Text('This plays a media file associated with the current conversation, if the file exists.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }

    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Minder Guided Tour: Conversation Details'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Back button functionality
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // Show delete confirmation dialog
                _showDeleteConfirmationDialog(context);
              },
            ),
            const SizedBox(width: 16),
            _buildDateTimeDisplay(getCurrentTime(), getCurrentDate()),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Summary'),
              Tab(text: 'Reminders'),
              Tab(text: 'Notes'),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'File Name',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(height: 8),
            const Expanded(
              child: TabBarView(
                children: [
                  // Tab 1
                  _TabContent(),
                  // Tab 2
                  _TabContent(),
                  // Tab 3
                  _TabContent(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Show play popup
            _showPlayPopup(context);
          },
          child: const Icon(Icons.play_arrow),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget _buildDateTimeDisplay(String time, String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.access_time),
          const SizedBox(width: 8),
          Text('$time\n$date', textAlign: TextAlign.center),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Guided Tour: Delete'),
          content: const Text('From here you can delete the current file. Select "cancel" to not delete, select "delete" to confirm deletion. In this demo, nothing will happen when either are clicked.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform delete operation here
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

class _TabContent extends StatelessWidget {
  const _TabContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        onChanged: (value) {
          // Handle text field value changes
        },
        decoration: InputDecoration(
          hintText: 'Enter your text here...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
