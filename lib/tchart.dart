library tchart;

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class TChartData {
  List<String> xLabels;
  List<String> yLabels;
//List<>
}

class LineBarItem {
  double x1;
  double x2;

  LineBarItem(this.x1, this.x2);
}

class HorizontalLineChart extends StatefulWidget {
  HorizontalLineChart({
    Key key,
    this.xGridNumPoint = 0,
    this.yGridNumPoint = 0,
    @required this.width,
    @required this.height,
    this.paddingTop = 20,
    this.paddingLeft = 20,
    this.paddingRight = 20,
    this.paddingBottom = 20,
    this.backgroundColor = Colors.white,
    this.xLabels = const [],
    this.yLabels = const [],
    @required this.dataBuilder,
  }) : super(key: key);

  List<String> xLabels;
  List<String> yLabels;
  List<List<LineBarItem>> Function() dataBuilder;

  double width;
  double height;

  double paddingTop;
  double paddingLeft;
  double paddingRight;
  double paddingBottom;

  int xGridNumPoint;
  int yGridNumPoint;

  Color backgroundColor;

  @override
  _HorizontalLineChartState createState() => _HorizontalLineChartState();
}

class _HorizontalLineChartState extends State<HorizontalLineChart> {
  double w;
  double h;

  List<double> yGrids = [];

  @override
  void initState() {
    print('End init');
    w = widget.width - (widget.paddingLeft + widget.paddingRight);
    h = widget.height - (widget.paddingTop + widget.paddingBottom);

    _calcYGrid();
    super.initState();
  }

  _calcYGrid() {
    int len = widget.yLabels.length;

    var each = h / (len + 1);

    for (int i = 0; i < len; i++) {
      var yGrid = each * (i + 1);
      yGrids.add(yGrid);
    }
  }

  _prepareXAxisTextWidget() {
    List<XAxisTextWidget> xas = [];
    int len = widget.xLabels.length;

    var each = (widget.width - (widget.paddingLeft + widget.paddingRight)) / (len + 1);

    for (int i = 0; i < len; i++) {
      var x = each * (i + 1) + widget.paddingLeft;
      print('x=' + x.toString());
      xas.add(new XAxisTextWidget(xCd: x, text: widget.xLabels[i]));
    }

    return xas;
  }

  _prepareYAxisTextWidget() {
    List<YAxisTextWidget> yas = [];
    int len = widget.yLabels.length;

    var each = (widget.height - (widget.paddingTop + widget.paddingBottom)) / (len + 1);

    for (int i = 0; i < len; i++) {
      var y = each * (i + 1) + widget.paddingBottom;
      print(y);
      yas.add(new YAxisTextWidget(yCd: y, text: widget.yLabels[i]));
    }

    return yas;
  }

  _buildLineBarWidget() {
    List<LineBarWidget> lineBarItems = [];

    var lst = widget.dataBuilder().reversed.toList();

    for (int i = 0; i < lst.length; i++) {
      List<LineBarItem> childList = lst[i];
      for (int j = 0; j < childList.length; j++) {
        var item = childList[j];
        lineBarItems.add(new LineBarWidget(
          xBeginCd: item.x1,
          xEndCd: item.x2,
          yCd: yGrids[i],
          width: w,
          height: h,
        ));
      }
    }

    return lineBarItems;
  }

  @override
  Widget build(BuildContext context) {
    print('Build');
    int index = 0;
    print('width=' + w.toString());
    return Container(
      color: widget.backgroundColor,
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(widget.paddingLeft, widget.paddingTop, widget.paddingRight, widget.paddingBottom),
            child: Stack(
              children: [
                CoordinateAxisWidget(
                  width: w,
                  height: h,
                ),
                XGridPainterWidget(
                  width: w,
                  height: h,
                  numPoint: widget.xGridNumPoint,
                ),
                YGridPainterWidget(
                  width: w,
                  height: h,
                  numPoint: widget.yGridNumPoint,
                ),
                (widget.dataBuilder != null && widget.dataBuilder().length > 0)
                    ? Stack(
                        children: _buildLineBarWidget(),
                      )
                    : Center(),
                // LineBarWidget(
                //   xBeginCd: 0,
                //   xEndCd: 100,
                //   yCd: 260 / 3,
                //   width: w,
                //   height: h,
                // ),
              ],
            ),
          ),
          Stack(
            children: _prepareXAxisTextWidget(),
          ),
          Stack(
            children: _prepareYAxisTextWidget(),
          )

          // XAxisTextWidget(
          //   xCd: 0,
          //   text: 'value',
          // ),
          // Stack(
          //   children: [
          //     YAxisTextWidget(
          //       yCd: 20.0 + (60 * 1),
          //       text: '1',
          //     ),
          //     YAxisTextWidget(
          //       yCd: 20.0 + (60 * 2),
          //       text: '2',
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

///=================
///

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
    double left = max(xCd - fontSize / 2, 0);

    return Positioned(
      left: xCd - text.length * (fontSize / 4),
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
    double bottom = max(yCd - fontSize / 2, 0);

    return Positioned(
      left: 0,
      bottom: bottom,
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
    print(width);
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
