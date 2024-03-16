import 'package:flutter/material.dart';
import 'package:minder/Views/Tour/caregiver_tour_guide_1.dart';
import 'package:minder/Views/Welcome_screen/welcome.dart';
import 'package:minder/Views/Caregiver_Screens/care_giver_support-screen.dart';
import '../../Models/Reminder/caregiver_reminderscreen.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

void main() {
  runApp(const Settings());
}

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key); // Updated for null safety

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
                        'asset/images/profile.jpg', // Provide the path to your image asset
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
                        child: Icon(Icons.navigate_next, size: 36),
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
              Spacer(),
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
              MaterialPageRoute(builder:
(context) => const ConversationListTourScreen()),
);
break;
case 'Support Center':
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const CaregiverSupport()),
);
break;
default:
// Optionally, handle unexpected cases
break;
}
print('$title tapped');
},
);
}
}