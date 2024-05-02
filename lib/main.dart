import 'package:breathe/plain_template.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './splash.dart';
// Removed unused import
// import './dashboard.dart'; // import your DashboardScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Breathe',
      themeMode: ThemeMode.dark,
      home: FutureBuilder(
        // Initialize SharedPreferences
        future: SharedPreferences.getInstance(),
        builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {         
            return Home(); // Show splash screen while reading preferences
        
        },
      ),
    );
  }
}