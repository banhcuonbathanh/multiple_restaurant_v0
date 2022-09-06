import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/enums.dart';
import 'package:untitled1/screens/home/home_screen.dart';

import 'package:untitled1/size_config.dart';

import '../../app_api/local_notification.dart';
import '../../components/coustom_bottom_nav_bar.dart';
import '../edit_screen/edit_product_body.dart';
import 'da_xac_nhan/1da_xac_nhan_body.dart';

import 'doanh_thu/doanh_thu.dart';

import 'don_hang/don_hang_body.dart';

import 'don_hang/huy/1huy_body.dart';
import 'phan_tich_ban_hang/phan_tich_ban_hang.dart';
import 'restaurant_own_infomration/restaurant_owner_infomraiton.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ManageRestaurantBody extends HookConsumerWidget {
  static String routeName = "/Manage_Restaurant_Body";
  const ManageRestaurantBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //----------------------
    // show nitification

    late final LocalNotificationService service;
    void onNotificationListner(String? payLoad) {
      // if (payLoad != null && payLoad.isNotEmpty) {
      //   print(payLoad);
      // }
      Navigator.pushNamed(context, HomeScreen.routeName);
    }

    void listenToNotification() =>
        service.onNotificationClick.stream.listen(onNotificationListner);
    useEffect(() {
      service = LocalNotificationService();
      service.intialize();
    });
    // ----------------------------------
    // socket io
    late io.Socket socket;
    void connectAndListen() {
      socket = io.io('http://127.0.0.1:3000',
          OptionBuilder().setTransports(['websocket']).build());

      socket.onConnect((_) {});
      socket.on('receiveOrder', (data) async {
        await service.showNotification(
            id: 0,
            title: ' notiication titleZSdasdasdada',
            body: ' some nidyawfasdfsdfsadfsd');
      });

      socket.onDisconnect((_) => print('disconnect'));
    }

    useEffect(() {
      connectAndListen();
      return () {};
    });
    // ---------------------------
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
    final orderDatHang = orders
        .where((element) => element.BuyingUserId == userData!.userId)
        .where((element) => element.statusOrder == 'dat hang')
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
              rowName: 'Đơn Hàng: ',
              subText: orderDatHang.length.toString(),
              pushNamed: () async {
                Navigator.pushNamed(context, DonHangBody.routeName);
              },
              imageAsset: 'assets/icons/click-mobile-phone-2406.png',
            ),
            Divider(),
            // DefaultRow(
            //   rowName: 'Đã Xác Nhận',
            //   pushNamed: () async {
            //     if (ordersXacNhan.length < 3) {
            //       final orderTest = await ref
            //           .read(AppStateProvider.orderTestNotifier.notifier)
            //           .searchingorderByBuyingUserId(
            //               BuyingUserId: userData!.userId!,
            //               numberOfOrder: 0,
            //               page: 0,
            //               statusOrder: 'xac nhan');
            //     }
            //     Navigator.pushNamed(
            //         context, DaXacNhanBodyamnagerRestaurant.routeName);
            //   },
            //   imageAsset: 'assets/icons/NicePng_recipe-icon-png_385397.png',
            // ),
            // Divider(),
            // DefaultRow(
            //   rowName: 'đơn hàng hoàn thành',
            //   pushNamed: () async {
            //     if (ordersHoanThanh.length < 3) {
            //       final orderTest = await ref
            //           .read(AppStateProvider.orderTestNotifier.notifier)
            //           .searchingorderByBuyingUserId(
            //               BuyingUserId: userData!.userId!,
            //               numberOfOrder: 0,
            //               page: 0,
            //               statusOrder: 'hoan thanh');
            //     }
            //     // Navigator.pushNamed(
            //     //     context, HoanThanhBodyamnagerRestaurant.routeName);
            //   },
            //   imageAsset:
            //       'assets/icons/1000_F_316303014_qzT0VBwBMuIDOzTjEpvcuKvIoEo0Yz1E.jpg',
            // ),
            // Divider(),
            // DefaultRow(
            //   rowName: 'đơn hàng huỷ',
            //   pushNamed: () async {
            //     if (ordersHuy.length < 3) {
            //       final orderTest = await ref
            //           .read(AppStateProvider.orderTestNotifier.notifier)
            //           .searchingorderByBuyingUserId(
            //               BuyingUserId: userData!.userId!,
            //               numberOfOrder: 0,
            //               page: 0,
            //               statusOrder: 'huy');
            //     }
            //   },
            //   imageAsset:
            //       'assets/icons/1000_F_316303014_qzT0VBwBMuIDOzTjEpvcuKvIoEo0Yz1E.jpg',
            // ),
            Divider(),
            DefaultRow(
              subText: '14',
              rowName: 'Người Theo Dõi: ',
              pushNamed: () {
                // Navigator.pushNamed(context, EditProduct.routeName);
              },
              imageAsset: 'assets/icons/Screen Shot 2022-08-26 at 14.26.17.png',
            ),
            Divider(),
            DefaultRow(
              rowName: 'Nhà Hàng',
              pushNamed: () {
                Navigator.pushNamed(context, EditProduct.routeName);
              },
              imageAsset: 'assets/icons/Screen Shot 2022-08-26 at 14.26.17.png',
            ),
            Divider(),
            DefaultRow(
              rowName: 'Doanh Thu',
              pushNamed: () {
                Navigator.pushNamed(context, DoanhThu.routeName);
              },
              imageAsset: 'assets/icons/Screen Shot 2022-08-26 at 14.26.17.png',
            ),
            Divider(),
            DefaultRow(
              rowName: 'Phân tích bán hàng',
              pushNamed: () {
                Navigator.pushNamed(context, PhanTichBanHang.routeName);
              },
              imageAsset: 'assets/icons/Screen Shot 2022-08-26 at 14.26.17.png',
            ),
            Divider(),
            DefaultRow(
              rowName: 'Hiệu quả hoạt động',
              pushNamed: () {
                // Navigator.pushNamed(context, EditProduct.routeName);
              },
              imageAsset: 'assets/icons/Screen Shot 2022-08-26 at 14.26.17.png',
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
  final String imageAsset;
  const DefaultRow({
    Key? key,
    required this.rowName,
    required this.pushNamed,
    this.subText,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNamed();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(5)),
        child: Row(
          children: [
            Image.asset(
              imageAsset,
              height: getProportionateScreenHeight(30),
            ),
            Text(rowName),
            if (subText != null)
              Text(
                subText!,
                style: TextStyle(color: Colors.red),
              ),
            Spacer(),
            Icon(Icons.chevron_right)
            // IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right))
          ],
        ),
      ),
    );
  }
}
