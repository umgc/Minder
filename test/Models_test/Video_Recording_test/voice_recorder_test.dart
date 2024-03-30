import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Models/Video_Recording/voice_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  // Test 1: Verifying the presence of UI elements
  testWidgets('UI elements are present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AudioRecorderScreen()));

    // Verify the presence of the record button
    expect(find.byIcon(Icons.mic), findsOneWidget);

    // Verify the presence of the image
    expect(find.byType(Image), findsOneWidget);

    // Verify the presence of the text instruction
    expect(find.text('Tap on mic and start recording'), findsOneWidget);
  });

  // Test 2: Interaction Test - Tapping the record button starts recording
  testWidgets('Tapping the record button starts recording',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AudioRecorderScreen()));
    await tester.pumpAndSettle(); // Wait for any initial animations

    // Simulate granting microphone permission
    await tester.runAsync(() async {
      final service = Permission.microphone;
      await service.request();
    });

    // Tap on the record button
    await tester.tap(find.byIcon(Icons.mic));
    await tester.pumpAndSettle();

    // Verify that the recording has started
    // Note: Since the actual recording logic involves hardware interaction, you might not be able to fully test this in a widget test.
    // You can check for visual changes or state updates that indicate recording has started.
    // For example, if your UI shows a red circle when recording, you can test for that change.
    expect(find.byIcon(Icons.stop), findsOneWidget);
  });

  // Additional tests can be added here to cover more scenarios, such as verifying that tapping the button again stops the recording,
  // and checking that the recording is saved to the specified file path.
}
