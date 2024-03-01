import 'package:flutter/material.dart';
import 'package:minder/Caregiver_Conversation/patient_conversation_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConversationListScreen(),
    );
  }
}

class ConversationListScreen extends StatelessWidget {
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            showDeleteConfirmationDialog(context);
            
          },
        ),
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
          SizedBox(height: 20),
          
          buildSectionDraft('Conversations', 'View All'),
          SizedBox(height: 20),
          buildConversationBox('Doctor Appointment', Colors.black, 'Aug 28', const Color.fromARGB(255, 168, 216, 255),context),
          buildConversationBox('Salon Appointment', Colors.black, 'Aug 28', const Color.fromARGB(255, 168, 216, 255),context),
          buildConversationBox('Breakfast with John', Colors.black, 'Aug 28', const Color.fromARGB(255, 168, 216, 255),context),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              // Handle record button press
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(25),
              backgroundColor: Color.fromRGBO(47, 102, 127, 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.videocam, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Record',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
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
      padding: EdgeInsets.all(20),
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
      "Buying grocery",
      style: TextStyle(fontSize: 18),
    ),
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

  Widget buildConversationBox(String conversationName, Color videoIconColor, String date, Color buttonColor, BuildContext context) {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  conversationDetailsScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
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
                      'You will be signed out',
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
              Navigator.pop(context);
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

