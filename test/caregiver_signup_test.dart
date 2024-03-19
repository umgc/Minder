import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:minder/Caregiver_Login/caregiver_login.dart';
import 'package:minder/Caregiver_Login/caregiver_signup.dart';

void main() {
  testWidgets('SignUpScreen widget test', (WidgetTester tester) async {
    // Build our SignUpScreen widget.
    await tester.pumpWidget(MaterialApp(
      home: SignUpScreen(),
    ));

    // Verify that the page title is displayed.
    expect(find.text('Sign Up'), findsOneWidget);

    // Verify that all input fields are present.
    expect(find.text('Enter your full name'), findsOneWidget);
    expect(find.text('Enter your Relationship'), findsOneWidget);
    expect(find.text('Enter your e-mail'), findsOneWidget);
    expect(find.text('Create a username'), findsOneWidget);
    expect(find.text('Create a password'), findsOneWidget);

    // Verify that the 'Sign Up' button is present.
    expect(find.text('Sign Up'), findsOneWidget);

    // Tap the 'Sign Up' button and verify navigation to LoginPage.
    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);

    // Verify that the 'Back' button in the app bar works.
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('Sign Up'), findsOneWidget);
  });
}