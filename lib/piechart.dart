import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pie Chart Example'),
        ),
        body: Center(
          child: PieChartExample(),
        ),
      ),
    );
  }
}

class PieChartExample extends StatefulWidget {
  @override
  _PieChartExampleState createState() => _PieChartExampleState();
}

class _PieChartExampleState extends State<PieChartExample> {
  Map<String, double> dataMap = {
    "Happy": 5,
    "Fear": 3,
    "Anxious": 2,
    "Ionic": 2,
  };

  @override
  Widget build(BuildContext context) {
    return PieChart(dataMap: dataMap);
  }
}