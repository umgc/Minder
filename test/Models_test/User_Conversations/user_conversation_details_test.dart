import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Models/User_Conversations/user_conversation_list.dart';
import 'package:minder/Models/User_Conversations/user_conversation_details.dart';

void main() {
  // Sample conversation for testing
  final Conversation sampleConversation = Conversation(
    id: '1',
    convName: 'Test Conversation',
    summary: 'Sample summary',
    fileLocation: 'path/to/file',
    type: 'video',
    date: '2024-04-01',
    notes: 'Sample notes',
    rem: 'Sample reminder',
    saved: 1,
  );

  // Test 1: Verifying the presence of UI elements
  testWidgets('UI elements are present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: conversationDetailsScreen(conversation: sampleConversation)));

    // Verify the AppBar title
    expect(find.text('Test Conversation'), findsOneWidget);

    // Verify the presence of buttons
    expect(find.text('Full Conversation'), findsOneWidget);
    expect(find.text('Summary'), findsOneWidget);
    expect(find.text('Reminder'), findsOneWidget);
    expect(find.text('Note'), findsOneWidget);

    // Verify the presence of the play button
    expect(find.text('Play'), findsOneWidget);
  });

  // Test 2: Interaction Test - Tapping the "Note" button
  testWidgets('Tapping the "Note" button shows notes',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: conversationDetailsScreen(conversation: sampleConversation)));

    // Tap on the 'Note' button
    await tester.tap(find.text('Note'));
    await tester.pump();

    // Verify that the notes are displayed
    expect(find.text('Sample notes'), findsOneWidget);
  });

  // Test 3: Interaction Test - Tapping the "Delete" icon
  testWidgets('Tapping the "Delete" icon shows confirmation dialog',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: conversationDetailsScreen(conversation: sampleConversation)));

    // Tap on the 'Delete' icon
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump(); // Rebuild the widget to show the dialog

    // Verify that the confirmation dialog is displayed
    expect(
        find.text(
            'Are you sure you want to remove this conversation permanently?'),
        findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  // Additional tests can be added here to cover more scenarios, such as verifying the playback functionality
  // and checking the addition of new notes.
}
