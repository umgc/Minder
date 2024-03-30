import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Models/Reminder/caregiver_reminder_creation.dart';
import 'package:minder/Models/Reminder/caregiver_reminder.dart';

void main() {
  // Test 1: Verifying the presence of UI elements
  testWidgets('UI elements are present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RemindersScreen()));

    // Verify the AppBar title
    expect(find.text('Reminders'), findsOneWidget);

    // Verify the presence of sections
    expect(find.text("Today's Reminders"), findsOneWidget);
    expect(find.text("This Week's Reminders"), findsOneWidget);
    expect(find.text("Earlier Reminders"), findsOneWidget);

    // Verify the presence of the floating action button
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  // Test 2: Interaction Test - Tapping the floating action button
  testWidgets('Tapping floating action button navigates to ReminderFormScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RemindersScreen()));

    // Tap on the floating action button
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle(); // Wait for navigation animation to finish

    // Verify that the navigation to ReminderFormScreen occurred
    expect(find.byType(ReminderFormScreen), findsOneWidget);
  });

  // Additional tests can be added here, such as verifying the grouping of reminders by event type,
  // and verifying the interaction with each reminder (e.g., tapping a reminder navigates to the UpdateReminderFormScreen).
}
