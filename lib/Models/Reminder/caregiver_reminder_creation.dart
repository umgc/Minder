import 'dart:core';

import 'package:flutter/material.dart'; 
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:minder/main.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:minder/Services/sqflite_database.dart';
import 'package:minder/Views/Caregiver_Screens/care_giver_setting.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones(); // Initialize timezone data
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
class Reminder {
  final int? id; // Make id nullable
  final String eventType;  
  final String description;
  final String date;
  final String time;

  Reminder({
    this.id, // Include id in the constructor
    required this.eventType,
    required this.description,
    required this.date,
    required this.time,
  });
}


class _ReminderFormScreenState extends State<ReminderFormScreen> {
   List<Reminder> reminders = [];
  // Existing setup for event types and descriptions
  final Map<String, String> eventTypeDescriptions = {
    'Health': 'Medications, appointments, and exercise.',
    'Social': 'Family gatherings, birthdays, and social activities.',
    'Finance': 'Bill payments and financial management.',
    'Leisure': 'Hobbies, personal care, and relaxation.',
    'Meals': 'Meal planning, groceries, and nutrition.',
  };

  String? selectedEventType; // Selected event type
  final TextEditingController dateController = TextEditingController(); // Controller for the date field
  final TextEditingController timeController = TextEditingController(); // Controller for the time field
  final TextEditingController descriptionController = TextEditingController(); // Controller for the description field
  String imageUrl = "https://clipart.com/thumbs.php?f=/093/batch_02/bird_tnb.png"; // Placeholder image URL

  // Function to show description for selected event type
  void _showDescription(String eventType) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                eventType,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                eventTypeDescriptions[eventType]!,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }

  
// Method to schedule a reminder
 Future<void> scheduleReminder() async {
  if (selectedEventType == null || descriptionController.text.isEmpty || dateController.text.isEmpty || timeController.text.isEmpty) {
    // Show a SnackBar with an error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please complete all fields to schedule the reminder.'),
        duration: Duration(seconds: 2),
      ),
    );
    return; // Stop the method if validation fails
  }

  try {
    // Parse the date from the dateController
    final DateTime pickedDate = DateFormat('yyyy-MM-dd').parse(dateController.text);
    // Assuming timeController.text = "HH:MM AM/PM"
    final DateFormat format = DateFormat("h:mm a");
    final DateTime dateTime = format.parse(timeController.text);
    final int hour = dateTime.hour; // 24-hour format
    final int minute = dateTime.minute;

    // Combine the date and time to create a complete DateTime object
    final DateTime scheduledDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      hour,
      minute,
    );

    // Use the timezone package to handle time zones correctly
    final tz.TZDateTime zonedScheduledDateTime = tz.TZDateTime.from(
      scheduledDateTime,
      tz.local,
    );

    // Define notification details
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true, // Changed to false as ongoing notifications are ongoing and may not be dismissible by the user.
    );
    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    // Schedule the notification
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // Notification ID
      'Reminder: ${selectedEventType ?? 'Event'}', // Notification title
      descriptionController.text, // Notification body
      zonedScheduledDateTime,
      platformDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // To match the time component only if repeating
    );

    print('Reminder scheduled successfully for $scheduledDateTime');
  } catch (e) {
    print('Error parsing date/time: $e');
  }
}

// Function to add a new reminder object
  void addReminder() async {
  // Reminder object based on user input
    if (selectedEventType == null || descriptionController.text.isEmpty || dateController.text.isEmpty || timeController.text.isEmpty) {
    // Show a SnackBar with an error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please fill out all fields to create a reminder.'),
        duration: Duration(seconds: 2),
      ),
    );
    return; // Stop the method if validation fails
  }
  Reminder newReminder = Reminder(
    eventType: selectedEventType ?? '',
    description: descriptionController.text,
    date: dateController.text, // Directly use the date as String
    time: timeController.text, id: null, // Directly use the time as String
  );

  // Add the new reminder to the list for immediate UI update
  setState(() {
    reminders.add(newReminder);
  });

  // Prepare the reminder information for database insertion
  final reminderMap = {
    'description': descriptionController.text,
    'eventType': selectedEventType ?? 'Other',
    'date': dateController.text,
    'time': timeController.text,
  };

  // Insert the reminder into the database
  try {
    await DatabaseHelper.instance.insertReminder(reminderMap);
    // Optionally, show a success message or feedback to the user
  } catch (e) {
    // Handle any errors that occur during database insertion
    print('Error inserting reminder into database: $e');
    // Optionally, show an error message or feedback to the user
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Create a Reminder', style: TextStyle(fontSize: 24, color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  
                ],
              ),
            ),
            SizedBox(height: 24),



            // Event Type Selection Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Event Type',
                border: OutlineInputBorder(),
              ),
              value: selectedEventType,
              items: eventTypeDescriptions.keys.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedEventType = newValue!;
                });
                _showDescription(newValue!);
              },
            ),
            
            
            // Date Selection Field
            SizedBox(height: 24),
            TextFormField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: "Date",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                  });
                }
              },
            ),
            // Time Selection Field
            SizedBox(height: 16),
            TextFormField(
              controller: timeController,
              decoration: InputDecoration(
                labelText: "Time",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.access_time),
              ),
              readOnly: true,
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() {
                    timeController.text = pickedTime.format(context);
                  });
                }
              },
            ),
            // Description Field
            SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            // Create Reminder Button
            SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
              

              // Call the function to schedule the reminder  
                 scheduleReminder();
                 
             // Call the function to add a new reminder
                 addReminder();

              // Navigate back to the previous screen
                  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Settings()),
  );
              },
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
