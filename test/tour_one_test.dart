import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/main.dart'; // Import the main.dart file

void main() {
  testWidgets('MyApp Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the initial UI contains the expected widgets.
    expect(find.byType(MaterialApp), findsOneWidget); // Check if MaterialApp widget is present
    expect(find.byType(Scaffold), findsOneWidget); // Check if Scaffold widget is present
    expect(find.byType(Center), findsOneWidget); // Check if Center widget is present
    expect(find.byType(Container), findsOneWidget); // Check if Container widget is present
    expect(find.byType(Stack), findsOneWidget); // Check if Stack widget is present
    expect(find.byType(Positioned), findsNWidgets(12)); // Check if 12 Positioned widgets are present
    expect(find.byType(Container), findsNWidgets(7)); // Check if 7 Container widgets are present
    expect(find.byType(Icon), findsOneWidget); // Check if Icon widget is present
    expect(find.byType(Text), findsNWidgets(7)); // Check if 7 Text widgets are present
    expect(find.byType(FlatButton), findsNothing); // Check if FlatButton widget is not present
    expect(find.byType(RaisedButton), findsNothing); // Check if RaisedButton widget is not present
    expect(find.byType(ElevatedButton), findsNothing); // Check if ElevatedButton widget is not present
    expect(find.byType(IconButton), findsNothing); // Check if IconButton widget is not present
  });
}

mixin RaisedButton {
}

mixin FlatButton {
}
