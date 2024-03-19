import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/patient_signup.dart';
import 'package:minder/patient_signupcompleted.dart';

void main() {
  testWidgets('Patient Signup Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: patient_signup(),
    ));

    // Verify that the initial UI contains the expected widgets.
    expect(find.text('Welcome to Minder!'), findsOneWidget);
    expect(find.text('Move your head slowly to complete the circle'), findsOneWidget);
    expect(find.text('Set up your Face ID'), findsOneWidget);

    // Tap the 'Set up your Face ID' button.
    await tester.tap(find.text('Set up your Face ID'));
    await tester.pump(); // Rebuild the widget after the tap.

    // Verify that the navigation occurred to PatientSignupCompleted.
    expect(find.byType(PatientSignupCompleted), findsOneWidget);
  });
}
