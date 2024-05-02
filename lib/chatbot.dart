import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';



class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
   List<String> messages = ['Welcome to Chatbot'];

  @override
  Widget build(BuildContext context) {
    double hlen = MediaQuery.of(context).size.height;
    double wlen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: hlen * 0.25, // Adjust these values as needed
            left: wlen * 0.1,
            child: Container(
              height: hlen * 0.5, // Adjust these values as needed
              width: wlen * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter a message',
                      ),
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // You'll need to implement this function
  String aiChatbotFunction(String userInput) {
    // Process the user input and return the chatbot's response
    // Add your implementation here

    return ''; // Replace this with the actual chatbot response
  }
    // Process the user input and return the chatbot's response
}