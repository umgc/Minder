import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minder/Services/sqflite_database.dart';
import 'package:minder/Models/Reminder/caregiver_reminder_creation.dart';
import 'package:minder/Views/Caregiver_Screens/care_giver_setting.dart';

class UpdateReminderFormScreen extends StatefulWidget {
  final Reminder reminder;

  const UpdateReminderFormScreen({Key? key, required this.reminder}) : super(key: key);

  @override
  _UpdateReminderFormScreenState createState() => _UpdateReminderFormScreenState();
}

class _UpdateReminderFormScreenState extends State<UpdateReminderFormScreen> {
  late TextEditingController dateController;
  late TextEditingController timeController;
  late TextEditingController descriptionController;
  String? selectedEventType;

  @override
  void initState() {
    super.initState();
    selectedEventType = widget.reminder.eventType;
    dateController = TextEditingController(text: widget.reminder.date);
    timeController = TextEditingController(text: widget.reminder.time);
    descriptionController = TextEditingController(text: widget.reminder.description);
  }

  Future<void> updateReminder() async {
    if (widget.reminder.id == null) {
      print('Error: Reminder ID is null.');
      return;
    }

    int rowsAffected = await DatabaseHelper.instance.updateReminder({
      'id': widget.reminder.id,
      'eventType': selectedEventType ?? '',
      'description': descriptionController.text,
      'date': dateController.text,
      'time': timeController.text,
    });

    if (rowsAffected != 0) {
      print('Update successful for reminder ID: ${widget.reminder.id}');
      Navigator.pop(context); // Assuming you want to pop back on successful update
    } else {
      print('Update failed for reminder ID: ${widget.reminder.id}. No rows affected.');
    }
  }

  Future<void> deleteReminder() async {
    if (widget.reminder.id == null) {
      print('Error: Reminder ID is null.');
      return;
    }

    await DatabaseHelper.instance.deleteReminder(widget.reminder.id!);
    Navigator.pop(context); // Go back to the previous screen
  }

  void showDeleteConfirmationDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete Confirmation"),
        content: Text("Are you sure you want to delete this reminder?"),
        actions: <Widget>[
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Delete"),
            onPressed: () async {
              await deleteReminder();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()), // Assuming Settings() is your destination Widget
              );
            },
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Reminder'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.black),
            onPressed: () => showDeleteConfirmationDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Event Type Dropdown
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
              onChanged: (newValue) {
                setState(() {
                  selectedEventType = newValue;
                });
              },
            ),
            SizedBox(height: 24),
            // Date Field
            TextFormField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateFormat('yyyy-MM-dd').parse(dateController.text),
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
            SizedBox(height: 24),
            // Time Field
            TextFormField(
              controller: timeController,
              decoration: InputDecoration(
                labelText: 'Time',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.access_time),
              ),
              readOnly: true,
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(DateFormat("hh:mm").parse(timeController.text)),
                );
                if (pickedTime != null) {
                  setState(() {
                    timeController.text = pickedTime.format(context);
                  });
                }
              },
            ),
            SizedBox(height: 24),
            // Description Field
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            SizedBox(height: 24),
            // Update Button
                     
                      
            
             ElevatedButton(


              onPressed: () async {
                await updateReminder(); // Wait for the update to complete

                // Navigate to the Settings screen after the update is complete
                Navigator.pushReplacement( // Consider using pushReplacement to avoid building a large stack of screens
                  context,
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
              },
              child: Text('Update Reminder'),
              style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromRGBO(47, 102, 127, 1),
              ),
            ),
            SizedBox(height: 24),
           
           
          ],
        ),
      ),
    );
  }

  // Assuming you have this map defined somewhere in your class as it was used in your original code.
  final Map<String, String> eventTypeDescriptions = {
    'Health': 'Medications, appointments, and exercise.',
    'Social': 'Family gatherings, birthdays, and social activities.',
    'Finance': 'Bill payments and financial management.',
    'Leisure': 'Hobbies, personal care, and relaxation.',
    'Meals': 'Meal planning, groceries, and nutrition.',
  };
}
