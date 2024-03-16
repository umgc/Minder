import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

void main() {
  runApp(const ReminderApp());
}

class ReminderApp extends StatelessWidget {
  const ReminderApp({super.key, Key? door});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        body: ListView(
          children: [
            CaregiverReminderCreationScreen(),
          ],
        ),
      ),
    );
  }
}

class CaregiverReminderCreationScreen extends StatefulWidget {
  final TextEditingController hourController = TextEditingController();
  final TextEditingController minuteController = TextEditingController();

  CaregiverReminderCreationScreen({super.key, Key? window});

  @override
  _CaregiverReminderCreationScreenState createState() =>
      _CaregiverReminderCreationScreenState();
}

class _CaregiverReminderCreationScreenState
    extends State<CaregiverReminderCreationScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController eventTypeController = TextEditingController();
  TextEditingController discussionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 375,
          height: 728,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0), // Border added
          ),
          child: Stack(
            children: [
              const Positioned(
                left: 90,
                top: 31.50,
                child: Text(
                  'Create a Reminder',
                  style: TextStyle(
                    color: Color(0xFF030303),
                    fontSize: 24,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),

              // Clock

              Positioned(
                left: 130,
                top: 70.50,
                child: Image.asset(
                  'asset/images/clock.jpg',
                  width: 100,
                  height: 100,
                ),
              ),

              // Choose a reminder Name

              const Positioned.fill(
                left: 108,
                top: 166.50,
                child: Text(
                  'Choose a Reminder Name',
                  style: TextStyle(
                    color: Color(0xFF7D7D7D),
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),

              // Type of event

              Positioned(
                left: 20.50,
                top: 214.50,
                child: Container(
                  width: 334,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.5),
                    border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10), // Adjust the left padding as needed
                    child: TextFormField(
                      controller: eventTypeController,
                      decoration: const InputDecoration(
                        hintText: 'Type of Event',
                        hintStyle: TextStyle(
                          color: Color(0xFF272727),
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Color(0xFF272727),
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),

              // Date
              Positioned(
                left: 20.50,
                top: 272.50,
                child: InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Container(
                    width: 334,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.5),
                      border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8, top: 13.50),
                          child: Text(
                            'Date',
                            style: TextStyle(
                              color: Color(0xFF272727),
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8, top: 13.50),
                          child: Text(
                            selectedDate != null
                                ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                : 'Select Date',
                            style: const TextStyle(
                              color: Color(0xFF272727),
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Time
              Positioned(
                left: 20.50,
                top: 330.50,
                child: InkWell(
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      setState(() {
                        selectedTime = pickedTime;
                      });
                    }
                  },
                  child: Container(
                    width: 334,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.5),
                      border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8, top: 13.50),
                          child: Text(
                            'Time',
                            style: TextStyle(
                              color: Color.fromRGBO(39, 39, 39, 0.89),
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.access_time,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8, top: 13.50),
                          child: Text(
                            selectedTime != null
                                ? '${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}'
                                : 'Select Time',
                            style: const TextStyle(
                              color: Color(0xFF272727),
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Upload a video Analysis
              Positioned(
                left: 176,
                top: 540,
                child: GestureDetector(
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles();

                    if (result != null) {
                      print('Selected File: ${result.files.single.path}');
                    }
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.green, // Add your desired color
                    ),
                    child: const Icon(
                      Icons.upload_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 104,
                top: 580,
                child: Text(
                  'Upload a Video Analysis',
                  style: TextStyle(
                    color: Color(0xFF7D7D7D),
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 642,
                child: GestureDetector(
                  onTap: () {
                    createReminderFile();
                  },
                  child: Container(
                    width: 335,
                    height: 54,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 88, 132, 168), // Add your desired color
                      borderRadius: BorderRadius.circular(22.5),
                    ),
                    child: const Stack(
                      children: [
                        Positioned(
                          left: 106,
                          top: 18,
                          child: Text(
                            'Create Reminder',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned.fill(
                left: 199,
                top: 134,
                child: GestureDetector(
                  onTap: () {
                    // Add your logic for selecting an image here
                  },
                ),
              ),
              //Discussion
              Positioned(
                left: 34,
                top: 404.50,
                child: Container(
                  width: 200, // Adjust the width as needed
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: discussionController,
                      style: const TextStyle(
                        color: Color(0xFF838485),
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Discussion',
                        hintStyle: TextStyle(
                          color: Color(0xFF838485),
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void createReminderFile() {
    String eventType = eventTypeController.text;
    String discussion = discussionController.text;

    if (eventType.isNotEmpty) {
      String fileName = '$eventType.txt';
      String fileContent = 'Event Type: $eventType\n';
      if (selectedDate != null) {
        fileContent += 'Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}\n';
      }
      if (selectedTime != null) {
        fileContent += 'Time: ${selectedTime!.format(context)}\n';
      }
      if (discussion.isNotEmpty) {
        fileContent += 'Discussion: $discussion';
      }

      // Save file
      File(fileName).writeAsString(fileContent).then((value) {
        print('Reminder file saved: $fileName');
      }).catchError((error) {
        print('Error saving reminder file: $error');
      });
    }
  }
}
