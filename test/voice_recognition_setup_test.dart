import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/voice_recognition_setup.dart'; // Import the main.dart file

void main() {
  testWidgets('VoiceRecognitionScreen Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp());

    // Verify that the initial UI contains the expected widgets.
    expect(find.byType(MaterialApp), findsOneWidget); // Check if MaterialApp widget is present
    expect(find.byType(Scaffold), findsOneWidget); // Check if Scaffold widget is present
    expect(find.byType(AppBar), findsOneWidget); // Check if AppBar widget is present
    expect(find.text('Voice Recognition'), findsOneWidget); // Check if app bar title text is present
    expect(find.byType(Column), findsNWidgets(2)); // Check if 2 Column widgets are present
    expect(find.byType(Image), findsOneWidget); // Check if Image widget is present
    expect(find.text('Press the button and tell Minder your name!'), findsOneWidget); // Check if initial text is present
    expect(find.byType(ElevatedButton), findsOneWidget); // Check if ElevatedButton widget is present
    expect(find.byIcon(Icons.mic), findsOneWidget); // Check if mic icon button is present
    expect(find.byType(NewScreen1), findsOneWidget); // Check if NewScreen1 widget is present

    // Tap the mic button and wait for result
    await tester.tap(find.byIcon(Icons.mic));
    await tester.pump();

    // Verify that the mic button changes state
    expect(find.byIcon(Icons.stop), findsOneWidget); // Check if stop icon button is present

    // Tap the stop button and wait for result
    await tester.tap(find.byIcon(Icons.stop));
    await tester.pump();

    // Verify that the mic button changes state back to initial state
    expect(find.byIcon(Icons.mic), findsOneWidget); // Check if mic icon button is present
  });
}
