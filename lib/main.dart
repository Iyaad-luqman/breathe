import 'package:breathe/login.dart';
import 'package:breathe/plain_template.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// Removed unused import
// import './dashboard.dart'; // import your DashboardScreen

void main() async {

WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
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
            return Login(); // Show splash screen while reading preferences
        
        },
      ),
    );
  }
}