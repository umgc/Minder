import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:minder/Reminder/caregiver_reminder_creation.dart';
import 'package:minder/Reminder/caregiver_reminderscreen.dart';

void main() {
  testWidgets('RemindersScreen widget test', (WidgetTester tester) async {
    // Build our RemindersScreen widget.
    await tester.pumpWidget(MaterialApp(
      home: RemindersScreen(),
    ));

    // Verify that the 'Reminders' title is present.
    expect(find.text("Reminders"), findsOneWidget);

    // Verify that the 'Create a Reminder' button is present.
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Tap the 'Create a Reminder' button and verify if it navigates to ReminderFormScreen.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.byType(ReminderFormScreen), findsOneWidget);

    // Verify that the 'Today's Reminders' section is present.
    expect(find.text("Today's Reminders"), findsOneWidget);
  });
}
