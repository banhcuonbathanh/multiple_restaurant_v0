import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Pie_chart extends StatelessWidget {
  Pie_chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: PieChart(
        PieChartData(sections: getSection()),
      ),
    );
  }

  List<PieChartSectionData> getSection() {
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: 0.2,
        title: 'test1',
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: 0.8,
        title: 'test2',
      )
    ];
  }
}
