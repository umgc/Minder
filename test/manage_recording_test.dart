import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/main.dart';

void main() {
  testWidgets('Recording Screen Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify initial state
    expect(find.text('00:00'), findsOneWidget);
    expect(find.byIcon(Icons.fiber_manual_record), findsOneWidget);
    expect(find.byIcon(Icons.stop), findsNothing);
    expect(find.byIcon(Icons.pause), findsNothing);

    // Tap record button
    await tester.tap(find.byIcon(Icons.fiber_manual_record));
    await tester.pump();

    // Verify recording started
    expect(find.text('00:00'), findsOneWidget);
    expect(find.byIcon(Icons.stop), findsOneWidget);
    expect(find.byIcon(Icons.pause), findsOneWidget);

    // Wait for 1 second (async operation)
    await tester.pump(const Duration(seconds: 1));

    // Verify elapsed time
    expect(find.text('00:01'), findsOneWidget);

    // Tap pause button
    await tester.tap(find.byIcon(Icons.pause));
    await tester.pump();

    // Verify recording paused
    expect(find.text('00:01'), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);

    // Tap pause button again to resume recording
    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pump();

    // Verify recording resumed
    expect(find.text('00:01'), findsOneWidget);
    expect(find.byIcon(Icons.pause), findsOneWidget);

    // Wait for 1 more second (async operation)
    await tester.pump(const Duration(seconds: 1));

    // Verify elapsed time after resuming recording
    expect(find.text('00:02'), findsOneWidget);

    // Tap stop button
    await tester.tap(find.byIcon(Icons.stop));
    await tester.pump();

    // Verify recording stopped
    expect(find.text('00:02'), findsOneWidget);
    expect(find.byIcon(Icons.fiber_manual_record), findsOneWidget);
    expect(find.byIcon(Icons.stop), findsNothing);
    expect(find.byIcon(Icons.pause), findsNothing);
  });
}