import 'package:flutter/material.dart';

void main() {

  runApp(const CaregiverSetting());

}

class CaregiverSetting extends StatelessWidget {
  const CaregiverSetting({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          Iphone8Plus1(),
        ]),
      ),
    );
  }
}

class Iphone8Plus1 extends StatefulWidget {
  @override
  _Iphone8Plus1State createState() => _Iphone8Plus1State();
}

class _Iphone8Plus1State extends State<Iphone8Plus1> {
  bool profileInfoExpanded = false;
  bool remindersExpanded = false;
  bool guidedTourExpanded = false;
  bool supportCenterExpanded = false;
  bool editProfileDetailsVisible = false;
  bool remindersDetailsVisible = false; // Added

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 414,
          height: 736,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 20,
                top: 35,
                child: Container(
                  width: 375,
                  height: 667,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Stack(
                    children: [
                      const Positioned(
                        left: 16,
                        top: 23.50,
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            color: Color(0xFF030303),
                            fontSize: 32,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                      if (profileInfoExpanded)
                        Positioned(
                          left: 40,
                          top: 70,
                          child: Image.asset(
                            'asset/images/profile-grandmother.jpg',
                            width: 100,
                            height: 100,
                          ),
                        ),
                      Positioned(
                        left: profileInfoExpanded ? 150 : 40,
                        top: 115,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              profileInfoExpanded = !profileInfoExpanded;
                              editProfileDetailsVisible = false;
                              remindersExpanded = false;
                              guidedTourExpanded = false;
                              supportCenterExpanded = false;
                            });
                          },
                          child: Text(
                            'Profile Information',
                            style: TextStyle(
                              color: const Color(0xFF030303),
                              fontSize: profileInfoExpanded ? 20 : 14,
                              fontFamily: 'Montserrat',
                              fontWeight: profileInfoExpanded
                                  ? FontWeight.w400
                                  : FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      if (profileInfoExpanded)
                        Positioned(
                          left: 160,
                          top: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!editProfileDetailsVisible)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      editProfileDetailsVisible = true;
                                    });
                                  },
                                  child: const Text(
                                    'Edit Profile Details',
                                    style: TextStyle(
                                      color: Color(0xFF030303),
                                      fontSize: 14,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              if (editProfileDetailsVisible)
                                Positioned(
                                  left: profileInfoExpanded ? 150 : 40,
                                  top: 180,
                                  child: EditProfileDetails(),
                                ),
                              // Add other profile information details here
                            ],
                          ),
                        ),
                      Positioned(
                        left: 0,
                        top: 190,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              remindersExpanded = !remindersExpanded;
                              profileInfoExpanded = false;
                              editProfileDetailsVisible = false;
                              guidedTourExpanded = false;
                              supportCenterExpanded = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.only(
                              left: remindersExpanded ? 150 : 40,
                            ),
                            child: Text(
                              'Reminders',
                              style: TextStyle(
                                color: const Color(0xFF030303),
                                fontSize: remindersExpanded ? 20 : 14,
                                fontFamily: 'Montserrat',
                                fontWeight: remindersExpanded
                                    ? FontWeight.w400
                                    : FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (remindersExpanded)
                        Positioned(
                          left: 10,
                          top: 150,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                remindersDetailsVisible = !remindersDetailsVisible;
                              });
                            },
                            child: Image.asset(
                              'asset/images/clock.jpg', // Change this with your asset
                              width: 120,
                              height: 120,
                            ),
                          ),
                        ),
                      if (remindersExpanded)
                        Positioned(
                          left: remindersExpanded ? 150 : 40,
                          top: 230,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // Add your logic for Edit Reminder Details here
                                  });
                                },
                                child: const Text(
                                  'Edit Reminder Details',
                                  style: TextStyle(
                                    color: Color(0xFF030303),
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                              if (remindersDetailsVisible)
                                Positioned(
                                  left: profileInfoExpanded ? 150 : 40,
                                  top: 180,
                                  child: RemindersDetails(),
                                ),
                            ],
                          ),
                        ),
                      Positioned(
                        left: 0,
                        top: 265,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              guidedTourExpanded = !guidedTourExpanded;
                              profileInfoExpanded = false;
                              editProfileDetailsVisible = false;
                              remindersExpanded = false;
                              supportCenterExpanded = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.only(
                              left: guidedTourExpanded ? 150 : 40,
                            ),
                            child: Text(
                              'Guided Tour',
                              style: TextStyle(
                                color: const Color(0xFF030303),
                                fontSize: guidedTourExpanded ? 20 : 14,
                                fontFamily: 'Montserrat',
                                fontWeight: guidedTourExpanded
                                    ? FontWeight.w400
                                    : FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (guidedTourExpanded)
                        Positioned(
                          left: 15,
                          top: 220,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // Add your logic for GuidedTourDetails here
                              });
                            },
                            child: Image.asset(
                              'asset/images/guideTour.jpg', // Change this with your asset
                              width: 120,
                              height: 120,
                            ),
                          ),
                        ),
                      if (guidedTourExpanded)
                        Positioned(
                          left: guidedTourExpanded ? 150 : 40,
                          top: 300,
                          child: GuidedTourDetails(),
                        ),
                      Positioned(
                        left: 0,
                        top: 360,
                        
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              supportCenterExpanded = !supportCenterExpanded;
                              profileInfoExpanded = false;
                              editProfileDetailsVisible = false;
                              remindersExpanded = false;
                              guidedTourExpanded = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.only(
                              left: supportCenterExpanded ? 150 : 40,
                            ),
                            child: Text(
                              'Support Center',
                              style: TextStyle(
                                color: const Color(0xFF030303),
                                fontSize: supportCenterExpanded ? 20 : 14,
                                fontFamily: 'Montserrat',
                                fontWeight: supportCenterExpanded
                                    ? FontWeight.w400
                                    : FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (supportCenterExpanded)
                        Positioned(
                          left: 15,
                          top: 330,
                          
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // Add your logic for SupportCenterDetails here
                              });
                            },
                            child: Image.asset(
                              'asset/images/support.jpg', // Change this with your asset
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                      if (supportCenterExpanded)
                        Positioned(
                          left: supportCenterExpanded ? 150 : 40,
                          top: 400,
                          child: SupportCenterDetails(),
                        ),
                      
                      //Sign Out 
                      
                      Positioned(
                        left: 16,
                        top: 504,
                        child: Container
                        (
                          width: 343,
                          height: 56,
                            
                         child: ElevatedButton(
                    onPressed: () {
                      // Handle Disagree button press
                      print('Sign OUt button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(
                          255, 100, 139, 179), // Change color as needed
                    ),
                    child: const Text(
                      'SIgn Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                           
                         
                        )
                        ,
                      ),                  
                                           
                    ],
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

class EditProfileDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // Add your content for Edit Profile Details here
        Text(
          'Edit Profile Details Content',
          style: TextStyle(
            color: Color(0xFF030303),
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ],
    );
  }
}


class RemindersDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // Add your content for RemindersDetails here
        Text(
          'Reminders Details Content',
          style: TextStyle(
            color: Color(0xFF030303),
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ],
    );
  }
}

class GuidedTourDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // Add your content for GuidedTourDetails here
        Text(
          'Guided Tour Details Content',
          style: TextStyle(
            color: Color(0xFF030303),
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ],
    );
  }
}

class SupportCenterDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // Add your content for SupportCenterDetails here
        Text(
          'Support Center Details Content',
          style: TextStyle(
            color: Color(0xFF030303),
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ],
    );
  }
}

