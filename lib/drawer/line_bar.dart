//------ Line Bar

import 'package:flutter/material.dart';

class LineBarWidget extends StatelessWidget {
  LineBarWidget({
    @required this.xBeginCd,
    @required this.xEndCd,
    @required this.yCd,
    @required this.width,
    @required this.height,
    @required this.color,
  });

  double xBeginCd;
  double xEndCd;
  double yCd;

  double width;
  double height;

  Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(width, height),
        painter: LineBarPainter(xBeginCd: xBeginCd, xEndCd: xEndCd, yCd: yCd, color: color),
      ),
    );
  }
}

class LineBarPainter extends CustomPainter {
  LineBarPainter({
    @required this.xBeginCd,
    @required this.xEndCd,
    @required this.yCd,
    @required this.color,
  });

  double xBeginCd;
  double xEndCd;
  double yCd;

  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 4
    //..strokeCap = StrokeCap.round
      ..color = color;

    var x = size.width;
    var y = size.height;

    canvas.drawLine(Offset(xBeginCd, yCd), Offset(xEndCd, yCd), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}