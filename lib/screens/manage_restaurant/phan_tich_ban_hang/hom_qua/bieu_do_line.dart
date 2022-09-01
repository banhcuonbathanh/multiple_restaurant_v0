import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fl_chart/fl_chart.dart';

class BieuDoLine extends StatelessWidget {
  final double minX;
  final double minY;
  final double maxX;
  final double maxY;
  final String title;
  final List<double> listx;
  final List<double> listy;
  final List<String> caseValue;
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<FlSpot> flSpotData = [];

  BieuDoLine(
      {Key? key,
      required this.minX,
      required this.minY,
      required this.maxX,
      required this.maxY,
      required this.title,
      required this.listx,
      required this.listy,
      required this.caseValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < listx.length; i++) {
      flSpotData.add(FlSpot(listx[i], listy[i]));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Container(
          height: 300,
          width: double.infinity,
          child: LineChart(
            LineChartData(
                minX: minX,
                maxX: maxX,
                minY: minY,
                maxY: maxY,
                titlesData: LineTitle.getTitleData(
                    case2: caseValue[0],
                    case4: caseValue[1],
                    case6: caseValue[2],
                    case8: caseValue[3],
                    case10: caseValue[4],
                    case12: caseValue[5]),
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
                    spots: [...flSpotData],
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
  static getTitleData({
    required String case2,
    required String case4,
    required String case6,
    required String case8,
    required String case10,
    required String case12,
  }) =>
      FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTitlesWidget: (value, meta) {
            switch (value.toInt()) {
              case 2:
                return Text(case2);
              case 4:
                return Text(case4);
              case 6:
                return Text(case6);
              case 8:
                return Text(case8);
              case 10:
                return Text(case10);
              case 12:
                return Text(case12);
            }
            return Text('');
          },
        )),
        // leftTitles: AxisTitles(
        //     sideTitles: SideTitles(
        //         showTitles: true,
        //         reservedSize: 22,
        //         getTitlesWidget: (value, meta) {
        //           switch (value.toInt()) {
        //             case 2:
        //               return Text('x');
        //             case 4:
        //               return Text('jun');
        //           }
        //           return Text('');
        //         })),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );
}
