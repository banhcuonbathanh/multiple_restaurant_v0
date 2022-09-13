import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SpotData {
  final double x;
  final double y;

  SpotData({required this.x, required this.y});
  static List<SpotData> spotData({
    required List<double> dataX,
    required List<double> dataY,
  }) {
    List<SpotData> data = List<SpotData>.generate(
        dataX.length, (index) => SpotData(x: dataX[index], y: dataY[index]));
    return data;
  }

  static List<ScatterSpot> spotDataScatter({
    required List<double> dataX,
    required List<double> dataY,
  }) {
    List<ScatterSpot> data = List<ScatterSpot>.generate(
        dataX.length,
        (index) => ScatterSpot(
              dataX[index],
              dataY[index],
              radius: 6,
              color: Colors.grey.shade500,
            ));
    return data;
  }
}
