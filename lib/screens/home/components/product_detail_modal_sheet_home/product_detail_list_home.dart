import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:untitled1/app_api/local_notification.dart';

import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/app_provider/utility_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';

import 'package:untitled1/model/topping_model.dart';
import 'package:untitled1/screens/home/home_screen.dart';

import 'package:untitled1/size_config.dart';

import 'customer_ordering_information.dart';
import 'product_detail_one_home.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ProductDetailList_Home extends HookConsumerWidget {
  const ProductDetailList_Home({
    required this.restaurantId,
    Key? key,
    required this.serverProductId,
  }) : super(key: key);

  final String? serverProductId;
  final String restaurantId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(AppStateProvider.userNotifier);
    // ---------------------
    // show notification
    late final LocalNotificationService service;
    void onNotificationListner(String? payLoad) {
      print('asdfsdfadsfdas');
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
    // ---------------------------------
// socket Io
    late io.Socket socket;
    void connectAndListen() {
      socket = io.io('http://127.0.0.1:3000',
          OptionBuilder().setTransports(['websocket']).build());

      socket.onConnect((_) {});
      socket.emit('add_user', userData!.userId);
      // -----------
      socket.on('receiveOrder', (data) async {
        print('data trong ManageRestaurantBody');
        print(data);
        await service.showNotification(
            id: 0, title: ' notiication title', body: ' some nidy');
      });
      // --------------
      socket.onDisconnect((_) => print('disconnect'));
    }

    useEffect(() {
      connectAndListen();
      return () {};
    });
    // --------------------------------------
    final count = useState<bool>(false);
    final newAddress = useTextEditingController();

    final restaurantData = ref
        .watch(AppStateProvider.restaurantStateMap)
        .values
        .firstWhere((element) => element.restaurantId == restaurantId);
    final orderDay = ref.watch(Utility.orderDay);

    final orderHour = ref.watch(Utility.orderHour);
    final orderMinute = ref.watch(Utility.orderMinute);
    useEffect(() {
      return () {};
    });
    final sheetAnimationController =
        useAnimationController(duration: const Duration(milliseconds: 400));

    final sheetAnimation =
        Tween(begin: 1.0, end: .05).animate(sheetAnimationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // sheetAnimationController.reverse();
            }
          });
    final borderRadiusAnimation =
        Tween(begin: 1.0, end: 90.0).animate(sheetAnimationController)
          ..addListener(() {
            count.value = !count.value;
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // sheetAnimationController.reverse();
            }
          });
    // ----------------------------
    // final heightSheetAnimationController =
    //     useAnimationController(duration: const Duration(milliseconds: 500));
    // final heightAnimation1 =
    //     Tween(begin: 1.0, end: 0.5).animate(heightSheetAnimationController)
    //       ..addListener(() {
    //         count.value = !count.value;
    //       })
    //       ..addStatusListener((status) {
    //         if (status == AnimationStatus.completed) {
    //           // heightSheetAnimationController.reverse();
    //         }
    //       });

    final ProductDetailPresen =
        ref.watch(AppStateProvider.productdetailMapNotifier)!.values.toList();

    final productsDetailData = ProductDetailPresen.where(
        (element) => element.productId == serverProductId);
    final toppings =
        ref.watch(AppStateProvider.toppingEditMapNotifier).values.toList();

    final toppingsProduct =
        toppings.where((element) => element.productId == serverProductId);

    // --------------
    //      final allToppings =
    //     ref.watch(AppStateProvider.toppingEditMapNotifier).values.toList();
    // final toppingsProductdetail = allToppings
    //     .where(((element) =>
    //         element.productDetailId == ProductDetailData.productdetaiId))
    //     .toList();
    // --------------
    return DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (_, controller) {
          return ScaleTransition(
            alignment: const Alignment(-0.3, 1.0),
            scale: sheetAnimation,
            child: FadeTransition(
              opacity: sheetAnimation,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(
                        20 * borderRadiusAnimation.value)),
                child: SingleChildScrollView(
                  controller: controller,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var index = 0;
                            index < productsDetailData.length;
                            index++)
                          ProductDetailOneHome(
                            ProductDetailData:
                                productsDetailData.elementAt(index),
                            productId: serverProductId!,
                            restart: () {
                              count.value = !count.value;
                            },
                          ),
                        CustomerOrderingInformation(
                          newAdressController: newAddress,
                          restaurantId: restaurantId,
                        ),
                        const Divider(),
                        if (productsDetailData != null &&
                            productsDetailData.length >= 1)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomerButton(
                                backgoundColor: null,
                                BorderRadiuscircular: 10,
                                buttonHeight: getProportionateScreenHeight(25),
                                buttonWidth: getProportionateScreenWidth(70),
                                press: () {
                                  Navigator.pop(context);

                                  final sanPhamMua = productsDetailData
                                      .where((element) =>
                                          element.productdetailQuantity! > 0)
                                      .toList();
                                  ref
                                      .read(Utility.orderDay.notifier)
                                      .orderday(day: null);
                                  ref
                                      .read(Utility.orderHour.notifier)
                                      .orderHour(hour: null);
                                  ref
                                      .read(Utility.orderMinute.notifier)
                                      .orderMinute(minute: null);
                                  if (sanPhamMua.length != 0) {
                                    for (var i in sanPhamMua) {
                                      ref
                                          .read(AppStateProvider
                                              .productdetailMapNotifier
                                              .notifier)
                                          .resetProductDetail(
                                              productdetailId:
                                                  i.productdetaiId!);
                                    }
                                  }
                                },
                                text: 'Thoát',
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(20),
                              ),
                              CustomerButton(
                                backgoundColor: null,
                                BorderRadiuscircular: 10,
                                buttonHeight: getProportionateScreenHeight(25),
                                buttonWidth: getProportionateScreenWidth(70),
                                press: () async {
                                  final sanPhamMua = productsDetailData
                                      .where((element) =>
                                          element.productdetailQuantity! > 0)
                                      .toList();
                                  if (sanPhamMua.length == 0) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Chưa mua san phẩm'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Ok'))
                                            ],
                                          );
                                        });
                                    return;
                                  }
                                  if (orderDay == null) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                                'Chưa Điền thông tin ngay dat hang'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Ok'))
                                            ],
                                          );
                                        });
                                    return;
                                  }
                                  if (orderHour == null ||
                                      orderMinute == null) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                                'Chưa Điền thoi gian dat hang'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Ok'))
                                            ],
                                          );
                                        });
                                    return;
                                  }

                                  List<ToppingModel> toppingList = [];
                                  for (int index = 0;
                                      index < productsDetailData.length;
                                      index++) {
                                    final tem = toppings
                                        .where(((element) =>
                                            element.productDetailId ==
                                            productsDetailData
                                                .elementAt(index)
                                                .productdetaiId))
                                        .toList();
                                    toppingList.addAll(tem);
                                  }
                                  final orderTest = await ref
                                      .read(AppStateProvider
                                          .orderTestNotifier.notifier)
                                      .createOrderTest(
                                          address: newAddress.text == ''
                                              ? userData!.userAdrress!
                                              : newAddress.text,
                                          BuyingUserId: userData!.userId!,
                                          ProductId: serverProductId!,
                                          restaurantId: restaurantId,
                                          productdetailsList: sanPhamMua,
                                          toppingsList: toppingList,
                                          day: orderDay.toString(),
                                          hour: orderHour.toString(),
                                          minute: orderMinute.toString(),
                                          restaurantOnwnerId:
                                              restaurantData.userId!,
                                          BuyingUserName: userData.userName!,
                                          restaurantName:
                                              restaurantData.restaurantName!);
                                  socket.emit('send_order', {
                                    'restaurantownerId':
                                        orderTest.restaurantOnwnerId,
                                    'orderId': orderTest.orderId
                                  });
                                  ref
                                      .read(
                                          Utility.disposeofhomeGetter.notifier)
                                      .diposetrue();
                                  // heightSheetAnimationController
                                  //     .forward();
                                  // final order = await ref
                                  //     .read(API.productdetail)
                                  //     .getAllProduct();
                                  // print('orderorderorderorderorder');
                                  // print(order.length);

                                  ref
                                      .read(Utility.orderDay.notifier)
                                      .orderday(day: null);
                                  ref
                                      .read(Utility.orderHour.notifier)
                                      .orderHour(hour: null);
                                  ref
                                      .read(Utility.orderMinute.notifier)
                                      .orderMinute(minute: null);
                                  for (var i in sanPhamMua) {
                                    ref
                                        .read(AppStateProvider
                                            .productdetailMapNotifier.notifier)
                                        .resetProductDetail(
                                            productdetailId: i.productdetaiId!);
                                  }
                                  Timer(const Duration(milliseconds: 400), () {
                                    sheetAnimationController.forward();
                                    Timer(const Duration(milliseconds: 400),
                                        () {
                                      Navigator.pop(context);
                                    });
                                  });
                                },
                                text: 'Xong',
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

// class draggablesheet1 extends StatelessWidget {
//   final Widget contend;
//   const draggablesheet1({
//     Key? key,
//     required this.contend,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//         initialChildSize: 0.9,
//         maxChildSize: 0.95,
//         minChildSize: 0.5,
//         builder: (_, controller) {
//           return Container(
//             color: Colors.white,
//             child: SingleChildScrollView(
//               controller: controller,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     MediaQuery.removePadding(
//                       context: context,
//                       removeTop: true,
//                       removeBottom: true,
//                       child: GridView.count(
//                         primary: false,
//                         shrinkWrap: true,
//                         crossAxisCount: 2,
//                         childAspectRatio: 4 / 5,
//                         mainAxisSpacing: getProportionateScreenHeight(10),
//                         crossAxisSpacing: getProportionateScreenWidth(10),
//                         children: [
//                           Container(
//                             child: contend,
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }
