import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/model/order_model.dart';
import 'package:untitled1/size_config.dart';

import 'bieu_do_line.dart';
import 'pie_chart.dart';

class AnalyticScreen extends HookConsumerWidget {
  const AnalyticScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAnalytic =
        ref.watch(AppStateProvider.orderAnalytic).values.toList();
    DateTime fromDate =
        ref.read(AppStateProvider.orderAnalytic.notifier).fromDate;
    DateTime toDate = ref.read(AppStateProvider.orderAnalytic.notifier).toDate;
    String bieuDoType =
        ref.read(AppStateProvider.orderAnalytic.notifier).bieuDoType;
    int indefferentHour =
        ref.read(AppStateProvider.orderAnalytic.notifier).inDefferentHour;
    List<String> caseValue = List<String>.generate(
        6, (index) => (indefferentHour / (6) * (index + 1)).toString());

    final test =
        DateTime.parse(orderAnalytic.last.day).difference(fromDate).inHours;
    List<String> listX = List<String>.generate(
        orderAnalytic.length, (index) => orderAnalytic[index].day);
    print(fromDate);
    print('test');
    print(test);
    final buttonIndex = useState(0);

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
        Text(fromDate.toString()),
        Text(toDate.toString()),
        Text(indefferentHour.toString()),
        Text(caseValue.toString()),
        if (orderAnalytic.length > 0) Text(orderAnalytic.last.day),
        Divider(),
        BieuDoLine(
          maxX: 12,
          maxY: 10,
          minX: 0,
          minY: 0,
          title: 'bieu do so luond don hang theo: ${bieuDoType}',
          listy: [2, 10, 4, 8, 6, 7, 8],
          listx: [0, 1.5, 4, 6, 8, 10, 12],
          caseValue: caseValue,
        ),
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
