import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:minder/Caregiver_Login/caregiver_login.dart';
import 'package:minder/Caregiver_Login/caregiver_signup.dart';
import 'package:minder/patient_signup.dart';

void main() {
  testWidgets('LoginPage widget test', (WidgetTester tester) async {
    // Build our LoginPage widget.
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    // Verify that the app bar title is displayed.
    expect(find.text('Login Page'), findsOneWidget);

    // Verify that the 'Username' and 'Password' fields are present.
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Tap the 'Login' button and verify navigation to caregiversignup.
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(find.byType(patient_signup), findsOneWidget);

    // Tap the 'Create an account' link and verify navigation to SignUpScreen.
    await tester.tap(find.text('New here? Create an account.'));
    await tester.pumpAndSettle();
    expect(find.byType(SignUpScreen), findsOneWidget);
  });
}