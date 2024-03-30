import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:minder/Models/Reminder/caregiver_reminder_creation.dart';


void main() {
  // Test 1: Verifying UI elements are present
  testWidgets('UI elements are present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ReminderFormScreen()));

    // Verify the AppBar title
    expect(find.text('Create a Reminder'), findsOneWidget);

    // Verify the button is present
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.text('Create Reminder'), findsOneWidget);
  });

  // Test 2: Interaction Test - Tapping the "Create Reminder" button
  testWidgets('Tapping create button triggers action', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ReminderFormScreen()));

    // Tap on the 'Create Reminder' button
    await tester.tap(find.byKey(Key('createReminderButton')));
    await tester.pump();

    // This test is limited to verifying the tap action.
    // Normally, you'd verify the result of the action (e.g., a function call, state update, or navigation).
  });

  // Test 3: Accessibility Test - Button is accessible
  testWidgets('Button is accessible', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ReminderFormScreen()));

    // Check that the button has a semantic label
    expect(find.bySemanticsLabel('Create Reminder'), findsOneWidget);
  });
}
