import 'package:flutter/material.dart';
import 'package:socially/views/main_screens/create_screen.dart';
import 'package:socially/views/main_screens/feed_screen.dart';
import 'package:socially/views/main_screens/profile_screen.dart';
import 'package:socially/views/main_screens/reels_screen.dart';
import 'package:socially/views/main_screens/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    const FeedScreen(),
    const SearchScreen(),
    const CreateScreen(),
    const ReelsScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // onTap: (value) {
        //   setState(() {
        //     _selectedIndex = value;
        //   });
        // },
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "Create",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: "Reels",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profie",
          ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}
