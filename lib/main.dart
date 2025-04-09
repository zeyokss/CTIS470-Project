import 'package:flutter/material.dart';
import 'package:flipera/allScreens/home_screen.dart';
import 'package:flipera/allScreens/flashcard_form.dart'; // <-- FlashcardForm burada

void main() {
  runApp(
    MaterialApp(
      title: 'FlipEra',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: {
        '/add': (context) => const FlashcardForm(), // <-- Burası eklendi
      },
    ),
  );
}
