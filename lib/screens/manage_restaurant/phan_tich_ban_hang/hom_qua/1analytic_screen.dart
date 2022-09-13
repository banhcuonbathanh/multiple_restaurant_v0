import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/model/order_model.dart';
import 'package:untitled1/size_config.dart';

import 'bieu_do_line/bieu_do_2_tuan.dart';
import 'bieu_do_line/bieu_do_ngay.dart';
import 'data_table/data_table.dart';
import 'data_table/data_table_2.dart';
import 'pie_chart.dart';
import 'scatter chart/scatter_chart.dart';

class AnalyticScreen extends HookConsumerWidget {
  const AnalyticScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonIndex = useState(0);
    final orderAnalytic =
        ref.watch(AppStateProvider.orderAnalytic).values.toList();
    DateTime fromDate =
        ref.read(AppStateProvider.orderAnalytic.notifier).fromDate;
    DateTime toDate = ref.read(AppStateProvider.orderAnalytic.notifier).toDate;
    String bieuDoType =
        ref.read(AppStateProvider.orderAnalytic.notifier).bieuDoType;
    int indefferentHour =
        ref.read(AppStateProvider.orderAnalytic.notifier).inDefferentHour;

    final orderLength = orderAnalytic.length;

    // ----------------------------
    // theo khoang gio
    List<double> listXDefferentFromHour = List<double>.generate(
        orderAnalytic.length,
        (index) => DateTime.parse(orderAnalytic[index].createAt)
            .difference(fromDate)
            .inHours
            .toDouble());
    print('indefferentHour');
    print(indefferentHour);
// --------------
// day of order
    List<double> listXDayOfOrderAnalitic = [];
    for (var i in orderAnalytic) {
      listXDayOfOrderAnalitic.add(DateTime.parse(i.createAt).day.toDouble());
    }
    // -----------------
    List<DateTime> listXDateInOrder = [];
    for (var i in orderAnalytic) {
      final temp = DateFormat('yyyy-MM-dd').format(DateTime.parse(i.createAt));

      listXDateInOrder.add(DateTime.parse(i.createAt));
    }
    //  create map from from date to date

    List<DateTime> listDateFromDateToDate = ref
        .read(AppStateProvider.orderAnalytic.notifier)
        .makeListDateFromDateToDate();
    // Map<double, DateTime> DateandDayFromToDate = {};
    // listDateFromDateToDate.forEach((Element) {
    //   DateandDayFromToDate.putIfAbsent((Element).day.toDouble(), () => Element);
    // });
    Map<double, DateTime> mapDayandDateFromToDate = ref
        .read(AppStateProvider.orderAnalytic.notifier)
        .mapDayandDateFromToDate(
            listDateFromDateToDate: listDateFromDateToDate);
    // -------------------------------
    // ----------
// couting number of the same day
    // Map<double, double> coutingSameDay = {};
    // List<double> keysofDateandDayFromToDate =
    //     mapDayandDateFromToDate.keys.toList();
    // keysofDateandDayFromToDate.forEach((element) {
    //   coutingSameDay[element] = 0.0;
    // });
    final listYCoutingSameDay2Week = ref
        .read(AppStateProvider.orderAnalytic.notifier)
        .listYCoutingSameDay(
            mapDayandDateFromToDate: mapDayandDateFromToDate,
            mapDayandDateFromToDate1: mapDayandDateFromToDate);

    listXDayOfOrderAnalitic.forEach((element) {
      if (!listYCoutingSameDay2Week.containsKey(element)) {
        listYCoutingSameDay2Week[element.toDouble()] = 1.toDouble();
      } else {
        listYCoutingSameDay2Week[element.toDouble()] =
            listYCoutingSameDay2Week[element]! + 1;
      }
    });
    // print('coutingSameDay');
    // print(listYCoutingSameDay);
    List<double> listMapX = listYCoutingSameDay2Week.keys.toList();
    // List<double> listXTest0ToLeng = [];
    // for (int index = 0; index < listDateFromDateToDate.length; index++) {
    //   listXTest0ToLeng.add(index.toDouble());
    // }
    List<double> listX = ref
        .read(AppStateProvider.orderAnalytic.notifier)
        .listX(listDateFromDateToDate: listDateFromDateToDate);
    List<double> listMapY = listYCoutingSameDay2Week.values.toList();
    // ----
// Map day, day in detail
    // Map<double, DateTime> DateandDayOfOrder = {};

    // orderAnalytic.forEach((Element) {
    //   DateandDayOfOrder.putIfAbsent(
    //       DateTime.parse(Element.createAt).day.toDouble(),
    //       () => DateTime.parse(Element.createAt));
    // });

    // ------------------------------

    // print('listDateFromDateToDate');
    // print(listDateFromDateToDate);
    // // ------------------------------------
    // print('listMapX');
    // print(listMapX);
    // print('listMapY');
    // print(listMapY);

