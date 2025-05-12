/* lib/allScreens/home_screen.dart */
import 'package:flutter/material.dart';
import 'flashcard_list.dart';
import 'home_page.dart';
import 'category_screen.dart'; // ← make sure to import this

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;  

  final List<Widget> _screens = [
    const FlashcardListPage(), 
    const HomePage(),          
    const CategoryScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.list),   label: 'Flashcards'),
          BottomNavigationBarItem(icon: Icon(Icons.home),   label: 'Learn'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
