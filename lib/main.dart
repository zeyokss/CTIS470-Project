import 'package:flipera/allScreens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
     MaterialApp(
      title: 'FlipEra',
      theme: ThemeData(
        fontFamily: 'Montserrat', // not 'Poppins'
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}