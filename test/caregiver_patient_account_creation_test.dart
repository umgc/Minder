import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Caregiver_Login/caregiver_signup.dart';

void main() {
  group('SignUpScreen tests', () {
    testWidgets('SignUpScreen has a title and message',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: SignUpScreen()));

      // Verify that our screen has a title and message.
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.text('Enter your full name'), findsOneWidget);
      expect(find.text('Enter your Relationship'), findsOneWidget);
      expect(find.text('Enter your e-mail'), findsOneWidget);
      expect(find.text('Create a username'), findsOneWidget);
      expect(find.text('Create a password'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('SignUpScreen shows error message when fields are empty',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: SignUpScreen()));

      // Tap the Sign Up button without entering any information.
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify that an error message is shown.
      expect(find.text('Please fill in all fields'), findsOneWidget);
    });
  });
}
