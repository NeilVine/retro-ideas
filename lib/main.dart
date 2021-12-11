// main.dart - entry point for Flutter application

// imports
import 'package:flutter/material.dart';
import 'screens/screens.dart';

// app starts here
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      // App start by displaying the Loading Screen
      home: LoadingScreen(),
    );
  }
}
