import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:minder/end_user_license_agreement_patient.dart';
import 'package:minder/end_user_license_agreement.dart';
import 'package:minder/Welcome_screen/welcome.dart';

void main() {
  testWidgets('SplashScreen widget test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SplashScreen(),
    ));

    // Verify that 'Memory Support' title is displayed.
    expect(find.text('Memory Support'), findsOneWidget);

    // Verify that 'A place to record and organize conversations with doctors and reminders' subtitle is displayed.
    expect(find.text('A place to record and organize conversations with doctors and reminders'), findsOneWidget);

    // Verify that 'Caregiver Sign-In' button is displayed.
    expect(find.text('Caregiver Sign-In'), findsOneWidget);

    // Tap the 'Caregiver Sign-In' button and wait for the navigation animation to complete.
    await tester.tap(find.text('Caregiver Sign-In'));
    await tester.pumpAndSettle();

    // Verify that we have navigated to the caregiver EULA screen.
    expect(find.byType(CaregiverEulaScreen), findsOneWidget);

    // Tap the 'Patient Sign-In' button and wait for the navigation animation to complete.
    await tester.tap(find.text('Patient Sign-In'));
    await tester.pumpAndSettle();

    // Verify that we have navigated to the caregiver EULA screen for patients.
    expect(find.byType(CaregiverEulaScreen1), findsOneWidget);
  });
}
