import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
       body: Center(
          child: Container(
        width: 375,
        height: 667,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 33,
              top: 70,
              child: Container(
                width: 309,
                height: 527,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://assets.api.uizard.io/api/cdn/stream/28b8daef-658c-472b-a8e9-fac320652a00.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 11,
              top: 11.5,
              child: SizedBox(
                width: 31,
                height: 31,
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
            const Positioned(
              left: 279,
              top: 627,
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.circle,
                  color: Color(0xFFaad3ff),
                ),
              ),
            ),
            const Positioned(
              left: 74,
              top: 627,
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.circle,
                  color: Color(0xFFaad3ff),
                ),
              ),
            ),
            const Positioned(
              left: 169,
              top: 627,
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.circle,
                  color: Color(0xFF2f667f),
                ),
              ),
            ),
            Positioned(
              left: 147,
              top: 97,
              child: Container(
                width: 156,
                height: 115,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://assets.api.uizard.io/api/cdn/stream/2cc0b016-e38a-4777-ac07-415ee74ac2b8.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 153,
              top: 155,
              child: Text(
                'Tap to delete this',
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
            const Positioned(
              left: 153,
              top: 172,
              child: Text(
                'conversation.',
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
              left: 33,
              top: 276,
              child: Container(
                width: 216,
                height: 193,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://assets.api.uizard.io/api/cdn/stream/93d7817c-caf5-4a0f-930a-9ee9bc04f514.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 74,
              top: 350,
              child: Text(
                'Select a transmogrifier to extract useful information from this conversation.',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 16,
                  color: Colors.black,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            // Continue with the other text widgets...
          ],
        ),
      ),
    ),
    ),
    );
  }
}
