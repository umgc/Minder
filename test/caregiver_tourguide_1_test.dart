import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/main.dart';

void main() {
  testWidgets('ConversationListTourScreen Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Minder'), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(3)); // There are three ElevatedButton widgets
    expect(find.byType(Container), findsNWidgets(6)); // There are six Container widgets
    expect(find.byType(IconButton), findsNWidgets(3)); // There are three IconButton widgets
    expect(find.byType(Text), findsNWidgets(7)); // There are seven Text widgets

    // Tap on the ElevatedButton with the record icon
    await tester.tap(find.byIcon(Icons.videocam));
    await tester.pump();

    // Verify that the tutorial coach mark appears
    expect(find.text('Tap to see details and play the conversation.'), findsOneWidget);

    // Tap on the ElevatedButton with the record text
    await tester.tap(find.text('Record'));
    await tester.pump();

    // Verify that the tutorial coach mark appears
    expect(find.text('Tap to start recording.'), findsOneWidget);
  });
}
