import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Views/User_Screens/end_user_license_agreement_patient.dart';

void main() {
  testWidgets('CaregiverEulaScreen1 Renders Without Errors', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(
      home: CaregiverEulaScreen1(),
    ));

    // Verify that the CaregiverEulaScreen1 is rendered without errors
    expect(find.byType(CaregiverEulaScreen1), findsOneWidget);

    // Verify that the text "Minder" is present
    expect(find.text('Minder'), findsOneWidget);

    // You can add more tests to verify other text or widgets on the screen
  });
}
