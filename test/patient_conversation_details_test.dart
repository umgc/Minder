import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:minder/Caregiver_Conversation/patient_conversation_details.dart';

void main() {
  testWidgets('ConversationDetailsScreen widget test', (WidgetTester tester) async {
    // Build our conversationDetailsScreen widget.
    await tester.pumpWidget(MaterialApp(
      home: conversationDetailsScreen(),
    ));

    // Verify that the app bar title is displayed.
    expect(find.text('Doctor Appointment'), findsOneWidget);

    // Verify that the 'Play' button is present.
    expect(find.text('Play'), findsOneWidget);

    // Tap the 'Delete' icon and verify if the confirmation dialog is shown.
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();
    expect(find.text('Are you sure you want to remove this conversation permanently?'), findsOneWidget);

    // Tap the 'OK' button in the confirmation dialog and verify if it's dismissed.
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.text('Are you sure you want to remove this conversation permanently?'), findsNothing);
  });
}
