import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:minder/Models/User_Conversations/user_conversation_details.dart';
import 'package:minder/Models/Video_Recording/camera.dart';
import 'package:minder/Models/Video_Recording/voice_recorder.dart';


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

class ConversationListScreen extends StatefulWidget {
  @override
  _ConversationListScreenState createState() =>
      _ConversationListScreenState();
}

class _ConversationListScreenState extends State<ConversationListScreen> {
  Map<String, IconData> conversationTypeIcons = {
    'video': Icons.videocam,
    'audio': Icons.mic,
  };
  List<Conversation> conversations = [];
  List<Conversation> filteredConversations = [];
  TextEditingController searchController = TextEditingController();
  String convEditName = '';

  @override
  void initState() {
    super.initState();
    loadConversations();
  }

  Future<void> loadConversations() async {
    try {
      final directory =
          await path_provider.getApplicationDocumentsDirectory();
      final file = File('${directory.path}/recordings.json');
      if (file.existsSync()) {
        final jsonString = await file.readAsString();
        final jsonList = jsonDecode(jsonString) as List<dynamic>;
        setState(() {
          conversations =
              jsonList.map((e) => Conversation.fromJson(e)).toList();
          filteredConversations = List.from(conversations);
        });
      }
    } catch (e) {
      print('Error loading conversations: $e');
    }
  }

  Future<void> saveConversationsToJSON() async {
    final directory =
        await path_provider.getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/recordings.json';

    final jsonList =
        conversations.map((conversation) => conversation.toJson()).toList();
    await File(filePath).writeAsString(jsonEncode(jsonList));
  }

  void filterConversations(String query) {
    setState(() {
      filteredConversations = conversations
          .where((conversation) =>
              conversation.convName
                  .toLowerCase()
                  .contains(query.toLowerCase()) &&
              conversation.saved == 1)
          .toList();
    });
  }

  void deleteConversation(String id) async {
    final conversationIndex =
        conversations.indexWhere((conversation) => conversation.id == id);
    final filteredConversationIndex = filteredConversations
        .indexWhere((conversation) => conversation.id == id);

    if (conversationIndex == -1 || filteredConversationIndex == -1) {
      print('Conversation not found with ID: $id');
      return;
    }

    final directory =
        await path_provider.getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/recordings.json';
    final deletedRecording = conversations[conversationIndex];
    final file = File(deletedRecording.fileLocation);

    if (!file.existsSync()) {
      print('File does not exist: ${file.path}');
      return;
    }

    try {
      if (deletedRecording.saved != 1) {
        await file.delete();
      }

      conversations.removeAt(conversationIndex);
      filteredConversations.removeAt(filteredConversationIndex);
      saveConversationsToJSON();
      setState(() {});
    } catch (e) {
      print('Error deleting conversation: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Minder',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
         leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CameraPage()),
            );
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
              controller: searchController,
              onChanged: filterConversations,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                hintText: 'Search conversation',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(106, 245, 245, 245)),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          buildNewSection('Conversation draft'),
          buildSectionDraft('Conversations', 'View All'),
          SizedBox(height: 20),
          Expanded(
            child: filteredConversations.isEmpty
                ? Center(child: Text('No conversations found'))
                : ListView.builder(
                    itemCount: filteredConversations.length,
                    itemBuilder: (context, index) {
                      final conversation = filteredConversations[index];
                      if (conversation.saved == 1) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    conversationDetailsScreen(
                                        conversation: conversation),
                              ),
                            );
                          },
                          child: buildConversationBox(
                            conversation.convName, // Conversation name
                            conversation.type,     // Icon data
                            Colors.black,          // Icon color
                            conversation.date,     // Date
                            const Color.fromARGB(255, 168, 216, 255),  // Button color
),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CameraPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Color.fromRGBO(47, 102, 127, 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.videocam, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Video',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AudioRecorderScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Color.fromRGBO(47, 102, 127, 1),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.mic, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Voice',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget buildSectionDraft(String title, String filter) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        DropdownButton<String>(
          value: filter,
          onChanged: (String? newValue) {
            // Handle filter change
            if (newValue == 'Sort (Ascending)') {
              // Sort conversations in ascending order based on conversation.convName
              setState(() {
                filteredConversations.sort((a, b) => a.convName.compareTo(b.convName));
              });
            } else if (newValue == 'Sort (Descending)') {
              // Sort conversations in descending order based on conversation.convName
              setState(() {
                filteredConversations.sort((a, b) => b.convName.compareTo(a.convName));
              });
            } else if (newValue == 'Date (Newer First)') {
              // Sort conversations in descending order based on conversation.date
              setState(() {
                filteredConversations.sort((a, b) => b.date.compareTo(a.date));
              });
            } else if (newValue == 'Date (Older First)') {
              // Sort conversations in ascending order based on conversation.date
              setState(() {
                filteredConversations.sort((a, b) => a.date.compareTo(b.date));
              });
            }
          },
          items: <String>[
            'View All',
            'Sort (Ascending)',
            'Sort (Descending)',
            'Date (Newer First)',
            'Date (Older First)',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    ),
  );
}
Widget buildNewSection(String title) {
  final hasDraft = conversations.any((conversation) => conversation.saved == 0);
  if (!hasDraft) {
    return SizedBox();  
  }

  final draftConversations = filteredConversations.where((conversation) => conversation.saved == 0).toList();

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            draftConversations.length,
            (index) => buildNewBox(draftConversations[index], index),
          ),
        ),
      ],
    ),
  );
}

