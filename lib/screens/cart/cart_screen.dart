import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/components/coustom_bottom_nav_bar.dart';
import 'package:untitled1/enums.dart';

import 'components/Quan_ly_don_hang_screen/quan_ly_don_hang_body.dart';

class CartScreen extends HookConsumerWidget {
  static String routeName = "/CartScreen";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restart = useState(true);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // appBar: buildAppBar(context),
      body: QuanLyDonHang(
        restartFunc: () {
          restart.value = !restart.value;
        },
      ),
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: MenuState.favourite),
      // bottomNavigationBar: CheckoutCard(),
    );
  }

  // AppBar buildAppBar(BuildContext context) {
  //   return AppBar(
  //     title: Text(
  //       "Đơn Hàng",
  //       style: TextStyle(color: Colors.black),
  //     ),
  //   );
  // }
}
