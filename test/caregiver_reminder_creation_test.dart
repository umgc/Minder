import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Reminder/caregiver_reminder_creation.dart';

void main() {
  testWidgets('ReminderFormScreen widget test', (WidgetTester tester) async {
    // Build our ReminderFormScreen widget.
    await tester.pumpWidget(MaterialApp(
      home: ReminderFormScreen(),
    ));

    // Verify that the 'Create a Reminder' button is present.
    expect(find.text('Create a Reminder'), findsOneWidget);

    // Tap the 'Create a Reminder' button and verify if the dialog appears.
    await tester.tap(find.text('Create a Reminder'));
    await tester.pumpAndSettle();
    expect(find.byType(Dialog), findsOneWidget);

    // Tap the 'OK' button in the dialog and verify if the ReminderFormScreen remains.
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.byType(ReminderFormScreen), findsOneWidget);
  });
}
