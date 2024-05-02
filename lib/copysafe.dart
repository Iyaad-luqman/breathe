import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';



class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  List<String> messages = []; // This will hold the chat messages

  @override
  void initState() {
    super.initState();
    // _checkFirebase();
  }

  int _selectedIndex = -1;

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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // this will hide the back button
        title: Center(
          child: Text('BREATHE'), // replace 'Marks' with your desired title
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 90, sigmaY: 130),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 31, 0, 102).withOpacity(0),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: hlen,
            width: wlen,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Dashboard.jpg'),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 5),
                    child: Text(
                      '',
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'Manrope',
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
                          '',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Add a GridView.builder
                  
                  
                  //code here



                ],
              ),
            ),
          Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(messages[index]),
                      );
                    },
                  ),
                ),
           TextField(
                  onSubmitted: (String userInput) {
                    setState(() {
                      messages.add('User: $userInput');
                    });
                    var response = aiChatbotFunction(userInput); // You'll need to implement this function
                    setState(() {
                      messages.add('Bot: $response');
                    });
                  },
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
                          Icons.medical_information,
                          size: 30,
                        ), // replace with your custom icon
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        child: Icon(
                          Icons.person,
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
  
  aiChatbotFunction(String userInput) {}
}