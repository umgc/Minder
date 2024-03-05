import 'package:flutter/material.dart';

void main() {
  runApp(const CaregiverSupport());
}

class CaregiverSupport extends StatelessWidget {
  const CaregiverSupport({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Caregiver Support'),
        ),
        body: Center(
          child: Container(
            width: 375,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: CaregiverSupportScreen1(),
          ),
        ),
      ),
    );
  }
}

class CaregiverSupportScreen1 extends StatelessWidget {
  const CaregiverSupportScreen1({Key? key});

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
            Text(
              'Need assistance?',
              style: TextStyle(
                color: Color(0xFF030303),
                fontSize: 36,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 14),
            Text(
              'Tap below to',
              style: TextStyle(
                color: Color(0xFF030303),
                fontSize: 36,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'connect with our',
              style: TextStyle(
                color: Color(0xFF030303),
                fontSize: 36,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 14),
            Text(
              'support team.',
              style: TextStyle(
                color: Color(0xFF030303),
                fontSize: 36,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 14),
            Container(
              width: 200,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Handle Chat button press
                  print('Chat button pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 90, 156, 209),
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
