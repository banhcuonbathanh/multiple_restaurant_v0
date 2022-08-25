import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fl_chart/fl_chart.dart';

class BieuDo extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  BieuDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('  data :'),
        Container(
          height: 300,
          width: double.infinity,
          child: LineChart(
            LineChartData(
                minX: 0,
                maxX: 11,
                minY: 0,
                maxY: 6,
                titlesData: LineTitle.getTitleData(),
                lineBarsData: [
                  LineChartBarData(
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                          colors: gradientColors
                              .map((e) => e.withOpacity(0.3))
                              .toList()),
                    ),
                    isCurved: true,
                    gradient: LinearGradient(colors: gradientColors),
                    spots: [
                      FlSpot(0, 3),
                      FlSpot(2, 5),
                      FlSpot(4, 4),
                      FlSpot(6, 3),
                      FlSpot(8, 4),
                      FlSpot(10, 4),
                      FlSpot(11, 5),
                    ],
                  ),
                ],
                gridData: FlGridData(
                    show: true,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(color: Colors.grey.shade300);
                    },
                    drawVerticalLine: true,
                    getDrawingVerticalLine: (value) {
                      return FlLine(color: Colors.grey.shade300);
                    }),
                borderData: FlBorderData(
                    border: Border.all(color: Colors.grey.shade300),
                    show: true)),
          ),
        ),
      ],
    );
  }
}

class LineTitle {
  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTitlesWidget: (value, meta) {
            switch (value.toInt()) {
              case 2:
                return Text('mar');
              case 4:
                return Text('jun');
            }
            return Text('');
          },
        )),
        leftTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTitlesWidget: (value, meta) {
            switch (value.toInt()) {
              case 2:
                return Text('mar');
              case 4:
                return Text('jun');
            }
            return Text('');
          },
        )),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );
}
 