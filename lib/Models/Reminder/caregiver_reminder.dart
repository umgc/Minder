import 'package:flutter/material.dart';
import 'package:minder/Models/Reminder/caregiver_reminder_creation.dart';
import 'package:minder/Models/Reminder/update_reminder.dart';
import 'package:minder/Services/sqflite_database.dart';

class RemindersScreen extends StatefulWidget {
  @override
  _RemindersScreenState createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  late List<Reminder> reminders = [];

  @override
  void initState() {
    super.initState();
    loadReminders();
  }

  Future<void> loadReminders() async {
    List<Reminder> allReminders = await DatabaseHelper.instance.getAllReminders();
    setState(() {
      reminders = allReminders;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Group reminders by event type
    Map<String, List<Reminder>> remindersByEventType = groupRemindersByEventType();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reminders",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDeleteConfirmationDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Today's Reminders",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            buildReminderSection(remindersByEventType['today']),
            SizedBox(height: 32.0),
            Text(
              "This Week's Reminders",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            buildReminderSection(remindersByEventType['thisWeek']),
            SizedBox(height: 32.0),
            Text(
              "Earlier Reminders",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            buildReminderSection(remindersByEventType['earlier']),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReminderFormScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildReminderSection(List<Reminder>? reminders) {
  if (reminders == null || reminders.isEmpty) {
    return Container(); // Return an empty container if there are no reminders
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: reminders.map((reminder) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: GestureDetector(
          onTap: () {
            // Navigate to update reminder page
            Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => UpdateReminderFormScreen(reminder: reminder), // Pass reminder correctly
  ),
);

          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder.eventType,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  reminder.description,
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList(),
  );
}


  Map<String, List<Reminder>> groupRemindersByEventType() {
    Map<String, List<Reminder>> groupedReminders = {
      'today': [],
      'thisWeek': [],
      'earlier': [],
    };

    for (Reminder reminder in reminders) {
      if (isToday(reminder.date)) {
        groupedReminders['today']!.add(reminder);
      } else if (isThisWeek(reminder.date) && !isToday(reminder.date)) {
        groupedReminders['thisWeek']!.add(reminder);
      } else {
        groupedReminders['earlier']!.add(reminder);
      }
    }

    // Sort each list of reminders by event type
    groupedReminders.forEach((key, value) {
      value.sort((a, b) => a.eventType.compareTo(b.eventType));
    });

    return groupedReminders;
  }

  bool isToday(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  bool isThisWeek(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
    return date.isAfter(startOfWeek) && date.isBefore(endOfWeek);
  }

  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Confirmation"),
          content: Text("Are you sure you want to delete this reminder?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Delete reminder logic here
                Navigator.of(context).pop();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
