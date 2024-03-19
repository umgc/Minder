import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/reminder_creation_screen.dart.dart';

void main() {
  testWidgets('Caregiver Reminder Creation Screen Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: CaregiverReminderCreationScreen(),
    ));

    // Verify that the initial UI contains the expected widgets.
    expect(find.text('Create a Reminder'), findsOneWidget);
    expect(find.text('Choose a Reminder Name'), findsOneWidget);
    expect(find.text('Type of Event'), findsOneWidget);
    expect(find.text('Date'), findsOneWidget);
    expect(find.text('Time'), findsOneWidget);
    expect(find.text('Upload a Video Analysis'), findsOneWidget);
    expect(find.text('Create Reminder'), findsOneWidget);

    // Tap the 'Create Reminder' button.
    await tester.tap(find.text('Create Reminder'));
    await tester.pump(); // Rebuild the widget after the tap.
  });
}
