import 'package:flutter/material.dart';
import 'package:minder/Views/Caregiver_Screens/care_giver_setting.dart';

void main() {
  runApp(const CaregiverSupport());
}

class CaregiverSupport extends StatelessWidget {
  const CaregiverSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              //Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
            },
          ),
          title: const Text('Caregiver Support'),
        ),
        body: Center(
          child: Container(
            width: 375,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: const CaregiverSupportScreen1(),
          ),
        ),
      ),
    );
  }
}

class CaregiverSupportScreen1 extends StatelessWidget {
  const CaregiverSupportScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap on the screen (optional).
      },
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
              },
              child: Image.asset(
                'asset/images/x.jpg', // Adjust the path to your image asset
                width: 20,
                height: 20,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Need Assistance?\n'
              'Contact our Support\n'
              'Team Below.\n',
              style: TextStyle(
                color: Color(0xFF030303),
                fontSize: 36,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: 200,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Handle Chat button press
                  print('Chat button pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 90, 156, 209),
                ),
                child: const Text(
                  'Chat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}