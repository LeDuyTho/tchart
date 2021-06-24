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
          xGridNumPoint: 3,
          yGridNumPoint: 3,
          xLabels: ["Aasd", "Bcde", "Cdfe",],
          yLabels: ["d", "e", "f"],
          dataBuilder: () {
            return [];
          },
        ),
      ),
    );
  }
}
