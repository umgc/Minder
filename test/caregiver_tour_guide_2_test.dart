import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/main.dart';

void main() {
  testWidgets('conversationDetailsTourScreen Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(IconButton), findsNWidgets(2)); // There are two IconButton widgets
    expect(find.text('Doctor Appointment'), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Container), findsNWidgets(2)); // There are two Container widgets
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Expanded), findsNWidgets(4)); // There are four Expanded widgets
    expect(find.byType(Card), findsNWidgets(4)); // There are four Card widgets
    expect(find.byType(TextButton), findsNWidgets(2)); // There are two TextButton widgets
    expect(find.byType(Text), findsNWidgets(5)); // There are five Text widgets
    expect(find.byType(ElevatedButton), findsOneWidget); // There is one ElevatedButton widget

    // Tap on the back button
    await tester.tap(find.byKey(Key('keyButton')));
    await tester.pump();

    // Verify that the tutorial coach mark appears
    expect(find.text('Tap to go back.'), findsOneWidget);

    // Tap on the delete button
    await tester.tap(find.byKey(Key('keyButton1')));
    await tester.pump();

    // Verify that the delete confirmation dialog appears
    expect(find.text('Tap to delete this conversation'), findsOneWidget);

    // Tap on the 'Full Conversation' tile button
    await tester.tap(find.byType(IconButton).first);
    await tester.pump();

    // Verify that the tutorial coach mark appears
    expect(find.text('Select a transmogrifier to extract useful information from this conversation.'), findsOneWidget);
  });
}
