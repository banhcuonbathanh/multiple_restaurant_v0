import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';

import 'bieu_do.dart';

class HomQuaBody extends HookConsumerWidget {
  const HomQuaBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonIndex = useState(0);

    return ListView(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      shrinkWrap: true,
      children: [
        RowNumber1(buttonIndex: buttonIndex),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        RowNumber2(buttonIndex: buttonIndex),
        Divider(),
        BieuDo(),
      ],
    );
  }
}

class RowNumber2 extends StatelessWidget {
  const RowNumber2({
    Key? key,
    required this.buttonIndex,
  }) : super(key: key);

  final ValueNotifier<int> buttonIndex;

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
            child: Text(''),
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
  }) : super(key: key);

  final ValueNotifier<int> buttonIndex;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: ChiSoQuanTrongDonHang(
              title: 'don hang',
              soLuong: 0,
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
              soLuong: 0,
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
  final int soLuong;
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
              Spacer(),
              Text(soLuong.toString()),
              // Text('   0 %'),
            ],
          ),
        ),
      ),
    );
  }
}
