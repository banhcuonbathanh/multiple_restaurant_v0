import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:untitled1/app_provider/state_provider.dart';

import 'package:untitled1/model/order_model.dart';

import '../../../../../size_config.dart';
import '2donhang.dart';

class HuyBodyamnagerRestaurant extends HookConsumerWidget {
  static String routeName = "/HuyBodyamnagerRestaurant";
  const HuyBodyamnagerRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restart = useState(true);
    restartFunc() {
      restart.value = !restart.value;
    }

    final userData = ref.watch(AppStateProvider.userNotifier);
    final orders = ref
        .watch(AppStateProvider.orderTestNotifier)
        .values
        .toList()
        .where((element) => element.BuyingUserId == userData!.userId!)
        .toList();

    final isShowListOrder = useState(true);
    int compareString(
        {required bool ascending,
        required String value1,
        required String value2}) {
      return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
    }

    List<DataCell> getcells({required List<dynamic> cells}) {
      return cells.map((e) => DataCell(Text('$e'))).toList();
    }

    List<DataRow> getRows({required List<OrderModel> orders}) {
      return orders.map((e) {
        final cells = [e.address, e.day, e.statusOrder];
        return DataRow(
            // onSelectChanged: (value) {},

            cells: getcells(cells: cells));
      }).toList();
    }
    // -----------------------

    ScrollController scroller = ScrollController();
    final hasMoreData = useState<bool>(true);
    final ordersDatHang = ref
        .watch(AppStateProvider.orderTestNotifier)
        .values
        .where((element) => element.BuyingUserId == userData!.userId!)
        .where((element) => element.statusOrder == 'huy')
        .toList();
    final isShowLoadingToFetch = useState(true);
    final page = useState<int>(1);
    bool isLodingMore = false;
    Future<void> refresh() async {
      if (isLodingMore) return;

      isLodingMore = true;

      final orderTest = await ref
          .read(AppStateProvider.orderTestNotifier.notifier)
          .searchingorderByBuyingUserId(
            BuyingUserId: userData!.userId!,
            numberOfOrder: ordersDatHang.length,
            page: page.value,
            statusOrder: 'huy',
          );
      if (orderTest.length < 1) {
        hasMoreData.value = false;
      }
      isLodingMore = false;
      page.value = page.value + 1;
    }

    scroller.addListener(() {
      if (scroller.offset == scroller.position.maxScrollExtent) {
        isShowLoadingToFetch.value = true;
        refresh();
      } else {
        isShowLoadingToFetch.value = false;
      }
    });
    // --------------------------
    return Scaffold(
      appBar: AppBar(
        title: Text('Đơn Hàng Huỷ', style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scroller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -------------

              for (int index = 0; index < ordersDatHang.length; index++)
                DonHang(
                  orders: ordersDatHang[index],
                ),
              SizedBox(
                width: getProportionateScreenWidth(10),
              ),
              if (!isShowLoadingToFetch.value)
                Center(
                  child: hasMoreData.value
                      ? CircularProgressIndicator()
                      : Text('no data to load'),
                ),
              // --------
              // ListView.builder(
              //     shrinkWrap: true,
              //     primary: false,
              //     itemCount: orders.length,
              //     itemBuilder: (context, index) {
              //       final order = orders[index];
              //       return DonHang(
              //         orders: order,
              //       );
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
