import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Models/Reminder/caregiver_reminder_creation.dart';
import 'package:minder/Models/Reminder/update_reminder.dart';
import 'package:minder/Views/Caregiver_Screens/care_giver_setting.dart';

void main() {
  // Sample reminder to use for testing
  final Reminder sampleReminder = Reminder(
    id: 1,
    eventType: 'Health',
    description: 'Doctor\'s appointment',
    date: '2024-04-01',
    time: '08:00 AM',
  );

  // Test 1: Verifying the presence of UI elements and initial values
  testWidgets('UI elements are present and show initial reminder values',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: UpdateReminderFormScreen(reminder: sampleReminder)));

    // Verify the AppBar title
    expect(find.text('Update Reminder'), findsOneWidget);

    // Verify initial values in fields
    expect(find.widgetWithText(DropdownButtonFormField<String>, 'Health'),
        findsOneWidget);
    expect(find.widgetWithText(TextFormField, '2024-04-01'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, '08:00 AM'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Doctor\'s appointment'),
        findsOneWidget);
  });

  // Test 2: Interaction Test - Updating a reminder
  testWidgets('Updating a reminder', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: UpdateReminderFormScreen(reminder: sampleReminder)));

    // Update the description
    await tester.enterText(
        find.byType(TextFormField).last, 'Updated description');
    await tester.tap(find.text('Update Reminder'));
    await tester.pumpAndSettle();

    // Verify that the update function was called and the screen navigated away (to the Settings screen in this case)
    expect(find.byType(Settings), findsOneWidget);
  });

  // Test 3: Interaction Test - Deleting a reminder
  testWidgets('Deleting a reminder', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: UpdateReminderFormScreen(reminder: sampleReminder)));

    // Tap the delete icon in the AppBar
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump(); // Rebuild the widget with the dialog

    // Confirm deletion in the dialog
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    // Verify that the screen navigated away (to the Settings screen in this case)
    expect(find.byType(Settings), findsOneWidget);
  });

  // Additional tests can be added here to cover more scenarios
}
