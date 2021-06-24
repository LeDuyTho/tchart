import 'package:flutter/material.dart';

class TChartStyle {
  TChartStyle({
    this.backgroundColor = Colors.white,
    this.lineBarColor = Colors.blue,
    this.textColor = Colors.black87,
    this.gridColor = Colors.black26,
    this.axisColor = const Color(0xffdddddd), //(0xffccd6eb),
    this.axisStrokeWidth = 1.6,
  });

  // màu nền
  Color backgroundColor;

  // màu thanh ngang
  Color lineBarColor;

  // màu text
  Color textColor;

  // màu lưới
  Color gridColor;

  // màu trục tọa độ
  Color axisColor;

  // độ rộng trục tọa độ
  double axisStrokeWidth;
}
