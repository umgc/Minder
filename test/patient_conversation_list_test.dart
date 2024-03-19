import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Caregiver_Conversation/patient_conversation_list.dart';
import 'package:minder/start_pause_and_stop_recording.dart';

void main() {
  testWidgets('ConversationListScreen widget test', (WidgetTester tester) async {
    // Build our ConversationListScreen widget.
    await tester.pumpWidget(MaterialApp(
      home: ConversationListScreen(),
    ));

    // Verify that the app bar title is displayed correctly.
    expect(find.text('Minder'), findsOneWidget);

    // Verify that the 'Record' button is present.
    expect(find.text('Record'), findsOneWidget);

    // Tap the 'Record' button and verify if the RecordingScreen is pushed.
    await tester.tap(find.text('Record'));
    await tester.pumpAndSettle();
    expect(find.byType(RecordingScreen), findsOneWidget);

    // Tap the back button in the app bar and verify if the confirmation dialog is shown.
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('You will be signed out'), findsOneWidget);

    // Tap the 'OK' button in the confirmation dialog and verify if the ConversationListScreen is popped.
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.byType(ConversationListScreen), findsNothing);
  });
}
