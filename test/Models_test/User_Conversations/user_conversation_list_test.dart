import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Models/User_Conversations/user_conversation_list.dart';
import 'package:minder/Models/Video_Recording/camera.dart';
import 'package:minder/Models/Video_Recording/voice_recorder.dart';

void main() {
  // Test 1: Verifying the presence of UI elements
  testWidgets('UI elements are present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ConversationListScreen()));

    // Verify the presence of the search bar
    expect(find.byType(TextFormField), findsOneWidget);

    // Verify the presence of the "Video" and "Voice" buttons
    expect(find.text('Video'), findsOneWidget);
    expect(find.text('Voice'), findsOneWidget);
  });

  // Test 2: Interaction Test - Searching for a conversation
  testWidgets('Searching for a conversation filters the list',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ConversationListScreen()));

    // Enter text into the search bar
    await tester.enterText(find.byType(TextFormField), 'Test');
    await tester.pumpAndSettle();

    // Verify that the conversation is displayed
    expect(find.text('Test Conversation'), findsOneWidget);
  });

  // Test 3: Interaction Test - Tapping the "Video" button
  testWidgets('Tapping the "Video" button navigates to the CameraPage',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ConversationListScreen()));

    // Tap on the 'Video' button
    await tester.tap(find.text('Video'));
    await tester.pumpAndSettle();

    // Verify that the CameraPage is displayed
    expect(find.byType(CameraPage), findsOneWidget);
  });

  // Test 4: Interaction Test - Tapping the "Voice" button
  testWidgets('Tapping the "Voice" button navigates to the AudioRecorderScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ConversationListScreen()));

    // Tap on the 'Voice' button
    await tester.tap(find.text('Voice'));
    await tester.pumpAndSettle();

    // Verify that the AudioRecorderScreen is displayed
    expect(find.byType(AudioRecorderScreen), findsOneWidget);
  });
}
