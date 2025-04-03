import 'package:flutter/material.dart';
import 'flashcard_list.dart';
import 'flashcard_form.dart';
import 'home_page.dart'; // Create this file for the main home page

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // Start with Home Page as default

  // List of screens for navigation
  final List<Widget> _screens = [
    const FlashcardListPage(),  // Flashcard list screen
    const HomePage(),        // Home Page (NEW)
    const FlashcardForm(),   // Flashcard creation screen
  ];

  // Function to change the selected index when a tab is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlipEra'),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: _screens[_selectedIndex], // Show selected screen dynamically
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Flashcards'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Learn'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Flashcard'),
        ],
        currentIndex: _selectedIndex, // Highlight selected tab
        onTap: _onItemTapped, // Change screen on tap
        selectedItemColor: Colors.cyan, // Highlight color
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
