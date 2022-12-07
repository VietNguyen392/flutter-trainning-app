import 'package:flutter/material.dart';
import 'paint.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const PaintPage());
  }
}

/* class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedWidget = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    PhotoPage(title: 'Photo'),
    VideoPage(title: 'Video',)
  ];
  void _onSelectBar(int index) {
    setState(() {
      _selectedWidget = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _widgetOptions.elementAt(_selectedWidget),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Photo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_camera_back), label: 'Video'),
        ],
        currentIndex: _selectedWidget,
        onTap: _onSelectBar,
        iconSize: 32,
      ),
    );
  }
}
 */