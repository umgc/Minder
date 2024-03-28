import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Views/Caregiver_Screens/care_giver_support-screen.dart';

void main() {
  testWidgets('Caregiver Support Page Render Test', (WidgetTester tester) async {
    // Build the CaregiverSupport screen widget
    await tester.pumpWidget(MaterialApp(home: CaregiverSupport()));

    // Verify that the CaregiverSupport screen is rendered
    expect(find.byType(CaregiverSupport), findsOneWidget);

    // Verify that the app bar title is rendered
    expect(find.text('Caregiver Support'), findsOneWidget);

    // Verify that the back button is rendered
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Verify that the support screen content is rendered
    expect(find.byType(CaregiverSupportScreen1), findsOneWidget);

    // Optionally, you can add more specific widget checks here
  });
}
