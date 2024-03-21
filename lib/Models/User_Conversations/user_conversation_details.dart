import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:minder/Models/User_Conversations/user_conversation_list.dart';

void main() async{

  runApp(MyApp());
}




class conversationDetailsScreen extends StatefulWidget {
  final Conversation conversation;
  
  conversationDetailsScreen({required this.conversation});
  @override
  _ConversationDetailsScreenState createState() => _ConversationDetailsScreenState();
}

class _ConversationDetailsScreenState extends State<conversationDetailsScreen> {
  String selectedButton = 'Full Conversation'; // Initial selected button
List<Conversation> conversationList = []; 


  //for whisper api

 
  String _fullconv = '';
  String _summary = '';
  String _reminder = '';
  String _notes ='';
  bool _isLoadingF = false;
  bool _isLoadingR = false;
  bool _isLoadingS = false;
 String API_URL = "https://api.openai.com/v1/audio/transcriptions";
  String _apiKey =' '; //replace the key
 List<Map<String, String>> _messages = [
    {
      "role": "system",
      "content": "You are a helpful assistant designed to output JSON."
    }
  ];

@override
void initState() {
  print('init called');
  super.initState();
  convertSpeechToText();
  conversationList.add(widget.conversation);
  print(widget.conversation.notes);
}

Future<void> convertSpeechToText() async {
  setState(() {
    _isLoadingF = true; // Indicate loading state
  });
var request = http.MultipartRequest('POST', Uri.parse(API_URL));
    request.headers['Authorization'] = 'Bearer $_apiKey';
    request.headers['Content-Type'] = 'multipart/form-data';

    var audioFile = await http.MultipartFile.fromPath('file', widget.conversation.fileLocation);
    request.files.add(audioFile);

    request.fields['timestamp_granularities[]'] = 'word';
    request.fields['model'] = 'whisper-1';
    request.fields['response_format'] = 'verbose_json';

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.transform(utf8.decoder).join();
      // Process successful response (e.g., display results)
      print(responseBody);
      _fullconv = jsonDecode(responseBody)['text'];
      if(_fullconv!=null){
        sendMessage(_fullconv);
      }
      print(_fullconv);
      setState(() {
        _isLoadingF = false; // Update loading state even in case of error
      });
  
    } else {
      print('Error: ${response.reasonPhrase}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending request')),
      );
    }
}

 Future<void> sendMessage(String message) async {
  _isLoadingR = true;
  _isLoadingS = true;
    setState(() {
      _messages.add({"role": "user", "content": '"$message" Please provide the following :    Conversation_Summary:    Medication (if any):    Phone Number (if provided):    Reminder (if necessary; specify the event for the reminder, e.g., remind someone, meet someone, text or call someone, eat with someone, visit someone, make reservation, book tickets, read something):    Date & Time (if mentioned in the conversation):'});
      print(_messages);
    });

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode(<String, dynamic>{
        "model": "gpt-3.5-turbo-0125",
        "response_format": {"type": "json_object"},
        "messages": _messages,
        
      }),
    );

    if (response.statusCode == 200) {
      
      Map<String, dynamic> data = jsonDecode(response.body);
      //print(data['choices'][0]['message']['content'].runtimeType); //data['choices'][0]['message']['content'].indexOf('"')
      try{
       print(jsonDecode(data['choices'][0]['message']['content']));
       
       _summary = jsonDecode(data['choices'][0]['message']['content'])['Conversation_Summary'];
       _reminder = (jsonDecode(data['choices'][0]['message']['content'])['Reminder'] != null
    ? jsonDecode(data['choices'][0]['message']['content'])['Reminder'] + '\n'
    : '') +
    (jsonDecode(data['choices'][0]['message']['content'])['Medication'] != null
        ? jsonDecode(data['choices'][0]['message']['content'])['Medication']
        : '');
       _isLoadingS = false;
       _isLoadingR = false;
    

      
      }
      catch(e){
        print(e);
      }
      
    } else {
     print('Failed to send message: ${response.statusCode} - ${response.body}');
    }
  }


void updateJsonData() async {
  try {
    // Get the directory for the app's documents
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${appDocumentsDirectory.path}/recordings.json';

    // Check if the file exists
    bool fileExists = await File(filePath).exists();
    if (!fileExists) {
      // If the file does not exist, create it
      File(filePath).createSync(recursive: true);
    }

    // Read the existing JSON data from the file
    List<dynamic> jsonData = [];
    String jsonDataString = await File(filePath).readAsString();
    if (jsonDataString.isNotEmpty) {
      jsonData = json.decode(jsonDataString);
    }

    // Find the index of the conversation in the JSON data list
    int index = jsonData.indexWhere((conv) => conv['id'] == widget.conversation.id);

    // Check if the conversation exists in the JSON data
    if (index != -1) {
      // If the conversation exists, update the notes
      String existingNotes = jsonData[index]['notes'] ?? '';
      String newNotes = widget.conversation.notes;
      jsonData[index]['notes'] = existingNotes.isEmpty ? newNotes : '$existingNotes\n$newNotes';
    } else {
      // If the conversation does not exist, add it to the JSON data list
      jsonData.add(widget.conversation.toJson());
    }

    // Write the updated JSON data back to the file
    await File(filePath).writeAsString(json.encode(jsonData));
    print('JSON data updated successfully');
  } catch (e) {
    print('Error updating JSON data: $e');
  }
}

