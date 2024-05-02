import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
    @override
  void initState() {
    super.initState();
    // _checkFirebase();
  }
  
  int _selectedIndex = -1;
  Future<List<List<dynamic>>>? _marksFuture;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == 0) {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Dashboard()));
      }
      if (index == 1) {}
      if (index == 2) {}
    });
  }


  @override
  Widget build(BuildContext context) {
    double hlen = MediaQuery.of(context).size.height;
    double wlen = MediaQuery.of(context).size.width;

    // Return your widget here using the data
    return Scaffold(
      
      body: Stack(
        children: [
          Container(
            height: hlen,
            width: wlen,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/homepage.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Center(
                        child: Text(
                          'Breathe',
                          style: TextStyle(
                            fontFamily:"Lostamasta",
                            fontSize: 30
                          ),
                        ), // replace 'Marks' with your desired title
                      ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 5),
                    child: Text(
                      'Good morning',
                      style: TextStyle(
                          fontSize: 29,
                          fontFamily: 'epilogue',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                    
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          'Mishal',
                          style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'Romany',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                   SizedBox(
                    height: 90,
                  ),
                  Container(
                    child: Image.asset(
                      'assets/Icons/addons.png', // Replace with the path to your icon
                      width: 24,
                      height: 24,
  ),
),
                   
                   
                              
                  // Add a GridView.builder
                  
                  
                  //code here



                ],
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
                filter: ImageFilter.blur(sigmaX: 110, sigmaY: 130),
                child: BottomNavigationBar(
                  backgroundColor: Color.fromARGB(255, 76, 51, 134).withOpacity(
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
                          Icons.book,
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
                    BottomNavigationBarItem(
                      icon: Container(
                        child: Icon(
                          Icons.chat_bubble,
                          size: 30,
                        ), // replace with your custom icon
                      ),
                      label: '',
                    )
                  ],
                  currentIndex: _selectedIndex < 0 ? 0 : _selectedIndex,
                  selectedItemColor: Colors.amber[800],
                  unselectedItemColor: Colors.white,
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