Widget buildNewBox(Conversation conversation, int index) {
  String editedName = conversation.convName.toString();

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 212, 212, 212).withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.videocam, color: Color.fromARGB(255, 0, 0, 0)),
          onPressed: () {
            // Handle close button press
          },
        ),
        const SizedBox(width: 7), // Adjust the width as needed
        Expanded(
          child: Text(
            editedName,
            style: TextStyle(fontSize: 18),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: Icon(Icons.edit, color: Colors.blue),
onPressed: () {
  editedName = conversation.convName;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Edit Conversation Name"),
        content: TextField(
          controller: TextEditingController(text: editedName),  // Initialize the text field with the current conversation name
          onChanged: (value) {
            print(value);
              if (value.isEmpty) {
                return; // Don't update state if the value is empty
              }
              setState(() {
                editedName = value;
              });

          },
          decoration: InputDecoration(hintText: "Enter new name"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog without saving
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                // Create a new Conversation object with the edited name
                Conversation updatedConversation = Conversation(
                  id: conversation.id,
                  convName: editedName,
                  summary: conversation.summary,
                  fileLocation: conversation.fileLocation,
                  type: conversation.type,
                  date: conversation.date,
                  notes: conversation.notes,
                  rem: conversation.rem,
                  saved: conversation.saved,
                );

                // Finding the index of the existing conversation
                int conversationIndex = conversations.indexOf(conversation);

                // replacing the existing conversation with the updated one
                conversations[conversationIndex] = updatedConversation;

                // Save the updated conversation list to JSON file
                saveConversationsToJSON();
              });
              Navigator.pop(context); 
              loadConversations();
            },
            child: Text("Save"),
          ),
        ],
      );
    },
  );
},

        ),
        const SizedBox(width: 7), 
       Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20), // Adds horizontal padding to the whole row
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distributes space evenly between and around the children
    children: [
      IconButton(
        icon: const Icon(Icons.close, color: Color.fromARGB(255, 0, 0, 0)),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Delete Conversation"),
                content: Text("Are you sure you want to delete this conversation?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      deleteConversation(conversation.id); // Call deleteConversation function with conversation ID
                      Navigator.pop(context);
                    },
                    child: Text("Delete"),
                  ),
                ],
              );
            },
          );
        },
      ),
      SizedBox(width: 7), // Maintains consistent spacing with the provided layout
      IconButton(
        icon: const Icon(Icons.check, color: Colors.green),
        onPressed: () {
          setState(() {
            conversation.saved = 1; // Change saved value to 1
          });
          saveConversationsToJSON(); // Save the updated conversation list to JSON file
        },
      ),
    ],
  ),
)

      ],
    ),
  );
}

   Widget buildConversationBox(String conversationName, String conversationType, Color iconColor, String date, Color buttonColor) {
  final formattedDate = DateFormat('MMM d').format(DateTime.parse(date));

   IconData iconData;
   

  // Set the icon based on the conversation type
  if (conversationType == 'video') {
    iconData = Icons.videocam;
  } else if (conversationType == 'audio') {
    iconData = Icons.mic;
  } else {
    // Default icon if conversation type is neither video nor audio
    iconData = Icons.mic;
  }

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 204, 204, 204).withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Custom microphone icon
        Icon(
          iconData,
          color: iconColor,
          size: 24, // Adjust icon size as needed
        ),
        Text(
          conversationName.length > 13 ? '${conversationName.substring(0, 13)}...' : conversationName,
          style: const TextStyle(fontSize: 18),
          overflow: TextOverflow.ellipsis,
        ),

        ElevatedButton(
          onPressed: () {
            // Add functionality here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              formattedDate,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
      ],
    ),
  );
}
}
class Conversation {
  final String id;
  final String convName; 
  final String summary;
  final String fileLocation;
  final String type;
  final String date;
   String notes;
  final String rem;
  int saved;
  Conversation({
    String? id,
    required this.convName,
    required this.summary,
    required this.fileLocation,
    required this.type,
    required this.notes,
    required this.date,
    required this.rem,
    this.saved = 0,
  }) : id = id ?? Uuid().v4();

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'].toString(), // Convert int to string using toString()
      convName: json['convName'] as String? ?? '', // Provide a default empty string if convName is null
      date: json['date'] as String? ?? '', // Provide a default empty string if date is null
      fileLocation: json['fileLocation'] as String? ?? '', 
      summary: json['summary'] as String? ?? '', 
      type: json['type'] as String? ?? '', 
      notes: json['notes'] as String? ?? '', 
      rem: json['rem'] as String? ?? '',
      saved: json['saved'] as int? ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'convName': convName,
      'summary': summary,
      'fileLocation': fileLocation,
      'type': type,
      'date': date,
      'notes': notes,
      'rem': rem,
      'saved': saved,
    };
  }
}