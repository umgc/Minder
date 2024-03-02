import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TourGuide(),
    );
  }
}

class TourGuide extends StatefulWidget {
  const TourGuide({Key? key}) : super(key: key);

  @override
  _TourGuideState createState() => _TourGuideState();
}

class _TourGuideState extends State<TourGuide> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          ImagePage(image: 'First Image'),
          ImagePage(image: 'Second Image'),
          ImagePage(image: 'Third Image'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Color.fromRGBO(47, 102, 127,1),
              child: Text(''),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Color.fromRGBO(47, 102, 127,1),
              child: Text(''),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Color.fromRGBO(47, 102, 127,1),
              child: Text(''),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}


class ImagePage extends StatelessWidget {
  final String image;

  const ImagePage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        image,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
