import 'package:flutter/material.dart';
import 'package:minder/Reminder/caregiver_reminder_creation.dart';

void main() {
  runApp(RemindersScreen());
}

class RemindersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ReminderBox(
                    icon: Icons.favorite,
                    iconColor: Colors.red,
                    text: "Meds  ",
                    description: "Take your prescribed",
                    image: Image.network("../asset/images/profile.png"),
                  ),
                  ReminderBox2(
                    text: "Doc  ",
                    description: "Remember to visit your",
                    image: Image.network("../asset/images/profile.png"),
                    buttonColor: Color.fromRGBO(47, 102, 127, 1),
                    buttonText: "Confirm",
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              Text(
                "This Week's Reminders",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ReminderBox(
                    icon: Icons.notifications,
                    text: "Exercise  ",
                    description: "Stay Active and maintain..",
                    image: Image.network("../asset/images/profile.png"),
                  ),
                  ReminderBox(
                    icon: Icons.note,
                    text: "Note  ",
                    description: "Remember important..",
                    image: Image.network("../asset/images/profile.png"),
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              Text(
                "Earlier Reminders",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ReminderBox(
                    icon: Icons.favorite,
                    iconColor: Colors.red,
                    text: "Heart  ",
                    description: "Monitor your heart health..",
                    image: Image.network("../assets/images/profile.png"),
                  ),
                  ReminderBox(
                    icon: Icons.message,
                    text: "Appoint  ",
                    description: "Record important..",
                    image: Image.network("../assets/images/profile.png"),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  // Handle home button press
                },
              ),
              Text('                       '),
              Text('            ')
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
                      'Are you sure you want to remove this Reminder?',
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

class ReminderBox extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String text;
  final String? description;
  final Image image;
  final Color? buttonColor;
  final String? buttonText;

  ReminderBox({
    this.icon,
    this.iconColor,
    required this.text,
    this.description,
    required this.image,
    this.buttonColor,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     
      padding: EdgeInsets.all(10.0),
      margin:EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: iconColor,
              size: 32.0,
            ),
          
          SizedBox(height: 8.0),
          Text(
            text,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          if (description != null)
            Text(
              description!,
              textAlign: TextAlign.center,
            ),
          SizedBox(height: 8.0),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: image,
            ),
          ),
          if (buttonText != null)
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
              ),
              child: Text(buttonText!),
            ),
        ],
      ),
    );
  }
   
}
class ReminderBox2 extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String text;
  final String? description;
  final Image image;
  final Color? buttonColor;
  final String? buttonText;

  ReminderBox2({
    this.icon,
    this.iconColor,
    required this.text,
    this.description,
    required this.image,
    this.buttonColor,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     
      padding: EdgeInsets.all(10.0),
      margin:EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image,
          
          if (icon != null)
            Icon(
              icon,
              color: iconColor,
              size: 32.0,
            ),
          
          SizedBox(height: 8.0),
          Text(
            text,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          if (description != null)
            Text(
              description!,
              textAlign: TextAlign.center,
            ),
          SizedBox(height: 8.0),
          
          if (buttonText != null)
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: 
              ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: buttonColor,
              ),
              child: Text(buttonText!),
            ),
            ),
          ),
            
        ],
      ),
    );
  }
}
