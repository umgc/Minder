//Contributors 
  // UI Developed by Lensa Gemeda
  // Development contribution by Gabriel Moreno
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minder/Views/Tour/caregiver_tour_guide_2.dart';


import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConversationListTourScreen(),
    );
  }
}

class ConversationListTourScreen extends StatefulWidget {
    const ConversationListTourScreen({Key? key}) : super(key: key);

  @override
  ConversationListScreenState createState() => ConversationListScreenState();
}
class ConversationListScreenState extends State<ConversationListTourScreen> {
   late TutorialCoachMark tutorialCoachMark;

  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton1 = GlobalKey();

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
        backgroundColor: Colors.white,
        title: Text(
          'Minder',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                hintText: 'Search conversation',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(106, 245, 245, 245)),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          
          SizedBox(height: 20),
          buildNewSection('Conversation draft'),
          
          
          buildSectionDraft('Conversations', 'View All'),
          SizedBox(height: 20),
          buildConversationBox('Doctor Appointment', Colors.black, 'Aug 28', const Color.fromARGB(255, 168, 216, 255), true, keyButton ),
          buildConversationBox('Salon Appointment', Colors.black, 'Aug 28', const Color.fromARGB(255, 168, 216, 255), false, keyButton),
          buildConversationBox('Breakfast with John', const Color.fromARGB(255, 10, 10, 10), 'Aug 28', const Color.fromARGB(255, 168, 216, 255), false, keyButton),
          Spacer(),
          // ElevatedButton(
            
          //   onPressed: () {
          //     // Handle record button press
          //   },
          //   style: ElevatedButton.styleFrom(
          //     padding: EdgeInsets.all(16),
          //     backgroundColor: Color.fromRGBO(47, 102, 127, 1),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Icon(Icons.videocam, color: Colors.white),
          //       SizedBox(width: 8),
          //       Text(
          //         'Record',
          //         key: keyButton1,
          //         style: TextStyle(fontSize: 18, color: Colors.white),
          //       ),
          //     ],
          //   ),
          // ),
          Row(
            key: keyButton1,
          children: [
            Expanded(
              child:
            ElevatedButton(
              onPressed: () {
                // Handle record button press
              //  Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => CameraPage(),
              //        ),
              //   );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                backgroundColor: Color.fromRGBO(47, 102, 127, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.videocam, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Video',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            ),
            Expanded(child: 
            ElevatedButton(
              onPressed: () {
                //  Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => AudioRecorderScreen(),
                //      ),
                // );
               
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                backgroundColor: Color.fromRGBO(47, 102, 127, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.mic, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Voice',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            ),
          ],
        ),
        ],
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
              MaterialPageRoute(builder: (context) => const   conversationDetailsTourScreen()),
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
              MaterialPageRoute(builder: (context) => const   conversationDetailsTourScreen()),
            );
        return true;
      },
    );
  }
   

  Widget buildSectionDraft(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle View All button press
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: Text(
              viewAllText,
              style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 141, 141, 141)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNewSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          buildNewBox(),
        ],
      ),
    );
  }

  Widget buildNewBox() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 212, 212, 212).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    IconButton(
      icon: Icon(Icons.videocam, color: const Color.fromARGB(255, 0, 0, 0)),
      onPressed: () {
        // Handle close button press
      },
    ),
    SizedBox(width: 10), // Adjust the width as needed
    Text(
      "Grocery",
      style: TextStyle(fontSize: 18),
      overflow: TextOverflow.ellipsis, 
    ),
    IconButton(
          icon: Icon(Icons.edit, color: Colors.blue), onPressed: () {  },),
    SizedBox(width: 10), // Adjust the width as needed
    Row(
      children: [
        
        IconButton(
          icon: Icon(Icons.close, color: const Color.fromARGB(255, 0, 0, 0)),
          onPressed: () {
            // Handle close button press
          },
        ),
        IconButton(
          icon: Icon(Icons.check, color: Colors.green),
          onPressed: () {
            // Handle check button press
            },
          ),
        ],
      ),
    ],
  ),
      );
    }

  Widget buildConversationBox(String conversationName, Color videoIconColor, String date, Color buttonColor, bool keybool ,GlobalKey<State<StatefulWidget>>  key1) {
    if(keybool){
      return Container(
         key: key1,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 204, 204, 204).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.videocam, color: videoIconColor),
          Text(
            conversationName,
            style: TextStyle(fontSize: 18),
          ),
          ElevatedButton(
           
            onPressed: () {
              // Handle View All functionality
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                date,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
    }
    else {
      return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 204, 204, 204).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.videocam, color: videoIconColor),
          Text(
            conversationName,
            style: TextStyle(fontSize: 18),
          ),
          ElevatedButton(
            
            onPressed: () {
              // Handle View All functionality
              print("button pressed");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                date,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
    }
    
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
            align: ContentAlign.top,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Tap to see details and play the conversation.",
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

    targets.add(
      TargetFocus(
        identify: "keyButton1",
        keyTarget: keyButton1,
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
                    "Tap to start recording.",
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
    return targets;
  }
}