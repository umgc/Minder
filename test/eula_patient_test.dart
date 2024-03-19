import 'package:flutter_test/flutter_test.dart';
import 'package:minder/end_user_license_agreement_patient.dart';
import 'package:minder/patient_login.dart';

void main() {
  testWidgets('CaregiverEulaScreen1 UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const ReminderApp1());

    // Verify that the 'Minder' text is displayed
    expect(find.text('Minder'), findsOneWidget);

    // Verify that the 'Agree' button is displayed
    expect(find.text('Agree'), findsOneWidget);

    // Verify that the 'Disagree' button is displayed
    expect(find.text('Disagree'), findsOneWidget);

    // Tap on the 'Agree' button
    await tester.tap(find.text('Agree'));
    await tester.pumpAndSettle();

    // Verify that tapping on the 'Agree' button navigates to the patient login screen
    expect(find.byType(patient_login), findsOneWidget);

    // Tap on the 'Disagree' button
    await tester.tap(find.text('Disagree'));
    await tester.pumpAndSettle();

    // Verify that tapping on the 'Disagree' button navigates to the splash screen
    expect(find.text('Splash Screen'), findsOneWidget);
  });
}
