

import 'package:flutter/material.dart';
import 'package:minder/Reminder/caregiver_reminder_creation.dart';
import 'package:minder/Tour/caregiver_tour_guide_1.dart';
import 'package:minder/Welcome_screen/welcome.dart';
import 'package:minder/all_tour_guide.dart';
import 'package:minder/care_giver_support-screen.dart';
import 'Reminder/caregiver_reminderscreen.dart';




void main() {
  runApp(const Settings());
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile Information Box
             Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 2,
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  ),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        // Image
        Image.asset(
          '../asset/images/profile.png', // Provide the path to your image asset
          width: 60, // Set the desired width
          height: 60, // Set the desired height
        ),
        const SizedBox(width: 16), // Add spacing between image and text
        // Profile Information Text and Edit Icon
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Edit profile details',
                style: TextStyle(
                  color: Color.fromARGB(255, 119, 119, 119),
                ),
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.topRight,
          child: Text(
                '>',
                style: TextStyle(
                  fontFamily: 'SansSerifFont',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ],
    ),
  ),
),
              const SizedBox(height: 25),
              // Reminders, Guided Tour, Support Center Boxes
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    buildListItem('Reminders', Icons.notifications, context),
                    buildListItem('Guided Tour', Icons.explore, context),
                    buildListItem('Support Center', Icons.live_help, context),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Sign Out Button
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Handle sign-out logic
                  Navigator.push(
              context ,
              MaterialPageRoute(builder: (context) =>    SplashScreen()),
            );
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 168, 225, 252),
                ),
                child: const Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListItem(String title, IconData icon, BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: const Text(
                '>',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
      onTap: () {
        // Handle the tap on each item
        switch ( title ) { 
              case 'Reminders': { 
                  
                   Navigator.push(
              context ,
              MaterialPageRoute(builder: (context) =>    RemindersScreen()),
            );
              } break; 
              case 'Guided Tour': { 
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConversationListTourScreen()),
              );
              } break; 
              case 'Support Center': { 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CaregiverSupport()),
              );    

              } break;
              default: { 
                  //Body of default case  
              } break; 
            } 
        print('$title tapped');
      },
    );
  }
}
