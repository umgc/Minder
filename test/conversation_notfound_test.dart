import 'package:flutter_test/flutter_test.dart';
import 'package:minder/conversation_notfound.dart';

void main() {
  testWidgets('ReminderApp UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const ReminderApp());

    // Verify that the 'Minder' text is displayed
    expect(find.text('Minder'), findsOneWidget);

    // Verify that the 'Conversations' text is displayed
    expect(find.text('Conversations'), findsOneWidget);

    // Verify that the 'View all' text is displayed
    expect(find.text('View all'), findsOneWidget);

    // Verify that the 'Meeting with Professor' text is displayed
    expect(find.text('Meeting with Professor'), findsOneWidget);

    // Verify that the 'No Conversations Found' text is displayed
    expect(find.text('No Conversations Found'), findsOneWidget);

    // Verify that the 'Record' button is displayed
    expect(find.text('Record'), findsOneWidget);
  });

  testWidgets('Record Button Tap Test', (WidgetTester tester) async {
    await tester.pumpWidget(const ReminderApp());

    // Tap on the 'Record' button
    await tester.tap(find.text('Record'));
    await tester.pump();
  });
}
