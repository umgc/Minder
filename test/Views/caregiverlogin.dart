import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 
 
import 'package:minder/main.dart';

void main() {
  testWidgets('LoginPage Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the login page is rendered.
    expect(find.text('Login Page'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Remember me'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('Don\'t have an account? Sign Up'), findsOneWidget);

    // Simulate entering a username and password.
    await tester.enterText(find.byType(TextField).first, 'testuser');
    await tester.enterText(find.byType(TextField).last, 'testpassword');

    // Tap on the login button.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify navigation to the Settings page after successful login.
    expect(find.text('Settings'), findsOneWidget);

    // Tap on the "Forgot Password?" button.
    await tester.tap(find.text('Forgot Password?'));
    await tester.pumpAndSettle();

    // Verify navigation to the PasswordResetPage.
    expect(find.text('Password Reset Page'), findsOneWidget);
  });
}
