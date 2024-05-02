import 'package:flutter/material.dart';
import './calander.dart';
class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push( context, MaterialPageRoute(builder: (context) => CalendarPage()), );
          // Add your onPress function here
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/logo.png'),
                Text(
                  'Breathe',
                  style: TextStyle(
                    fontFamily: "Lostamasta",
                    color: Color(0xFFB974E3), // Replace RRGGBB with your color's RGB values
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}