import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minder/widgets/transmogListItem.dart';

void main() {
  testWidgets('TransmogListItem widget test', (WidgetTester tester) async {
    // Define the variables needed for the TransmogListItem widget.
    final String title = 'Title';
    final IconData icon = Icons.ac_unit;
    final bool showHighlight = true;
    bool onTapCalled = false;

    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TransmogListItem(
          title: title,
          icon: icon,
          showHighlight: showHighlight,
          onTap: () {
            onTapCalled = true;
          },
        ),
      ),
    ));

    // Verify that the icon is displayed.
    expect(find.byIcon(icon), findsOneWidget);

    // Verify that the title is displayed.
    expect(find.text(title), findsOneWidget);

    // Verify that the onTap function is called when the button is pressed.
    await tester.tap(find.byType(TextButton));
    expect(onTapCalled, true);
  });
}
