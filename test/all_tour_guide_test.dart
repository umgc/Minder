import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/main.dart';

void main() {
  testWidgets('TourGuide widget test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the AppBar is displayed.
    expect(find.byType(AppBar), findsOneWidget);

    // Verify that the PageView is displayed.
    expect(find.byType(PageView), findsOneWidget);

    // Verify that the BottomNavigationBar is displayed.
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Tap on the first item in the BottomNavigationBar.
    await tester.tap(find.byIcon(Icons.circle)); // Replace 'Icons.circle' with the actual icon used in the BottomNavigationBar
    await tester.pumpAndSettle();

    // Verify that the PageView index changes to the first page.
    expect(find.text('First Image'), findsOneWidget);

    // Tap on the second item in the BottomNavigationBar.
    await tester.tap(find.byIcon(Icons.circle)); // Replace 'Icons.circle' with the actual icon used in the BottomNavigationBar
    await tester.pumpAndSettle();

    // Verify that the PageView index changes to the second page.
    expect(find.text('Second Image'), findsOneWidget);

    // Tap on the third item in the BottomNavigationBar.
    await tester.tap(find.byIcon(Icons.circle)); // Replace 'Icons.circle' with the actual icon used in the BottomNavigationBar
    await tester.pumpAndSettle();

    // Verify that the PageView index changes to the third page.
    expect(find.text('Third Image'), findsOneWidget);
  });
}
