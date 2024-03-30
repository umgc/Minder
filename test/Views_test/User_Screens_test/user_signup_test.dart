import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:minder/Views/Caregiver_Screens/care_giver_setting.dart';
import 'package:minder/Views/User_Screens/user_signup.dart';
import 'package:mockito/mockito.dart';

void main() {
  testWidgets('SetupFaceIDScreen Widget Test', (WidgetTester tester) async {
    // Build the SetupFaceIDScreen and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: SetupFaceIDScreen()));

    // Verify that the screen contains the expected text.
    expect(find.text('Setup Biometrics'), findsOneWidget);
    expect(
        find.text('Secure your account by enabling biometric authentication.'),
        findsOneWidget);

    // Mock the LocalAuthentication class for testing purposes.
    final LocalAuthentication localAuth = LocalAuthentication();
    when(localAuth.canCheckBiometrics).thenAnswer((_) async => true);
    when(localAuth.getAvailableBiometrics())
        .thenAnswer((_) async => [BiometricType.face]);

    // Check if biometrics are set up.
    await tester.runAsync(() async {
      await tester
          .pump(); // Rebuild the widget after mocking the LocalAuthentication class.
      await tester.idle(); // Wait for the animation to finish.

      // Verify that the congratulations dialog is shown.
      expect(
          find.text(
              'Congratulations! Your device\'s biometric authentication is set up. You can now use it for faster and more secure access.'),
          findsOneWidget);

      // Tap the continue button.
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle(); // Wait for the new screen to be displayed.

      // Verify that the Settings screen is pushed onto the navigator stack.
      expect(find.byType(Settings), findsOneWidget);
    });
  });
}
