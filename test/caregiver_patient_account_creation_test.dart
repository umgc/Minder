import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:minder/Caregiver_Login/caregiver_patient_account_creation.dart';
import 'package:minder/patient_signup.dart';

void main() {
  testWidgets('caregiversignup widget test', (WidgetTester tester) async {
    // Build our caregiversignup widget.
    await tester.pumpWidget(MaterialApp(
      home: caregiversignup(),
    ));

    // Verify that the app bar title is displayed.
    expect(find.text('Create an Account'), findsOneWidget);

    // Verify that the 'Sign up for Patient account' text is displayed.
    expect(find.text('Sign up for Patient account'), findsOneWidget);

    // Verify that all form fields are present.
    expect(find.text('Patient\'s First Name *'), findsOneWidget);
    expect(find.text('Patient\'s Last Name *'), findsOneWidget);

    // Verify that the 'Sign Up' button is present.
    expect(find.text('Sign Up'), findsOneWidget);

    // Tap the 'Sign Up' button and verify navigation to patient_signup.
    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();
    expect(find.byType(patient_signup), findsOneWidget);
  });
}