Future<void> deleteConversationEntry(String id) async {
  try {
    // Get the directory for the app's documents
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${appDocumentsDirectory.path}/recordings.json';

    // Check if the file exists
    bool fileExists = await File(filePath).exists();
    if (!fileExists) {
      print('JSON file does not exist.');
      return;
    }

    // Read the existing JSON data from the file
    List<dynamic> jsonData = [];
    String jsonDataString = await File(filePath).readAsString();
    if (jsonDataString.isNotEmpty) {
      jsonData = json.decode(jsonDataString);
    }

    // Find the index of the conversation in the JSON data list
    int index = jsonData.indexWhere((conv) => conv['id'] == id);

    // Check if the conversation exists in the JSON data
    if (index != -1) {
      // If the conversation exists, remove it from the JSON data list
      jsonData.removeAt(index);

      // Write the updated JSON data back to the file
      await File(filePath).writeAsString(json.encode(jsonData));
      print('Conversation with ID $id deleted successfully.');
    } else {
      print('Conversation with ID $id not found in JSON data.');
    }
  } catch (e) {
    print('Error deleting conversation entry: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConversationListScreen(),
              ),
            );
          },
        ),
        title:  Text(widget.conversation.convName),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
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
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.conversation.date, style: TextStyle(fontSize: 10)),
                  Text('Duration: 00:35', style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTileButton(
                  'Full Conversation',
                  Icons.message,
                  fontSize: 10,
                ),
                buildTileButton(
                  'Summary              ',
                  Icons.notifications,
                  fontSize: 10,
                ),
                buildTileButton(
                  'Reminder             ',
                  Icons.notifications,
                  fontSize: 10,
                ),
                buildTileButton(
                  'Note                         ',
                  Icons.note,
                  fontSize: 10,
                ),
              ],
            ),
            const SizedBox(height: 16),
            buildContentContainer(selectedButton),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.all(16),
                  backgroundColor: const Color.fromRGBO(47, 102, 127, 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.play_arrow, color: Colors.white),
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

  Widget buildTileButton(String text, IconData icon, {double fontSize = 12.0}) {
    bool isActive = selectedButton == text;
    Color backgroundColor = isActive ? const Color.fromRGBO(47, 102, 127, 1) : Colors.white;
    Color iconColor = isActive ? Colors.white : Colors.black;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Handle button click
          setState(() {
            selectedButton = text;
          });
        },
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
                const SizedBox(height: 8),
                Text(
                  text,
                  style: TextStyle(fontSize: fontSize, color: iconColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContentContainer(String selectedButton) {
    switch (selectedButton) {
      case 'Full Conversation':
        return Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(16),
          child: _isLoadingF
        ?  LinearProgressIndicator(
        minHeight: 10, // Adjust the height of the indicator as needed
        backgroundColor: Colors.grey[300], // Background color of the progress bar
        valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(47, 102, 127, 1)), // Color of the progress bar
      )
        : Text(_fullconv),
        );
      case 'Summary              ':
        return Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(16),
          child: _isLoadingS
        ? LinearProgressIndicator(
        minHeight: 10, // Adjust the height of the indicator as needed
        backgroundColor: Colors.grey[300], // Background color of the progress bar
        valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(47, 102, 127, 1)), // Color of the progress bar
      )
        : Text(_summary),
        );
      case 'Reminder             ':
        return Container(
          color: const Color.fromARGB(0, 238, 238, 238),
          padding: const EdgeInsets.all(16),
          child:_isLoadingR
        ?  LinearProgressIndicator(
        minHeight: 10, // Adjust the height of the indicator as needed
        backgroundColor: Colors.grey[300], // Background color of the progress bar
        valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(47, 102, 127, 1)), // Color of the progress bar
      )
        : Text(_reminder),
          
        );
    case 'Note                         ':
  return Column(
    children: [
      ElevatedButton.icon(
        onPressed: () {
          _showAddNoteDialog();
        },
        icon: Icon(Icons.add),
        label: Text('Add Note'),
      ),
      SizedBox(height: 16),
      Text(
        'This Section will show notes for the conversation',
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 16),
      Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16),
        child: Text( widget.conversation.notes.isNotEmpty ? widget.conversation.notes : 'No notes available',
      ),
      ),
    ],
  );
      default:
        return Container();
    }
  }
  Widget _buildAddNoteButton() {
    return FloatingActionButton(
      onPressed: () {
        _showAddNoteDialog();
      },
      tooltip: 'Add Note',
      child: Icon(Icons.add),
    );
  }

Future<void> _showAddNoteDialog() async {
  String newNote = ''; // Variable to hold the new note

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Note'),
        content: TextField(
          onChanged: (value) {
            newNote = value; // Update newNote variable as the user types
          },
          decoration: InputDecoration(
            hintText: 'Enter your note here',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                // Update the notes and trigger a rebuild
                widget.conversation.notes += '\n$newNote';
                print('New notes: ${widget.conversation.notes}'); // Add this line for debugging

                // Update the notes in the JSON data source as well
                updateJsonData();
              });
              Navigator.of(context).pop(); 
            },
            child: Text('Add'),
          ),
        ],
      );
    },
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(151, 228, 241, 1),
                      ),
                      child: const Center(
                        child: Text(
                          '?',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Flexible(
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
                deleteConversation();
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text(
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
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ); 
      },
    );
  }
void deleteConversation() {
    try {
      // 1. Delete files associated with the conversation using widget.conversation.fileLocation
      File(widget.conversation.fileLocation).deleteSync();
      print('File deleted successfully');

     deleteConversationEntry(widget.conversation.id);
     Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConversationListScreen(),
              ),
            );
    } catch (e) {
      print('Error deleting conversation: $e');
    }
  }
  
  }