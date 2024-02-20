import 'package:flutter/material.dart';

void main() {
  runApp(const ReminderApp());
}

class ReminderApp extends StatelessWidget {
  const ReminderApp({super.key});

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

class CaregiverReminderCreationScreen extends StatelessWidget {
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
              Positioned(
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

             //Clock 

              Positioned(
                left: 130,
                top: 70.50,
                child: Image.asset(
                  'asset/images/clock.jpg',
                  width: 100,
                  height: 100,
                ),
              ),
             
              //Choose a reminder Name

              Positioned(
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
             
           //Type of event

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


             //Date
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
        // Handle the selected date
        print('Selected Date: $pickedDate');
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
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 13.50),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.calendar_today,
              color: Colors.grey,
              size: 20,
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
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 13.50),
          child: Text(
            'Time',
            style: TextStyle(
              color: Color(0xFF272727),
              fontSize: 14,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
         
      ],
    ),
  ),
),



           // Upload a video Analysis 
              Positioned(
                left: 176,
                top: 540,
                child: GestureDetector(
                  onTap: () {
                    // Add your logic for uploading video analysis here
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.green, // Add your desired color
                    ),
                    child: Icon(
                      Icons.upload_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
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
                    // Add your logic for creating a reminder here
                  },
                 
                 
                  child: 
                  Container(
                    width: 335,
                    height: 54,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 88, 132, 168), // Add your desired color
                       borderRadius: BorderRadius.circular(22.5),
                        ),
                    child: Stack(
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
             
             
              Positioned(
                left: 199,
                top: 134,
                child: GestureDetector(
                  onTap: () {
                    // Add your logic for selecting an image here
                  },
                 
                ),
              ),
              //Discusion 
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
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      style: TextStyle(
                        color: Color(0xFF838485),
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
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
}
