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
        padding: const EdgeInsets.all(20.0),
        child: HorizontalLineChart(
          width: maxWidth - 40,
          // subtract real width
          height: maxWidth - 40,
          paddingLeft: 45,
          paddingBottom: 24,
          xGridNumPoint: 8,
          yGridNumPoint: 8,
          xLabels: [
            "7h",
            "8h",
            "7h",
            "8h",
            "7h",
            "7h",
            "8h",
            "7h",
          ],
          yLabels: ["Máy 1", "Máy 2", "Máy 3", "4", "Máy 1", "Máy 2", "Máy 3", "4"],
          chartStyle: TChartStyle(
              //backgroundColor: Colors.grey,
              // //axisColor: Colors.green,
              //  axisStrokeWidth: 1.6,
              // gridColor: Colors.red,
              // textColor: Colors.yellow,
              // lineBarColor: Colors.purple,
              //  lineBarStrokeWidth: 5,
              ),
          dataBuilder: (xGrids) {
            return [
              [LineBarItem(xGrids[0], 0, color: Colors.red)],
              [
                LineBarItem(0, 30),
                LineBarItem(40, 80, color: Colors.purple),
              ],
              [LineBarItem(12, 15)],
              [LineBarItem(12, 20)]
            ];
          },
        ),
      ),
    );
  }
}
