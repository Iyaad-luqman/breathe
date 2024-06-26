import 'dart:ui';
import 'package:breathe/chatbot.dart';
import 'package:breathe/home.dart';
import 'package:breathe/meditation.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Pie extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}


class _CommunityPageState extends State<Pie> {
    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
      if (index == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => med()));
      }
      if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Chatbot()));
      }
    });
  }
   Map<String, double> dataMap = {
    "Happy": 75,
    "Fear": 12,
    "Anxious": 09,
    "Angry": 04,
  };
  int _selectedIndex = -1;


  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Login.png'), // Replace with your image path 
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
            Container(
              height: 20,
              width: double.infinity,
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                'Trend Analysis',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nexa',
                ),
              ),
            ),
            Container(
              height: 20,
              width: double.infinity,
            ),
          ],
        ),
        PieChart(dataMap: dataMap),
       
        Container(
              margin: EdgeInsets.only(top: 520),
              child: Center(
                child: Text(
                  'Domainant Mood: Happy',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nexa',
                  ),
                ),
              ),
            ),
               Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(30.0),
              //   topRight: Radius.circular(30.0),
              // ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 90, sigmaY: 130),
                child: BottomNavigationBar(
                  backgroundColor: Color.fromARGB(255, 31, 0, 102).withOpacity(
                      0), // make the BottomNavigationBar semi-transparent
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Container(
                        child: Icon(
                          Icons.home,
                          size: 30,
                        ), // replace with your custom icon
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        
                        child: Icon(
                          Icons.chat_bubble_outline,
                          size: 30,
                        ), // replace with your custom icon
                      ),
                      label: '',
                    ),
                    
                    BottomNavigationBarItem(
                      icon: Container(
                        child: Icon(
                          Icons.self_improvement,
                          size: 30,
                        ), // replace with your custom icon
                      ),
                      label: '',
                    ),
                    
                    
                  ],
                  currentIndex: _selectedIndex < 0 ? 0 : _selectedIndex,
                  selectedItemColor: Colors.amber[800],
                  onTap: _onItemTapped,
                  showSelectedLabels:
                      false, // do not show labels for selected items
                  showUnselectedLabels:
                      false, // do not show labels for unselected items
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
