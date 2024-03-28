//Contributors 
  // UI Developed by Lensa Gemeda
  // Development contribution by Gabriel Moreno

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minder/Views/Caregiver_Screens/care_giver_setting.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: conversationDetailsTourScreen(),
    );
  }
}

class conversationDetailsTourScreen extends StatefulWidget {
  const conversationDetailsTourScreen({Key? key}) : super(key: key);

  @override
  ConversationListScreenState createState() => ConversationListScreenState();
}
class ConversationListScreenState extends State<conversationDetailsTourScreen> {
   late TutorialCoachMark tutorialCoachMark;
  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
   @override
  void initState() {
    createTutorial();
    Future.delayed(Duration.zero, showTutorial);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: keyButton,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: Text('Doctor Appointment'),
        actions: [
          IconButton(
            key: keyButton1,
            icon: Icon(Icons.delete),
            onPressed: () {
             showDeleteConfirmationDialog(context);
            },
          ),
        ],
        elevation: 8, // Add shadow to the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color.fromARGB(255, 190, 190, 190)),
              ),
              padding: EdgeInsets.all(8),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('01/19/2024 10:45 AM', style: TextStyle(fontSize: 10)),
                  Text('Duration: 00:35', style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
            SizedBox(height: 12),
           Row(
            key: keyButton2,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    
    buildTileButton('Full Conversation', Icons.message, Colors.white, const Color.fromRGBO(47, 102, 127, 1), fontSize: 10),
     buildTileButton('Summary', Icons.notifications, Colors.black, Colors.white, fontSize: 10),
    buildTileButton('Reminder', Icons.notifications, Colors.black, Colors.white, fontSize: 10),
    buildTileButton('Note', Icons.note, Colors.black, Colors.white, fontSize: 10),
  ],
),
            SizedBox(height: 16),
            const Text(
              'Patient: "some questions"\nDoctor: "some response"',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle play button press
                },
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.all(16),
                  backgroundColor: Color.fromRGBO(47, 102, 127, 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Play', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.red,
      textSkip: "SKIP",
      paddingFocus: 5,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        Navigator.push(
              context ,
              MaterialPageRoute(builder: (context) => const   Settings()),
            );
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("target: $target");
        print(
            "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onSkip: () {
        print("skip");
        Navigator.push(
              context ,
              MaterialPageRoute(builder: (context) => const   Settings()),
            );
        return true;
      },
    );
  }

  Widget buildTileButton(String text, IconData icon, Color iconColor, Color backgroundColor, {double fontSize = 12.0}) {
  return Expanded(
    
    child: Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 24),
            SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(fontSize: fontSize, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
 Future<void> showDeleteConfirmationDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        content: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(151, 228, 241, 1),
                    ),
                    child: Center(
                      child: Text(
                        '?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    child: Text(
                      'Are you sure you want to remove this conversation permanently?',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle delete button press
              Navigator.of(context).pop();
              // Add your delete logic here
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: Text(
              'OK',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle cancel button press
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}
List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "keyButton",
        keyTarget: keyButton,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Tap to go back.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
        
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyButton1",
        keyTarget: keyButton1,
        alignSkip: Alignment.topLeft,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Tap to delete this conversation",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );   
        targets.add(
      TargetFocus(
        identify: "keyButton2",
        keyTarget: keyButton2,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Select a transmogrifier to extract useful infromation from this conversation.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    ); 
    return targets;
  }

}