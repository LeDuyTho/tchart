import 'package:flutter/material.dart';
import 'package:tchart/tchart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: HorizontalLineChart(
          width: 320,
          height: 400,
          paddingLeft: 40,
          paddingBottom: 24,
          xGridNumPoint: 3,
          yGridNumPoint: 3,
          xLabels: [
            "7h",
            "8h",
            "9h",
          ],
          yLabels: ["Máy 1", "Máy 2", "Máy 3"],
          dataBuilder: () {
            return [
              [LineBarItem(20, 100), LineBarItem(100, 150)],
              [LineBarItem(120, 30)],
              [LineBarItem(12, 250)],
            ];
          },
        ),
      ),
    );
  }
}
