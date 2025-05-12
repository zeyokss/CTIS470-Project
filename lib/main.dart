// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flipera/allScreens/home_screen.dart';
import 'package:flipera/allScreens/flashcard_form.dart';
import 'package:flipera/services/sync_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final sync = SyncService();
  sync.start();

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