import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Views/Caregiver_Screens/caregiver_signup.dart';

void main() {
  testWidgets('SignUpScreen Widget Test', (WidgetTester tester) async {
    // Build the SignUpScreen widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: SignUpScreen()));

    // Verify that the sign-up page is rendered with the expected elements.
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Enter Your Full Name'), findsOneWidget);
    expect(find.text('Enter Your Relationship'), findsOneWidget);
    expect(find.text('Enter Your Email'), findsOneWidget);
    expect(find.text('Create a Password'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });
}
