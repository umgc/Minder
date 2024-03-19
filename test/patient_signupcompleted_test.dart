import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/care_giver_setting.dart';
import 'package:minder/patient_signupcompleted.dart';


void main() {
  testWidgets('Patient Signup Completed Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: PatientSignupCompleted(),
    ));

    // Verify that the initial UI contains the expected widgets.
    expect(find.text('Done'), findsOneWidget);
    expect(find.text('Face ID is now'), findsOneWidget);
    expect(find.text('Set Up.'), findsOneWidget);

    // Tap the 'Done' button.
    await tester.tap(find.text('Done'));
    await tester.pump(); // Rebuild the widget after the tap.

    // Verify that the navigation occurred to Settings.
    expect(find.byType(Settings), findsOneWidget);
  });
}
