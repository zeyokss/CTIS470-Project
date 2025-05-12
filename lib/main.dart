import 'package:flutter/material.dart';
import 'package:flipera/allScreens/home_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flipera/allScreens/flashcard_form.dart'; 

void main() {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize FFI for sqflite
  sqfliteFfiInit();
  // Tell the global openDatabase API to use the FFI factory
  databaseFactory = databaseFactoryFfi;
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
        '/add': (context) => const FlashcardForm(), 
      },
    ),
  );
}