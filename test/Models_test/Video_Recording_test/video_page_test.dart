import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Models/User_Conversations/user_conversation_list.dart';
import 'package:minder/Models/Video_Recording/video_page.dart';
import 'package:video_player/video_player.dart';

void main() {
  // Test 1: Verifying the presence of UI elements
  testWidgets('UI elements are present', (WidgetTester tester) async {
    // Assuming 'test_video.mp4' is a valid video file in your testing environment
    await tester
        .pumpWidget(MaterialApp(home: VideoPage(filePath: 'test_video.mp4')));

    // Verify the presence of the VideoPlayer
    expect(find.byType(VideoPlayer), findsOneWidget);

    // Verify the presence of the check icon button
    expect(find.byIcon(Icons.check), findsOneWidget);
  });

  // Test 2: Interaction Test - Tapping the check icon button
  testWidgets(
      'Tapping the check icon button pauses the video and navigates back',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: VideoPage(filePath: 'test_video.mp4')));
    await tester.pumpAndSettle(); // Wait for the video to initialize

    // Tap on the check icon button
    await tester.tap(find.byIcon(Icons.check));
    await tester.pumpAndSettle();

    // Verify that the video is paused
    final VideoPlayerController controller =
        tester.firstWidget(find.byType(VideoPlayer)) as VideoPlayerController;
    expect(controller.value.isPlaying, isFalse);

    // Verify that the navigation has occurred
    // Note: Since the actual navigation logic might depend on the app's routing setup, you might need to adjust this verification step accordingly.
    expect(find.byType(ConversationListScreen), findsOneWidget);
  });

  // Additional tests can be added here to cover more scenarios, such as verifying the video playback functionality
  // and checking the state changes of the video player.
}
