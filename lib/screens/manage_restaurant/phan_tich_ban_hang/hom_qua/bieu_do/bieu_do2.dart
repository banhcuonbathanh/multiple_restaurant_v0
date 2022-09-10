import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../../../../../size_config.dart';
import 'data.dart';

class BieuDo2 extends StatelessWidget {
  const BieuDo2(
      {Key? key,
      required this.fromDate,
      required this.toDate,
      required this.listMapX,
      required this.listMapY,
      required this.DateandDay})
      : super(key: key);

  final DateTime fromDate;
  final DateTime toDate;
  final List<double> listMapX;
  final List<double> listMapY;
  final Map<double, DateTime> DateandDay;
  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('data'),
        SizedBox(
          height: getProportionateScreenWidth(15),
        ),
        Container(
          height: 300,
          width: double.infinity,
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      interval: 1,
                      showTitles: true,
                      reservedSize: 22,
                      getTitlesWidget: (value, meta) {
                        DateTime value1 = DateTime.now();
                        for (var i in listMapX) {
                          if (value.toInt() == i) {
                            value1 = DateandDay[i]!;
                          }
                        }
                        if (value.toInt() == listMapX[0]) {
                          value1 = fromDate;
                        }

                        return Text(DateFormat('MM-dd').format(value1));
                      }),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: SpotData.spotData(dataX: listMapX, dataY: listMapY)
                      .map((data) => FlSpot(data.x, data.y))
                      .toList(),
                  isCurved: true,
                  dotData: FlDotData(show: true),
                  gradient: LinearGradient(colors: gradientColors),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                        colors: gradientColors
                            .map((e) => e.withOpacity(0.3))
                            .toList()),
                  ),
                )
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
                  border: Border.all(color: Colors.grey.shade300), show: true),
            ),
          ),
        ),
      ],
    );
  }
}