    // print('listXDayDate');
    // print(listXDayOfOrderAnalitic);
    // print('DateandDayFromToDate');
    // print(mapDayandDateFromToDate);
    // print(fromDate);
    // print('test');
    // print(test);

    return ListView(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      shrinkWrap: true,
      children: [
        RowNumber1(
          buttonIndex: buttonIndex,
          orderAnalytic: orderAnalytic,
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        RowNumber2(
          buttonIndex: buttonIndex,
          orderAnalytic: orderAnalytic,
        ),
        Divider(),
        if (orderAnalytic.length > 0 &&
            (indefferentHour / 24) < 13 &&
            (indefferentHour / 24) > 1)
          BieuDo2Tuan(
            fromDate: fromDate,
            toDate: toDate,
            listMapX: listX,
            listMapY: listMapY,
            DateandDay: mapDayandDateFromToDate,
          ),
        if (orderAnalytic.length > 0 && (indefferentHour / 24) == 1)
          BieuDoNgay(
            fromDate: fromDate,
            toDate: toDate,
            // listMapX: listX,
            // listMapY: listMapY,
            DateandDay: mapDayandDateFromToDate, orderAnalytic: orderAnalytic,
            bieuDoType: bieuDoType,
          ),
        // DataTableCustomer(
        //   orderAnalitic: orderAnalytic,
        // ),
        DataTableCustomer2(
          orderAnalitic: orderAnalytic,
        ),
        ScatterChartSample2(),
        Pie_chart(),
      ],
    );
  }
}

class RowNumber2 extends StatelessWidget {
  const RowNumber2({
    Key? key,
    required this.buttonIndex,
    required this.orderAnalytic,
  }) : super(key: key);

  final ValueNotifier<int> buttonIndex;
  final List<OrderModel>? orderAnalytic;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: ChiSoQuanTrongDonHang(
              title: 'Luot truy cap',
              soLuong: 0,
              rowIndex: 3,
              buttonFunction: () {
                buttonIndex.value = 3;
              },
              buttonIndex: buttonIndex.value,
            ),
          ),
          Expanded(
            child: ChiSoQuanTrongDonHang(
              buttonIndex: buttonIndex.value,
              title: 'luot xem trang',
              soLuong: 0,
              rowIndex: 4,
              buttonFunction: () {
                buttonIndex.value = 4;
              },
            ),
          ),
          Expanded(
            child: ChiSoQuanTrongDonHang(
              buttonIndex: buttonIndex.value,
              title: 'doanh so',
              soLuong: 0,
              rowIndex: 5,
              buttonFunction: () {
                buttonIndex.value = 5;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RowNumber1 extends StatelessWidget {
  const RowNumber1({
    Key? key,
    required this.buttonIndex,
    required this.orderAnalytic,
  }) : super(key: key);

  final ValueNotifier<int> buttonIndex;
  final List<OrderModel>? orderAnalytic;
  @override
  Widget build(BuildContext context) {
    double totalDoanhThu = 0;
    if (orderAnalytic != null) {
      for (var i in orderAnalytic!) {
        for (var j in i.productdetailsIdList) {
          totalDoanhThu = j.productdetailBill! + totalDoanhThu;
        }
      }
    }
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: ChiSoQuanTrongDonHang(
              title: 'don hang',
              soLuong:
                  orderAnalytic != null ? orderAnalytic!.length.toDouble() : 0,
              rowIndex: 0,
              buttonFunction: () {
                buttonIndex.value = 0;
              },
              buttonIndex: buttonIndex.value,
            ),
          ),
          Expanded(
            child: ChiSoQuanTrongDonHang(
              buttonIndex: buttonIndex.value,
              title: 'doanh so',
              soLuong: totalDoanhThu,
              rowIndex: 1,
              buttonFunction: () {
                buttonIndex.value = 1;
              },
            ),
          ),
          Expanded(
            child: ChiSoQuanTrongDonHang(
              buttonIndex: buttonIndex.value,
              title: 'ti le chuyen doi',
              soLuong: 0,
              rowIndex: 2,
              buttonFunction: () {
                buttonIndex.value = 2;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChiSoQuanTrongDonHang extends StatelessWidget {
  final String title;
  final double soLuong;
  final int rowIndex;
  final Function buttonFunction;
  final int buttonIndex;
  const ChiSoQuanTrongDonHang({
    Key? key,
    required this.title,
    required this.soLuong,
    required this.rowIndex,
    required this.buttonFunction,
    required this.buttonIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
      child: GestureDetector(
        onTap: () {
          buttonFunction();
        },
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          decoration: BoxDecoration(
              border: Border.all(
                  color: rowIndex == buttonIndex
                      ? Colors.red.shade300
                      : Colors.grey.shade300)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
              ),

              Center(child: Text(soLuong.toString())),
              // Text('   0 %'),
            ],
          ),
        ),
      ),
    );
  }
}
