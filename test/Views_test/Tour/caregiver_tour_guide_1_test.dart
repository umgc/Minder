import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Views/Caregiver_Screens/caregiver_user_account_creation.dart';

void main() {
  testWidgets('UserRegistrationScreen Widget Test',
      (WidgetTester tester) async {
    // Build the UserRegistrationScreen and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: UserRegistrationScreen()));

    // Verify that the screen contains the expected text fields and button.
    expect(find.text("User's First Name"), findsOneWidget);
    expect(find.text("User's Last Name"), findsOneWidget);
    expect(find.text('Register User'), findsOneWidget);

    // Enter text into the text fields.
    await tester.enterText(
        find.widgetWithText(TextField, "User's First Name"), 'John');
    await tester.enterText(
        find.widgetWithText(TextField, "User's Last Name"), 'Doe');

    // Tap the 'Register User' button.
    await tester.tap(find.widgetWithText(ElevatedButton, 'Register User'));
    await tester.pump();

    // Verify that the button was tapped.
    // Additional verifications can be added based on the expected behavior.
  });
}
