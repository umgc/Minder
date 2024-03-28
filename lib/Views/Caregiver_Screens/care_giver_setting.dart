// COntributors:  
  // Developed by: Lensa Gemeda
  // Code Cleanup: Elsa Bushen

import 'package:flutter/material.dart';
import 'package:minder/Views/Tour/caregiver_tour_guide_1.dart';
import 'package:minder/Views/Welcome_screen/welcome.dart';
import 'package:minder/Views/Caregiver_Screens/care_giver_support-screen.dart';
import 'package:minder/Models/Reminder/caregiver_reminder.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

void main() {
  runApp(const Settings());
}

/// A StatelessWidget that represents the Settings screen of the application.
/// This screen provides navigation to various features like Reminders, Guided Tour, and Support Center.
class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key); // Updated for null safety

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: SingleChildScrollView( 
          child: Padding(
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
                        
                        Image.asset(
                          'asset/images/minderlogo2.png',
                          width: 120,
                          height: 120,
                        ),
                        const SizedBox(width: 16),
                        // Profile Information Text and Edit Icon
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hey Caregiver',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Tap into Minders settings to streamline your caregiving journey!',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 119, 119, 119),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Align(
                          alignment: Alignment.topRight,
                          
                          
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                
                // Container holding list items for navigation: Reminders, Guided Tour, and Support Center.
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
               
                // Sign Out button that performs user sign-out using Amplify.Auth.
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await Amplify.Auth.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SplashScreen()),
                      );
                    } catch (e) {
                      print("Error signing out: $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(47, 102, 127, 1),
                  ),
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Color.fromRGBO(247, 245, 245, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Each ListTile represents an actionable item leading to a different part of the app.
  Widget buildListItem(String title, IconData icon, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.navigate_next),
      onTap: () {
        switch (title) {
          case 'Reminders':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RemindersScreen()),
            );
            break;
          case 'Guided Tour':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ConversationListTourScreen()),
            );
            break;
          case 'Support Center':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CaregiverSupport()),
            );
            break;
          default:
            break;
        }
        print('$title tapped');
      },
    );
  }
}
