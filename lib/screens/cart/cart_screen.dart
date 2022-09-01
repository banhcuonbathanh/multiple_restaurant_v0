import 'package:flutter/material.dart';
import 'package:untitled1/components/coustom_bottom_nav_bar.dart';
import 'package:untitled1/enums.dart';

import 'components/Quan_ly_don_hang_screen/quan_ly_don_hang_body.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/CartScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // appBar: buildAppBar(context),
      body: QuanLyDonHang(),
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
