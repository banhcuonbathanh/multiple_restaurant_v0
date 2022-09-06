import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/model/productdetail_model.dart';

import 'package:untitled1/screens/cart/components/history_screen/history_screen.dart';

import 'package:untitled1/size_config.dart';
import '../../../app_api/local_notification.dart';
import '../../home/home_screen.dart';

import 'order_screen/category_cart/cart_category.dart';
import 'favorite_screen/favorite_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class BodyCartItem1 extends HookConsumerWidget {
  const BodyCartItem1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // late final LocalNotificationService service;
    // void onNotificationListner(String? payLoad) {
    //   print('asdfsdfadsfdas');
    //   // if (payLoad != null && payLoad.isNotEmpty) {
    //   //   print(payLoad);
    //   // }
    //   Navigator.pushNamed(context, HomeScreen.routeName);
    // }

    // void listenToNotification() =>
    //     service.onNotificationClick.stream.listen(onNotificationListner);
    // useEffect(() {
    //   service = LocalNotificationService();
    //   service.intialize();
    // });
    // // ----------------------------------
    // // socket io
    // late io.Socket socket;
    // void connectAndListen() {
    //   socket = io.io('http://127.0.0.1:3000',
    //       OptionBuilder().setTransports(['websocket']).build());

    //   socket.onConnect((_) {});
    //   socket.on('receiveOrder', (data) async {
    //     await service.showNotification(
    //         id: 0, title: ' notiication title', body: ' some nidy');
    //   });

    //   socket.onDisconnect((_) => print('disconnect'));
    // }

    // useEffect(() {
    //   connectAndListen();
    //   return () {};
    // });
    // // ---------------------------
    // List<ProductDetail> data;
    // final listCartItem = ref.watch(CartItemNotifierProvider);
    List<ProductDetailModel>? orderedProductdetails = ref
        .watch(AppStateProvider.productdetailMapNotifier)!
        .values
        .toList()
        .where((element) => element.productdetailQuantity! > 0)
        .toList();
    // print('BodyCartItem');
    // print('orderedProductdetails');
    // print(orderedProductdetails);
    Set<String> setOfRestaurantIDs = {};
    for (final product in orderedProductdetails) {
      setOfRestaurantIDs.add(product.restaurantId!);
    }
    // List<ProductDetailModel>? orderedProducts = allProductdetails
    //     .where(((element) => element.productdetailQuantity! > 0))
    //     .toList();
    final userData = ref.watch(AppStateProvider.userNotifier);

    final isShowOrderScreen = useState<bool>(true);
    final isShowFavoriteScreen = useState<bool>(false);
    final isShowDeliveryScreen = useState<bool>(false);
    final isShowHistoryScreen = useState<bool>(false);
    final currenIsShowScreen = useState<int>(1);

    selectionScreen(int id) {
      currenIsShowScreen.value = id;

      switch (id) {
        case 0:
          isShowDeliveryScreen.value = true;
          isShowOrderScreen.value = false;
          isShowFavoriteScreen.value = false;
          isShowHistoryScreen.value = false;
          break;

        case 1:
          isShowDeliveryScreen.value = false;
          isShowOrderScreen.value = true;
          isShowFavoriteScreen.value = false;
          isShowHistoryScreen.value = false;
          break;
        case 2:
          isShowDeliveryScreen.value = false;
          isShowOrderScreen.value = false;
          isShowFavoriteScreen.value = true;
          isShowHistoryScreen.value = false;
          break;
        case 3:
          isShowDeliveryScreen.value = false;
          isShowOrderScreen.value = false;
          isShowFavoriteScreen.value = false;
          isShowHistoryScreen.value = true;
          break;
        default:
      }
    }

    // selectionScreen(0);
    return SafeArea(
      child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: Column(
            // primary: true,
            // shrinkWrap: true,
            children: [
              Text(
                "Đơn Hàng",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              const Divider(),
              CartCategory(
                funcIsShowDeliveryScreen: () {
                  selectionScreen(0);
                },
                funcIsShowFavoriteScreen: () async {
                  selectionScreen(2);
                  await ref
                      .read(AppStateProvider.productdetailMapNotifier.notifier)
                      .addItemFavaoriteFromServer(userId: userData!.userId!);
                },
                funcIsShowHistoryScreen: () async {
                  // await ref
                  //     .read(AppStateProvider.orderNotifier.notifier)
                  //     .getAllProduct();
                  selectionScreen(3);
                },
              ),
              // if (isShowOrderScreen.value)
              //   Expanded(
              //     child: Orderscreen(
              //       orderedProductdetails: orderedProductdetails,
              //     ),
              //   ),
              if (isShowFavoriteScreen.value)
                const Expanded(
                    child: FavoriteScreen(
                        // data: data,
                        )),
              // if (isShowDeliveryScreen.value)
              //   const Expanded(child: QuanLyDonHang(restartFunc: () {})),
              if (isShowHistoryScreen.value)
                const Expanded(child: HistoryScreen()),
            ],
          )),
    );
  }
}
