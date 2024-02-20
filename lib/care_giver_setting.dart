import 'package:flutter/material.dart';

class CaregiverSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Information',
              style: TextStyle(
                color: Color(0xFF030303),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('Name: John Doe'),
              subtitle: Text('Email: john.doe@example.com'),
              onTap: () {
                // Add your logic for profile information
              },
            ),
            Divider(),
            Text(
              'Settings',
              style: TextStyle(
                color: Color(0xFF030303),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your logic for Edit Profile button
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 152, 199, 238),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your logic for Reminders button
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 152, 199, 238),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Reminders',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your logic for Guided Tour button
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 152, 199, 238),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Guided Tour',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your logic for Support Center button
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 152, 199, 238),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Support Center',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black),
          ),
          color: const Color.fromARGB(255, 152, 199, 238),
        ),
        child: ElevatedButton(
          onPressed: () {
            // Add your logic for Sign Out button
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: const Color.fromARGB(255, 152, 199, 238),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: const Color.fromARGB(255, 152, 199, 238)),
            ),
          ),
          child: Text(
            'Sign Out',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
    ),
    home: CaregiverSettingScreen(),
  ));
}
