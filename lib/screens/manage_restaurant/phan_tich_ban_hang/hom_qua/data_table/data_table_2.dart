import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/model/order_model.dart';
import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/size_config.dart';

class DataTableCustomer2 extends HookConsumerWidget {
  final List<OrderModel> orderAnalitic;
  const DataTableCustomer2({Key? key, required this.orderAnalitic})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restart = useState(true);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: IntrinsicWidth(
        child: Column(
          children: [
            RowTitle(
              rowHeight: 30,
              rowWith: 150,
              listContend: [
                '',
                'nguoi mua',
                'thoi gian giao hang',
                'Trang thai',
                'thoi gian dat hang',
                'So san pham dat hang',
              ],
              listProductDetail: [],
              sortOrderAnaliticThoiGianDatHang: () {},
              callback: (String val) {
                if (val == 'thoi gian dat hang') {
                  orderAnalitic.sort((a, b) {
                    return a.createAt.compareTo(b.createAt);
                  });
                  restart.value = !restart.value;
                }

                if (val == 'thoi gian giao hang') {
                  orderAnalitic.sort((a, b) {
                    return a.day.compareTo(b.day);
                  });
                  restart.value = !restart.value;
                }
                if (val == 'Trang thai') {
                  orderAnalitic.sort((a, b) {
                    return a.statusOrder.compareTo(b.statusOrder);
                  });
                  restart.value = !restart.value;
                }
                if (val == 'nguoi mua') {
                  orderAnalitic.sort((a, b) {
                    return a.BuyingUserName.compareTo(b.BuyingUserName);
                  });
                  restart.value = !restart.value;
                }
              },
            ),
            for (int index = 0; index < orderAnalitic.length; index++)
              RowTitle(
                rowHeight: 30,
                rowWith: 150,
                listContend: [
                  (index + 1).toString(),
                  orderAnalitic[index].BuyingUserName,
                  DateFormat('yyyy-MM-dd hh:mm')
                      .format(DateTime.parse(orderAnalitic[index].day)),

                  // '${orderAnalitic[index].hour} : ${orderAnalitic[index].minute} ',
                  orderAnalitic[index].statusOrder,
                  DateFormat('dd/MM - kk:mm')
                      .format(DateTime.parse(orderAnalitic[index].createAt)),
                ],
                listProductDetail: orderAnalitic[index].productdetailsIdList,
                sortOrderAnaliticThoiGianDatHang: () {},
                callback: (String val) {},
              ),
            // RowTitle(
            //   row1: 20,
            //   rowHeight: 40,
            //   rowWith: 210,
            // ),
          ],
        ),
      ),
    );
  }
}

typedef void StringCallback(String val);

class RowTitle extends StatelessWidget {
  const RowTitle({
    Key? key,
    required this.rowHeight,
    required this.rowWith,
    required this.listContend,
    required this.listProductDetail,
    required this.sortOrderAnaliticThoiGianDatHang,
    required this.callback,
  }) : super(key: key);
  final double rowHeight;
  final double rowWith;
  final Function sortOrderAnaliticThoiGianDatHang;
  final List<String> listContend;
  final List<ProductDetailModel> listProductDetail;
  final StringCallback callback;
  @override
  Widget build(BuildContext context) {
    int totalProductDetail = 0;
    if (listProductDetail.length > 0) {
      for (var productdetail in listProductDetail) {
        totalProductDetail =
            totalProductDetail + productdetail.productdetailQuantity!.toInt();
      }
      listContend.add(totalProductDetail.toString());
    }

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(
              listContend.length,
              (index) => Acell2(
                  rowWith: rowWith,
                  rowHeight: rowHeight,
                  condtend: listContend[index],
                  index: index,
                  sortOrderAnaliticThoiGianDatHang: () {
                    callback(listContend[index]);
                  }),
            )
          ],
        ),
        Container(
          height: getProportionateScreenHeight(1),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle, color: Colors.grey.shade400),
        ),
      ],
    );
  }
}

class Acell2 extends StatelessWidget {
  const Acell2({
    Key? key,
    required this.rowWith,
    required this.rowHeight,
    required this.condtend,
    required this.index,
    required this.sortOrderAnaliticThoiGianDatHang,
  }) : super(key: key);

  final double rowWith;
  final double rowHeight;
  final String condtend;
  final int index;
  final Function sortOrderAnaliticThoiGianDatHang;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        sortOrderAnaliticThoiGianDatHang();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          border:
              Border(left: BorderSide(width: 1, color: Colors.grey.shade200)),
        ),
        alignment: Alignment.center,
        width: getProportionateScreenWidth(index == 0 ? 25 : rowWith),
        height: getProportionateScreenHeight(rowHeight),
        child: Text(condtend),
      ),
    );
  }
}
