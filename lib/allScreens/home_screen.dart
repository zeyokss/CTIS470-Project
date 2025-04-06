import 'package:flutter/material.dart';
import 'flashcard_list.dart';
import 'home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Only two tabs: Flashcard List (index 0) and HomePage ("Learn", index 1)
  int _selectedIndex = 1; // Start with HomePage ("Learn") as default
  
  final List<Widget> _screens = [
    const FlashcardListPage(), // Flashcard list screen (with add FAB)
    const HomePage(),          // Learn screen
  ];
  
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
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Flashcards'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Learn'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
