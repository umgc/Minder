import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Caregiver_Conversation/patient_conversation_list.dart';
import 'package:minder/patient_login.dart';

void main() {
  testWidgets('Patient Login Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: patient_login(),
    ));

    // Verify that the initial UI contains the expected widgets.
    expect(find.text('Welcome back!'), findsOneWidget);
    expect(find.text('We\'re glad to see you again'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);

    // Tap the 'Log in' button.
    await tester.tap(find.text('Log in'));
    await tester.pump(); // Rebuild the widget after the tap.

    // Verify that the navigation occurred to ConversationListScreen.
    expect(find.byType(ConversationListScreen), findsOneWidget);
  });
}
