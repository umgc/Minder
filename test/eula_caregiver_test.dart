import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Caregiver_Login/caregiver_login.dart'; 
import 'package:minder/Welcome_screen/welcome.dart';
import 'package:minder/end_user_license_agreement.dart';

void main() {
  testWidgets('CaregiverEulaScreen UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const ReminderApp());

    // Verify that the 'Minder' text is displayed
    expect(find.text('Minder'), findsOneWidget);

    // Verify that the 'Agree' button is displayed
    expect(find.text('Agree'), findsOneWidget);

    // Verify that the 'Disagree' button is displayed
    expect(find.text('Disagree'), findsOneWidget);

    // Tap on the 'Agree' button
    await tester.tap(find.text('Agree'));
    await tester.pumpAndSettle();

    // Verify that tapping on the 'Agree' button navigates to the caregiver login screen
    expect(find.byType(LoginPage), findsOneWidget);

    // Tap on the 'Disagree' button
    await tester.tap(find.text('Disagree'));
    await tester.pumpAndSettle();

    // Verify that tapping on the 'Disagree' button navigates to the splash screen
    expect(find.text(SplashScreen as String), findsOneWidget);
  });
}
