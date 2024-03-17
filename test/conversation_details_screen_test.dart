import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Caregiver_Conversation/patient_conversation_details.dart';

void main() {
  group('ConversationDetailsScreen tests', () {
    testWidgets('ConversationDetailsScreen displays correct information',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: ConversationDetailsScreen()));

      // Verify that our screen has the correct title and other information.
      expect(find.text('Doctor Appointment'), findsOneWidget);
      expect(find.text('01/19/2024 10:45 AM'), findsOneWidget);
      expect(find.text('Duration: 00:35'), findsOneWidget);
      expect(find.text('Patient: "some questions"\nDoctor: "some response"'),
          findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    });

    testWidgets('ConversationDetailsScreen has interactive buttons',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: ConversationDetailsScreen()));

      // Verify that buttons are present and can be interacted with.
      expect(find.byIcon(Icons.message), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
      expect(find.byIcon(Icons.note), findsOneWidget);

      // Tap the Note button and verify that a dialog is opened.
      await tester.tap(find.byIcon(Icons.note));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
    });
  });
}
