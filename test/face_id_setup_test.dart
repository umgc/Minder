import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/face_id_setup.dart';

void main() {
  testWidgets('Face Detection Screen Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: FaceDetectionScreen(),
    ));

    // Verify that the 'Take Picture and Detect Faces' button is displayed
    expect(find.text('Take Picture and Detect Faces'), findsOneWidget);

    // Simulate tapping on the button
    await tester.tap(find.text('Take Picture and Detect Faces'));
    await tester.pumpAndSettle();

    // Verify that the dialog showing the number of detected faces is displayed
    expect(find.byType(AlertDialog), findsOneWidget);

    // Verify that the dialog shows the correct number of detected faces
    expect(find.text('Found'), findsOneWidget); // Check for the 'Found' text
    expect(find.text('face'), findsOneWidget); // Check for the 'face' text

    // Simulate tapping on the 'OK' button in the dialog
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
  });
}
