import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 375,
        height: 667,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 43,
              child: Container(
                width: 335,
                height: 584,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://assets.api.uizard.io/api/cdn/stream/dfede6a5-bec4-475d-ae7a-a8400a68d504.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 11,
              top: 11.5,
              child: Container(
                width: 31,
                height: 31,
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              left: 284,
              top: 627,
              child: Container(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.circle,
                  color: Color(0xFF2f667f),
                ),
              ),
            ),
            Positioned(
              left: 82,
              top: 627,
              child: Container(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.circle,
                  color: Color(0xFFaad3ff),
                ),
              ),
            ),
            Positioned(
              left: 184,
              top: 627,
              child: Container(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.circle,
                  color: Color(0xFFaad3ff),
                ),
              ),
            ),
            Positioned(
              left: 55,
              top: 467,
              child: Container(
                width: 135,
                height: 111,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://assets.api.uizard.io/api/cdn/stream/b3b5f7a1-b0a1-4f2d-a345-91558054c237.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 63,
              top: 506,
              child: Text(
                'Tap to save the',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 13,
                  color: Color(0xFF161616),
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Positioned(
              left: 63,
              top: 523,
              child: Text(
                'recording.',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 13,
                  color: Color(0xFF161616),
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
