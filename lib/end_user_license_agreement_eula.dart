import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Support App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EulaScreen(),
    );
  }
}

class EulaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40),
            Text(
              'Minder',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 43, fontWeight: FontWeight.bold),
            ),
                  SizedBox(height: 40),
                  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
                    'By using the Short-Term Memory Support App, you are granted a personal use license for a single device. The app is designed to provide support for individuals with short-term memory challenges through video analysis. Your responsibilities include refraining from modifications, distribution, and maintaining confidentiality. By using the app, you agree to the recording and analysis of the video content as outlined in the privacy policy.',
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                  ),
              ),],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle Disagree button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  Color.fromRGBO(137, 191, 224, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Disagree',
                          style: TextStyle(color: Colors.white,fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle Agree button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(45, 102, 127, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Agree',
                          style: TextStyle(color: Colors.white,fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}