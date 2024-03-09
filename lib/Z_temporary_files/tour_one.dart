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
                  left: 30,
                  top: 54,
                  width: 325,
                  height: 559,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://assets.api.uizard.io/api/cdn/stream/40d873a7-c901-48f6-ad5a-2298a13f53fc.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 11,
                  top: 11.5,
                  width: 31,
                  height: 31,
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
                Positioned(
                  left: 271,
                  top: 627,
                  width: 40,
                  height: 40,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFAAD3FF),
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 162,
                  top: 627,
                  width: 40,
                  height: 40,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFAAD3FF),
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 64,
                  top: 627,
                  width: 40,
                  height: 40,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2F667F),
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 200,
                  top: 231,
                  width: 145,
                  height: 117,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://assets.api.uizard.io/api/cdn/stream/36912534-89d0-4804-9085-2480712f8534.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 200,
                  top: 449,
                  width: 145,
                  height: 117,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://assets.api.uizard.io/api/cdn/stream/36912534-89d0-4804-9085-2480712f8534.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 215,
                  top: 266,
                  child: Text(
                    'Tap to see details',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 13,
                      color: Color(0xFF161616),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                const Positioned(
                  left: 215,
                  top: 283,
                  child: Text(
                    'and play the',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 13,
                      color: Color(0xFF161616),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                const Positioned(
                  left: 215,
                  top: 300,
                  child: Text(
                    'conversation',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 13,
                      color: Color(0xFF161616),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                const Positioned(
                  left: 215,
                  top: 491,
                  child: Text(
                    'Tap to start',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 13,
                      color: Color(0xFF161616),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                const Positioned(
                  left: 215,
                  top: 508,
                  child: Text(
                    'recording',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 13,
                      color: Color(0xFF161616),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
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
}
