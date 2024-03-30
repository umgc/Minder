import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Views/Caregiver_Screens/caregiver_user_account_creation.dart';

void main() {
  testWidgets('UserRegistrationScreen Widget Test',
      (WidgetTester tester) async {
    // Build the UserRegistrationScreen widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: UserRegistrationScreen()));

    // Verify that the registration screen is rendered with the correct UI elements.
    expect(find.text('Register the User'), findsOneWidget);
    expect(find.text("User's First Name"), findsOneWidget);
    expect(find.text("User's Last Name"), findsOneWidget);
    expect(find.text('Register User'), findsOneWidget);

    // Enter some text into the text fields.
    await tester.enterText(find.byType(TextField).at(0), 'John');
    await tester.enterText(find.byType(TextField).at(1), 'Doe');

    // Tap the 'Register User' button.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // Wait for any animations to complete.

    // Check if the text fields are cleared after registration.
    expect(find.text('John'), findsNothing);
    expect(find.text('Doe'), findsNothing);
  });
}
