import 'dart:async';
import 'dart:ui';
import 'package:breathe/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'meditation.dart';

class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  List<String> messages = ['Welcome to Arena'];
  TextEditingController messageController = TextEditingController(); // Step 1

  int _selectedIndex = 1;
  Future<List<List<dynamic>>>? _marksFuture;


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
  @override
  Widget build(BuildContext context) {
    double hlen = MediaQuery.of(context).size.height;
    double wlen = MediaQuery.of(context).size.width;

    return Scaffold(
  appBar: AppBar(
    automaticallyImplyLeading: false,
    title: Center(child: Text('Arena')),
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace: ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 90, sigmaY: 130),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          // Ensure the Container or its children are properly sized or laid out.
        ),
      ),
    ),
  ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/homepage.jpg"), // Assuming the image is in the assets directory
                fit: BoxFit.cover, // Cover the entire widget area
              ),
            ),
          ),
          Positioned(
            top: hlen * 0.05, // Adjust these values as needed
            left: wlen * 0.06,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Rounded corners
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 35), // Adjust the blur amount as needed
                child: Container(
                  height: hlen * 0.75, // Adjust these values as needed
                  width: wlen * 0.88,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 25, 1, 48).withOpacity(0.5), // Semi-transparent white to see the blur effect
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemCount: messages.length,
                              separatorBuilder: (context, index) => Divider(color: Colors.grey), // Divider between messages
                              itemBuilder: (context, index) {
                                bool isUserMessage = messages[index].startsWith('You:'); // Check if the message is from the user
                                return Align(
                                  alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft, // Align based on the sender
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: isUserMessage ? Color.fromARGB(66, 1, 70, 43) : Color.fromARGB(66, 63, 1, 39), // Different background colors
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      messages[index],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: wlen * 0.14,
                                  
                                  padding: EdgeInsets.symmetric(horizontal: 26, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextField(
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter a message',
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.send, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    messages.add('You: ${messageController.text}');
                                  });
                                  sendMessage();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://192.168.92.198:5000/process-text'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'text': messageController.text,
        }),
      );
  
      if (response.statusCode == 200) {
        // Assuming the response body is plain text
        final botResponse = response.body;
  
        setState(() {
          messages.add('Arena: $botResponse');
        });
      } else {
        // Handle error or unsuccessful response
        print('Failed to load response from API');
      }
  
      messageController.clear(); // Clear the text field after sending
    }
  }
  @override
  void dispose() {
    messageController.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }
}