import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'allScreens/home_screen.dart';
import 'allScreens/flashcard_form.dart';

void main() {
  // Initialize FFI for non-mobile platforms
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlipEra',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/add': (context) => const FlashcardForm(),
      },
    );
  }
}
