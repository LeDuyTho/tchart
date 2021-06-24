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
          xGridNumPoint: 4,
          yGridNumPoint: 4,
          xLabels: [
            "7h",
            "8h",
            "9h",
          ],
          yLabels: ["Máy 1", "Máy 2", "Máy 3", "4"],
          chartStyle: TChartStyle(
              // backgroundColor: Colors.white,
              // //axisColor: Colors.green,
              //  axisStrokeWidth: 1.6,
              // gridColor: Colors.red,
              // textColor: Colors.yellow,
              // lineBarColor: Colors.purple,
              ),
          dataBuilder: () {
            return [
              [LineBarItem(20, 100), LineBarItem(100, 250)],
              [LineBarItem(120, 30)],
              [LineBarItem(12, 15)],
              [LineBarItem(12, 20)]
            ];
          },
        ),
      ),
    );
  }
}
