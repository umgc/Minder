import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Caregiver_Login/caregiver_login.dart';
import 'package:mockito/mockito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class MockAmplifyAuthCognito extends Mock implements AmplifyAuthCognito {}

void main() {
  group('LoginPage tests', () {
    late MockAmplifyAuthCognito mockAuth;

    setUp(() {
      mockAuth = MockAmplifyAuthCognito();
      Amplify.addPlugin(mockAuth);
    });

    testWidgets('LoginPage displays correct widgets',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      // Verify that LoginPage has the correct widgets.
      expect(find.text('Login Page'), findsOneWidget);
      expect(find.text('Welcome Back!'), findsOneWidget);
      expect(find.byKey(Key('usernameField')), findsOneWidget);
      expect(find.byKey(Key('passwordField')), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('New here? Create an account.'), findsOneWidget);
    });

    testWidgets('Login button calls Amplify Auth signIn',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      // Enter username and password.
      await tester.enterText(find.byKey(Key('usernameField')), 'testuser');
      await tester.enterText(find.byKey(Key('passwordField')), 'password');

      // Tap the 'Login' button.
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Verify that Amplify Auth signIn was called.
      verify(mockAuth.signIn(username: 'testuser', password: 'password'))
          .called(1);
    });
  });
}
