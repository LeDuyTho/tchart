library tchart;

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class HorizontalLineChart extends StatelessWidget {
  HorizontalLineChart({
    Key key,
    this.xGridNumPoint = 0,
    this.yGridNumPoint = 0,
    @required this.width,
    @required this.height,
    this.padding = 20,
    this.backgroundColor = Colors.black12,
  }) : super(key: key);

  double width;
  double height;
  double padding;

  int xGridNumPoint;
  int yGridNumPoint;

  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    double w = width - padding * 2;
    double h = height - padding * 2;

    return Container(
      color: backgroundColor,
      width: width,
      height: height,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(padding),
            child: Stack(
              children: [
                CoordinateAxisWidget(
                  width: w,
                  height: h,
                ),
                XGridPainterWidget(
                  width: w,
                  height: h,
                  numPoint: xGridNumPoint,
                ),
                YGridPainterWidget(
                  width: w,
                  height: h,
                  numPoint: yGridNumPoint,
                ),
                LineBarWidget(
                  xBeginCd: 0,
                  xEndCd: 100,
                  yCd: 260 / 3,
                  width: w,
                  height: h,
                ),
              ],
            ),
          ),
          // XAxisTextWidget(
          //   xCd: 0,
          //   text: 'value',
          // ),
          Stack(
            children: [
              YAxisTextWidget(
                yCd: 20.0+(60*1),
                text: 'value',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

///=================
///
class TChartData {
  List<String> xLabels;
  List<String> yLabels;
}

//------ Text
class XAxisTextWidget extends StatelessWidget {
  XAxisTextWidget({
    @required this.text,
    @required this.xCd,
    this.fontSize = 14,
  });

  String text;
  double xCd;
  double fontSize;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: xCd,
      bottom: 0,
      child: Container(
        // color: Colors.red,
        // width: width,
        // height: height,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, color: Colors.green),
          ),
        ),
      ),
    );
  }
}

class YAxisTextWidget extends StatelessWidget {
  YAxisTextWidget({
    @required this.text,
    @required this.yCd,
    this.fontSize = 14,
  });

  String text;
  double yCd;
  double fontSize;

  @override
  Widget build(BuildContext context) {
    double bottom = max(yCd - fontSize, 0);

    return Positioned(
      left: 0,
      bottom: yCd,
      child: Container(
        // color: Colors.red,
        // width: width,
        // height: height,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, color: Colors.green),
          ),
        ),
      ),
    );
  }
}

//------ Line Bar

class LineBarWidget extends StatelessWidget {
  LineBarWidget({
    @required this.xBeginCd,
    @required this.xEndCd,
    @required this.yCd,
    @required this.width,
    @required this.height,
  });

  double xBeginCd;
  double xEndCd;
  double yCd;

  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(width, height),
        painter: LineBarPainter(xBeginCd: xBeginCd, xEndCd: xEndCd, yCd: yCd),
      ),
    );
  }
}

class LineBarPainter extends CustomPainter {
  LineBarPainter({
    @required this.xBeginCd,
    @required this.xEndCd,
    @required this.yCd,
  });

  double xBeginCd;
  double xEndCd;
  double yCd;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 4
      //..strokeCap = StrokeCap.round
      ..color = Colors.blue;

    var x = size.width;
    var y = size.height;

    canvas.drawLine(Offset(xBeginCd, yCd), Offset(xEndCd, yCd), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

//-----  Xgrid: Lưới

class XGridPainterWidget extends StatelessWidget {
  XGridPainterWidget({
    @required this.width,
    @required this.height,
    this.numPoint = 0,
  });

  int numPoint;

  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(width, height),
        painter: XGridPainter(numPoint: numPoint),
      ),
    );
  }
}

class XGridPainter extends CustomPainter {
  XGridPainter({this.numPoint = 0});

  int numPoint;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      //..strokeWidth = 1
      ..color = Colors.black26;

    var x = size.width;
    var y = size.height;

    var each = x / (numPoint + 1);

    for (int i = 0; i < numPoint; i++) {
      double xGrid = each * (i + 1);
      print('draw: $xGrid');
      canvas.drawLine(Offset(xGrid, y), Offset(xGrid, 0), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

//-----  Ygrid: Lưới

class YGridPainterWidget extends StatelessWidget {
  YGridPainterWidget({
    @required this.width,
    @required this.height,
    this.numPoint = 0,
  });

  double width;
  double height;

  int numPoint;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(width, height),
        painter: YGridPainter(numPoint: numPoint),
      ),
    );
  }
}

class YGridPainter extends CustomPainter {
  YGridPainter({this.numPoint = 0});

  int numPoint;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      //..strokeWidth = 1
      ..color = Colors.black26;

    var x = size.width;
    var y = size.height;

    var each = y / (numPoint + 1);

    for (int i = 0; i < numPoint; i++) {
      var yGrid = each * (i + 1);
      canvas.drawLine(Offset(0, yGrid), Offset(x, yGrid), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

//----- coordinate axis: trục tọa độ

class CoordinateAxisWidget extends StatelessWidget {
  CoordinateAxisWidget({
    @required this.width,
    @required this.height,
  });

  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(width, height),
        painter: CoordinateAxisPainter(),
      ),
    );
  }
}

class CoordinateAxisPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..color = Colors.black;

    var x = size.width;
    var y = size.height;

    final midY = y / 2;

    final pointMode = PointMode.polygon;
    final points = [
      Offset(0, 0),
      Offset(0, y),
      Offset(x, y),
    ];
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
