import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/start_pause_and_stop_recording.dart';



void main() {
  testWidgets('RecordingScreen Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: RecordingScreen(),
    ));

    // Verify that the initial UI contains the expected widgets.
    expect(find.text('00:00'), findsOneWidget); // Check if timer starts at 00:00
    expect(find.byType(FloatingActionButton), findsNWidgets(2)); // Check if two FABs are present
    expect(find.byType(CameraPreview), findsOneWidget); // Check if CameraPreview widget is present

    // Tap the record button.
    await tester.tap(find.byType(FloatingActionButton).first);
    await tester.pump(); // Rebuild the widget after the tap.

    // Verify that the recording starts.
    expect(find.byIcon(Icons.stop), findsOneWidget); // Check if stop icon appears when recording starts

    // Wait for some time to simulate recording
    await Future.delayed(const Duration(seconds: 2));

    // Tap the stop button.
    await tester.tap(find.byIcon(Icons.stop));
    await tester.pump(); // Rebuild the widget after the tap.

    // Verify that the recording stops.
    expect(find.byType(FloatingActionButton), findsNWidgets(2)); // Check if two FABs appear after recording stops
    expect(find.byIcon(Icons.fiber_manual_record), findsOneWidget); // Check if record icon appears after recording stops
  });
}
