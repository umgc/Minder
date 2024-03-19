import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/care_giver_support-screen.dart';

void main() {
  testWidgets('CaregiverSupport UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const CaregiverSupport());

    // Verify that the app bar title is displayed
    expect(find.text('Caregiver Support'), findsOneWidget);

    // Verify that the back button is displayed
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Verify that the text widgets are displayed
    expect(find.text('Need assistance?'), findsOneWidget);
    expect(find.text('Tap below to'), findsOneWidget);
    expect(find.text('connect with our'), findsOneWidget);
    expect(find.text('support team.'), findsOneWidget);

    // Verify that the chat button is displayed
    expect(find.text('Chat'), findsOneWidget);
  });

  testWidgets('CaregiverSupport Chat Button Test', (WidgetTester tester) async {
    await tester.pumpWidget(const CaregiverSupport());

    // Tap on the chat button
    await tester.tap(find.text('Chat'));
    await tester.pump();

    // Verify that the chat button press is handled
    expect(find.text('Chat button pressed'), findsOneWidget);
  });

  testWidgets('CaregiverSupport Back Button Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CaregiverSupport()));

    // Tap on the back button
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify that Navigator.pop is called to navigate back
    expect(find.byType(CaregiverSupport), findsNothing);
  });
}
