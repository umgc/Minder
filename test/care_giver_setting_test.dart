import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/Reminder/caregiver_reminderscreen.dart';
import 'package:minder/Tour/caregiver_tour_guide_1.dart';
import 'package:minder/care_giver_setting.dart';
import 'package:minder/Welcome_screen/welcome.dart';
import 'package:minder/care_giver_support-screen.dart';

void main() {
  testWidgets('Settings screen UI Test', (WidgetTester tester) async {
    // Build the settings screen
    await tester.pumpWidget(const Settings());

    // Verify that the profile information box is displayed
    expect(find.text('Profile Information'), findsOneWidget);
    expect(find.text('Edit profile details'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Verify that the reminders, guided tour, and support center boxes are displayed
    expect(find.text('Reminders'), findsOneWidget);
    expect(find.text('Guided Tour'), findsOneWidget);
    expect(find.text('Support Center'), findsOneWidget);

    // Tap on the reminders list tile and verify navigation
    await tester.tap(find.text('Reminders'));
    await tester.pumpAndSettle();
    expect(find.byType(RemindersScreen), findsOneWidget);

    // Tap on the guided tour list tile and verify navigation
    await tester.tap(find.text('Guided Tour'));
    await tester.pumpAndSettle();
    expect(find.byType(ConversationListTourScreen), findsOneWidget);

    // Tap on the support center list tile and verify navigation
    await tester.tap(find.text('Support Center'));
    await tester.pumpAndSettle();
    expect(find.byType(CaregiverSupport), findsOneWidget);
  });

  testWidgets('Sign Out Button Test', (WidgetTester tester) async {
    // Build the settings screen
    await tester.pumpWidget(const Settings());

    // Tap on the sign out button
    await tester.tap(find.text('Sign Out'));
    await tester.pumpAndSettle();

    // Verify that the splash screen is displayed after signing out
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
