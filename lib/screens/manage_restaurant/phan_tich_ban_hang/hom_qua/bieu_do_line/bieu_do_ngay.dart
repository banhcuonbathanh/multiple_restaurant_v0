import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/model/Spot_mode.dart';
import 'package:untitled1/model/order_model.dart';

import '../../../../../size_config.dart';

class BieuDoLineNgay extends StatelessWidget {
  const BieuDoLineNgay(
      {Key? key,
      required this.fromDate,
      required this.toDate,
      // required this.listMapX,
      // required this.listMapY1,
      required this.DateandDay,
      required this.orderAnalytic,
      required this.bieuDoType})
      : super(key: key);

  final DateTime fromDate;
  final DateTime toDate;
  final List<OrderModel> orderAnalytic;
  final String bieuDoType;
  // final List<double> listMapX;
  // final List<double> listMapY1;
  final Map<double, DateTime> DateandDay;
  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];

    final List<double> listX = [0, 3, 6, 9, 12, 15, 18, 21, 24];
    final List<double> listY = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

    // --------------------
    //List Hour in orderIndex
    final List<double> listHourInOrderAnalitic = [];
    for (var i in orderAnalytic) {
      final tem = DateFormat("hh").format(DateTime.parse(i.createAt));
      listHourInOrderAnalitic.add(double.parse(tem));
    }

    // to add to List Y

    for (int index = 0; index < listHourInOrderAnalitic.length; index++) {
      double y0 = listY[0];
      double y1 = listY[1];
      double y2 = listY[2];
      double y3 = listY[3];
      double y4 = listY[4];
      double y5 = listY[5];
      double y6 = listY[6];
      double y7 = listY[7];

      if (0 < listHourInOrderAnalitic[index] &&
          listHourInOrderAnalitic[index] <= 3) {
        listY[0] = y0 + 1.toDouble();
      } else if (3 < listHourInOrderAnalitic[index] &&
          listHourInOrderAnalitic[index] <= 6) {
        listY[1] = y1 + 1.toDouble();
      } else if (6 < listHourInOrderAnalitic[index] &&
          listHourInOrderAnalitic[index] <= 9) {
        listY[2] = y2 + 1.toDouble();
      } else if (9 < listHourInOrderAnalitic[index] &&
          listHourInOrderAnalitic[index] <= 12) {
        listY[3] = listY[3] + 1.toDouble();
      } else if (12 < listHourInOrderAnalitic[index] &&
          listHourInOrderAnalitic[index] <= 15) {
        listY[4] = listY[4] + 1.toDouble();
      } else if (15 < listHourInOrderAnalitic[index] &&
          listHourInOrderAnalitic[index] <= 18) {
        listY[5] = listY[5] + 1.toDouble();
      } else if (18 < listHourInOrderAnalitic[index] &&
          listHourInOrderAnalitic[index] <= 21) {
        listY[6] = listY[6] + 1.toDouble();
      } else if (21 < listHourInOrderAnalitic[index] &&
          listHourInOrderAnalitic[index] <= 24) {
        listY[7] = listY[7] + 1.toDouble();
      }
    }
    // --------------------------------

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('bieu do ngay :'),
        SizedBox(
          height: getProportionateScreenWidth(15),
        ),
        Container(
          height: 350,
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
                      interval: 3,
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) {
                        final ListY = DateandDay.values.toList();
                        String addInform = '';
                        if (bieuDoType == 'gio' && value == 0.0) {
                          addInform = 'A.M';
                        }
                        // final keys = DateandDay.keys.toList();
                        // String value1 = '';
                        // value1 = DateFormat('dd')
                        //     .format(DateandDay[value.toDouble()]!);

                        return Column(
                          children: [
                            Text(
                                bieuDoType == 'gio' && value == 0.0
                                    ? '${value.toString()} AM'
                                    : value.toString(),
                                style: bieuDoType == 'gio' && value == 0.0
                                    ? TextStyle(color: Colors.red, fontSize: 10)
                                    : TextStyle()),
                            if (bieuDoType == 'gio' && value == 0.0)
                              Text(DateFormat('dd-MM').format(fromDate))
                          ],
                        );
                      }),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: SpotData.spotData(dataX: listX, dataY: listY)
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
