import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/model/Spot_mode.dart';
import 'package:untitled1/model/order_model.dart';

class ScatterChartNgay extends StatelessWidget {
  const ScatterChartNgay(
      {Key? key,
      required this.fromDate,
      required this.toDate,
      required this.orderAnalytic,
      required this.bieuDoType,
      required this.DateandDay})
      : super(key: key);
  final DateTime fromDate;
  final DateTime toDate;
  final List<OrderModel> orderAnalytic;
  final String bieuDoType;
  final Map<double, DateTime> DateandDay;

  @override
  Widget build(BuildContext context) {
    Map<DateTime, Map<DateTime, int>> test = {
      DateTime.now(): {DateTime.now(): 1}
    };
    test[DateTime.now()] = {DateTime.now(): 2};
    print('test');
    print(test);
    int touchedIndex = -1;

    Color greyColor = Colors.grey;
    // --------------------------------
    final List<double> listX = [0, 3, 6, 9, 12, 15, 18, 21, 24];
    final List<double> listY = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

    // --------------------
    //List Hour in orderIndex
    final List<double> listHourInOrderAnalitic = [];
    for (var i in orderAnalytic) {
      final tem = DateFormat("hh").format(DateTime.parse(i.createAt));
      listHourInOrderAnalitic.add(double.parse(tem));
    }

    // --------------------------------
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
    List<int> selectedSpots = [];
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        // color: Colors.blue.shade200,
        child: ScatterChart(
          ScatterChartData(
            scatterSpots: SpotData.spotDataScatter(dataX: listX, dataY: listY),
            // minX: 0,
            // maxX: 24,
            // minY: 0,
            // maxY: 10,
            borderData: FlBorderData(
              show: false,
            ),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              checkToShowHorizontalLine: (value) => true,
              getDrawingHorizontalLine: (value) =>
                  FlLine(color: Colors.grey.withOpacity(0.1)),
              drawVerticalLine: true,
              checkToShowVerticalLine: (value) => true,
              getDrawingVerticalLine: (value) =>
                  FlLine(color: Colors.grey.withOpacity(0.1)),
            ),
            titlesData: FlTitlesData(
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
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
                      })),
            ),
            showingTooltipIndicators: selectedSpots,
            scatterTouchData: ScatterTouchData(
              enabled: true,
              handleBuiltInTouches: false,
              mouseCursorResolver:
                  (FlTouchEvent touchEvent, ScatterTouchResponse? response) {
                return response == null || response.touchedSpot == null
                    ? MouseCursor.defer
                    : SystemMouseCursors.click;
              },
              touchTooltipData: ScatterTouchTooltipData(
                tooltipBgColor: Colors.black,
                getTooltipItems: (ScatterSpot touchedBarSpot) {
                  return ScatterTooltipItem(
                    'X: ',
                    textStyle: TextStyle(
                      height: 1.2,
                      color: Colors.grey[100],
                      fontStyle: FontStyle.italic,
                    ),
                    bottomMargin: 10,
                    children: [
                      TextSpan(
                        text: '${touchedBarSpot.x.toInt()} \n',
                        style: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Y: ',
                        style: TextStyle(
                          height: 1.2,
                          color: Colors.grey[100],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      TextSpan(
                        text: touchedBarSpot.y.toInt().toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
              touchCallback:
                  (FlTouchEvent event, ScatterTouchResponse? touchResponse) {
                if (touchResponse == null ||
                    touchResponse.touchedSpot == null) {
                  return;
                }
                if (event is FlTapUpEvent) {
                  final sectionIndex = touchResponse.touchedSpot!.spotIndex;
                  // setState(() {
                  //   if (selectedSpots.contains(sectionIndex)) {
                  //     selectedSpots.remove(sectionIndex);
                  //   } else {
                  //     selectedSpots.add(sectionIndex);
                  //   }
                  // });
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
