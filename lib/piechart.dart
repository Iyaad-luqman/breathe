// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:pie_chart/pie_chart.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/Login.png'), // Replace with your image path 
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: ClipRRect(
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 90, sigmaY: 130),
//                   child: BottomNavigationBar(
//                     backgroundColor: Color.fromARGB(255, 31, 0, 102).withOpacity(0),
//                     items: <BottomNavigationBarItem>[
//                       BottomNavigationBarItem(
//                         icon: Container(
//                           child: Icon(
//                             Icons.home,
//                             size: 30,
//                           ),
//                         ),
//                         label: '',
//                       ),
//                       // ... other BottomNavigationBarItems
//                     ],
//                     // ... other BottomNavigationBar properties
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         appBar: AppBar(
//           title: Text('Pie Chart Example'),
//         ),
//         body: Center(
//           child: ,
//         ),
//       ),
//     );
//   }
// }

// class PieChartExample extends StatefulWidget {
//   @override
//   _PieChartExampleState createState() => _PieChartExampleState();
// }

// class _PieChartExampleState extends State<PieChartExample> {
//   Map<String, double> dataMap = {
//     "Happy": 5,
//     "Fear": 3,
//     "Anxious": 2,
//     "Ionic": 2,
//   };

//   @override
//   Widget build(BuildContext context) {
//     return PieChart(dataMap: dataMap);
//   }
// }