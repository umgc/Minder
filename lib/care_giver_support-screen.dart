import 'package:flutter/material.dart';

void main() {
  runApp(const CaregiverSupport());
}

class CaregiverSupport extends StatelessWidget {
  const CaregiverSupport({super.key, Key? door});

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
              Navigator.pop(context);
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
  const CaregiverSupportScreen1({super.key, Key? wall});

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
            Positioned(
              left: 30,
              top: 70.50,
              child: Image.asset(
                'asset/images/x.jpg',
                width: 20,
                height: 20,
              ),
            ),
            const Text(
              'Need assistance?',
              style: TextStyle(
                color: Color(0xFF030303),
                fontSize: 36,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Tap below to',
              style: TextStyle(
                color: Color(0xFF030303),
                fontSize: 36,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'connect with our',
              style: TextStyle(
                color: Color(0xFF030303),
                fontSize: 36,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'support team.',
              style: TextStyle(
                color: Color(0xFF030303),
                fontSize: 36,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
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
                    height: 0,
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
