import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Views/Caregiver_Screens/care_giver_setting.dart';

void main() {
  testWidgets('Settings Page Render Test', (WidgetTester tester) async {
    // Build the Settings screen widget
    await tester.pumpWidget(const MaterialApp(home: Settings()));

    // Verify that the Settings screen is rendered
    expect(find.byType(Settings), findsOneWidget);
  });
}
