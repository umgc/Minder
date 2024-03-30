import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:minder/Views/Caregiver_Screens/password_reset.dart';

// Create a mock class for Amplify.Auth
class MockAmplifyAuth extends Mock implements AuthCategory {}

void main() {
  testWidgets('PasswordResetPage displays and interacts as expected',
      (WidgetTester tester) async {
    // Act: Render the PasswordResetPage widget
    await tester.pumpWidget(MaterialApp(home: PasswordResetPage()));

    // Assert: Verify the UI elements are present
    expect(find.text('Password Reset'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Reset Password'), findsOneWidget);

    // Act: Enter email and initiate password reset
    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.tap(find.text('Reset Password'));
    await tester.pumpAndSettle();

    // Assert: Verify the confirmation code and new password fields are displayed
    expect(find.text('Confirmation Code'), findsOneWidget);
    expect(find.text('New Password'), findsOneWidget);
    expect(find.text('Confirm New Password'), findsOneWidget);

    // Act: Enter confirmation code and new password, then confirm
    await tester.enterText(find.byType(TextField).at(1), '123456');
    await tester.enterText(find.byType(TextField).at(2), 'newPassword');
    await tester.tap(find.text('Confirm New Password'));
    await tester.pumpAndSettle();
  });
}
