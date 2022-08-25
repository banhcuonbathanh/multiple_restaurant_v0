import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/enums.dart';

import 'package:untitled1/screens/manage_restaurant/dat_hang/1dat_hang_body.dart';

import '../../components/coustom_bottom_nav_bar.dart';
import '../edit_screen/edit_product_body.dart';
import 'da_xac_nhan/1da_xac_nhan_body.dart';
import 'doanh_thu/doanh_thu.dart';
import 'hoan_thanh/1hoan_thanh_body.dart';
import 'huy/1huy_body.dart';
import 'phan_tich_ban_hang/phan_tich_ban_hang.dart';
import 'restaurant_own_infomration/restaurant_owner_infomraiton.dart';

class ManageRestaurantBody extends HookConsumerWidget {
  static String routeName = "/Manage_Restaurant_Body";
  const ManageRestaurantBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(AppStateProvider.userNotifier);
    final orders = ref.watch(AppStateProvider.orderTestNotifier).values;
    final ordersXacNhan = orders
        .where((element) => element.BuyingUserId == userData!.userId)
        .where((element) => element.statusOrder == 'da xac nhan')
        .toList();
    final ordersHoanThanh = orders
        .where((element) => element.BuyingUserId == userData!.userId)
        .where((element) => element.statusOrder == 'hoan thanh')
        .toList();
    final ordersHuy = orders
        .where((element) => element.BuyingUserId == userData!.userId)
        .where((element) => element.statusOrder == 'huy')
        .toList();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          shrinkWrap: true,
          children: [
            RestaurantOwnerInformation(userData: userData),
            Divider(),
            DefaultRow(
              rowName: 'Đơn Đặt Hàng',
              pushNamed: () {
                Navigator.pushNamed(
                    context, DatHangBodyamnagerRestaurant.routeName);
              },
            ),
            DefaultRow(
              rowName: 'Đã Xác Nhận',
              pushNamed: () async {
                if (ordersXacNhan.length < 3) {
                  final orderTest = await ref
                      .read(AppStateProvider.orderTestNotifier.notifier)
                      .searchingorderByBuyingUserId(
                          BuyingUserId: userData!.userId!,
                          numberOfOrder: 0,
                          page: 0,
                          statusOrder: 'xac nhan');
                }
                Navigator.pushNamed(
                    context, DaXacNhanBodyamnagerRestaurant.routeName);
              },
            ),
            DefaultRow(
              rowName: 'đơn hàng hoàn thành',
              pushNamed: () async {
                if (ordersHoanThanh.length < 3) {
                  final orderTest = await ref
                      .read(AppStateProvider.orderTestNotifier.notifier)
                      .searchingorderByBuyingUserId(
                          BuyingUserId: userData!.userId!,
                          numberOfOrder: 0,
                          page: 0,
                          statusOrder: 'hoan thanh');
                }
                Navigator.pushNamed(
                    context, HoanThanhBodyamnagerRestaurant.routeName);
              },
            ),
            DefaultRow(
              rowName: 'đơn hàng huỷ',
              pushNamed: () async {
                if (ordersHuy.length < 3) {
                  final orderTest = await ref
                      .read(AppStateProvider.orderTestNotifier.notifier)
                      .searchingorderByBuyingUserId(
                          BuyingUserId: userData!.userId!,
                          numberOfOrder: 0,
                          page: 0,
                          statusOrder: 'huy');
                }
                Navigator.pushNamed(
                    context, HuyBodyamnagerRestaurant.routeName);
              },
            ),
            DefaultRow(
              subText: '14',
              rowName: 'Người Theo Dõi: ',
              pushNamed: () {
                // Navigator.pushNamed(context, EditProduct.routeName);
              },
            ),
            DefaultRow(
              rowName: 'Nhà Hàng',
              pushNamed: () {
                Navigator.pushNamed(context, EditProduct.routeName);
              },
            ),
            DefaultRow(
              rowName: 'Doanh Thu',
              pushNamed: () {
                Navigator.pushNamed(context, DoanhThu.routeName);
              },
            ),
            DefaultRow(
              rowName: 'Phân tích bán hàng',
              pushNamed: () {
                Navigator.pushNamed(context, PhanTichBanHang.routeName);
              },
            ),
            DefaultRow(
              rowName: 'Hiệu quả hoạt động',
              pushNamed: () {
                // Navigator.pushNamed(context, EditProduct.routeName);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.message),
    );
  }
}

class DefaultRow extends StatelessWidget {
  final String rowName;
  final String? subText;
  final Function pushNamed;
  const DefaultRow({
    Key? key,
    required this.rowName,
    required this.pushNamed,
    this.subText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(rowName),
        if (subText != null) Text(subText!),
        Spacer(),
        IconButton(
            onPressed: () {
              pushNamed();
            },
            icon: Icon(Icons.chevron_right))
      ],
    );
  }
}