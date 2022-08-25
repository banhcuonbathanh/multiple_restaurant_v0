import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:untitled1/app_api/local_notification.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_container.dart';

import 'package:untitled1/screens/home/home_screen.dart';
import 'package:untitled1/size_config.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../../components/custom_buttom.dart';

class CategoryQuanLyDonHang extends HookConsumerWidget {
  final Function funcIsShowWaitingConfirm;
  final Function funcIsShowConfirm;
  final Function funcIsCanceled;
  const CategoryQuanLyDonHang({
    required this.funcIsShowWaitingConfirm,
    required this.funcIsShowConfirm,
    required this.funcIsCanceled,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useData = ref.watch(AppStateProvider.userNotifier);
    final tapIndex = useState(0);
// ----------------------------
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

// --------------------------

    final restart = useState(true);
    print('DonHang');
    // ----------------------
    late IO.Socket socket;
    void connectAndListen({required String userId}) {
      socket = IO.io(
        'http://127.0.0.1:3000',
        OptionBuilder().setTransports(['websocket']).build(),
      );
      socket.onConnect((_) {
        socket.emit('sign_in', userId);
      });
      socket.onDisconnect((_) => print('disconnect'));
    }

    useEffect(() {
      connectAndListen(userId: '62b2d37d9176c5d25ac393ab');
    });
    socket.on('getmessage', (data) async {
      print('<<<<<<<<<<<<<<<<<<<<<<<<<<');

      await ref.read(AppStateProvider.orderNotifier.notifier).getAllProduct();
      await service.showNotification(
          id: 0, title: ' notiication title', body: ' some nidy');
      restart.value = !restart.value;
    });
    // ----------------------
    //  Navigator.pushNamed(context, ChoXacNhan.routeName);
    //               await ref
    //                   .read(AppStateProvider.orderNotifier.notifier)
    //                   .getAllProduct();
    // ------------------
    final order = ref.watch(AppStateProvider.orderNotifier);
    return CustomContainer(
      containerHeight: 40,
      bottompadding: 0,
      borderRadius: 10,
      leftPadding: 0,
      rightPadding: 0,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Stack(
                children: [
                  CustomerButton(
                    backgoundColor:
                        tapIndex.value == 0 ? null : Colors.grey.shade200,
                    BorderRadiuscircular: 8,
                    buttonHeight: 45,
                    buttonWidth: 110,
                    press: () async {
                      funcIsShowWaitingConfirm();
                      // Navigator.pushNamed(context, ChoXacNhan.routeName);
                      // await ref
                      //     .read(AppStateProvider.orderNotifier.notifier)
                      //     .getAllProduct();
                      tapIndex.value = 0;
                    },
                    text: 'Chờ Xác Nhận',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomerButton(
              backgoundColor: tapIndex.value == 1 ? null : Colors.grey.shade200,
              BorderRadiuscircular: 8,
              buttonHeight: 45,
              buttonWidth: 110,
              press: () async {
                final orderTest = await ref
                    .read(AppStateProvider.orderTestNotifier.notifier)
                    .searchingorderByBuyingUserId(
                      BuyingUserId: useData!.userId!,
                      numberOfOrder: 0,
                      page: 0,
                      statusOrder: 'xac nhan',
                    );
                funcIsShowConfirm();
                tapIndex.value = 1;
              },
              text: 'Xác Nhận',
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(10),
          ),
          Expanded(
            flex: 2,
            child: CustomerButton(
              backgoundColor: tapIndex.value == 2 ? null : Colors.grey.shade200,
              BorderRadiuscircular: 8,
              buttonHeight: 45,
              buttonWidth: 110,
              press: () async {
                funcIsCanceled();
                tapIndex.value = 2;
                // await service.showNotification(
                //     id: 0, title: ' notiication title', body: ' some nidy');
              },
              text: 'Hoàn Thành ',
            ),
          ),
        ],
      ),
    );
  }
}


  // await service.showNotification(
  //                         id: 0,
  //                         title: ' notiication title',
  //                         body: ' some nidy');