import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:untitled1/app_api/local_notification.dart';
import 'package:untitled1/app_provider/state_provider.dart';

import 'package:untitled1/screens/home/home_screen.dart';
import 'package:untitled1/size_config.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../../components/custom_buttom.dart';
import 'package:intl/intl.dart';

import '../../../../components/snackbarcontent.dart';

class SelectingTime extends HookConsumerWidget {
  // final Function funcHomQua;
  // final Function func7Ngay;
  // final Function func30Ngay;
  final Function restartFunc;
  const SelectingTime({
    required this.restartFunc,
    // required this.funcHomQua,
    // required this.func7Ngay,
    // required this.func30Ngay,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(AppStateProvider.userNotifier);
    final fromDate = useState<DateTime?>(null);
    final toDate = useState<DateTime?>(null);
    final restart = useState(true);

// ----------------------------
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

// --------------------------

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

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: Row(
            children: [
              Expanded(
                  child: SelectingDate(
                startingDate: fromDate,
                resetToDate: () {
                  toDate.value = null;
                },
              )),
              SizedBox(
                width: getProportionateScreenWidth(5),
              ),
              Expanded(
                  child: SelectingDate(
                startingDate: toDate,
                resetToDate: () {},
              )),
              SizedBox(
                width: getProportionateScreenWidth(5),
              ),
              CustomerButton(
                  text: 'Xong',
                  press: () async {
                    if (fromDate.value!.compareTo(toDate.value!) > 0) {
                      CustomScaffoldMessger(
                          contend: 'ngay bat dau lon hon ngay ket thuc',
                          context: context);
                    }
                    if (fromDate.value!.compareTo(toDate.value!) == 0) {
                      CustomScaffoldMessger(
                          contend: 'ngay ket thuc can lon hon ngay bat dau',
                          context: context);
                    }
                    final order = await ref
                        .read(AppStateProvider.orderTestNotifier.notifier)
                        .searchingorderByRangeOfDate(
                            fromDate: fromDate.value!.toIso8601String(),
                            toDate: '${toDate.value!.toIso8601String() + 'Z'}',
                            restaurantOnwnerId: userData!.userId!);
                    ref
                        .read(AppStateProvider.orderAnalytic.notifier)
                        .addOrder(serverOrders: order);
                    ref
                        .read(AppStateProvider.orderAnalytic.notifier)
                        .toDateFunc(toDateData: toDate.value!);
                    ref
                        .read(AppStateProvider.orderAnalytic.notifier)
                        .fromDateFunc(fromDateData: fromDate.value!);
                    int indefferentHour = ref
                        .read(AppStateProvider.orderAnalytic.notifier)
                        .inDefferentInHourFunc(
                            fromDateData: fromDate.value!,
                            toDateData: toDate.value!);
                    ref
                        .read(AppStateProvider.orderAnalytic.notifier)
                        .bieuDoTypeFunc(differentDay: indefferentHour);

                    restartFunc();
                  },
                  buttonHeight: 50,
                  buttonWidth: 50,
                  BorderRadiuscircular: 10,
                  backgoundColor:
                      (fromDate.value != null && toDate.value != null)
                          ? null
                          : Colors.grey.shade300)
            ],
          ),
        ),
      ],
    );
  }
}

class SelectingDate extends StatelessWidget {
  const SelectingDate({
    Key? key,
    required this.startingDate,
    required this.resetToDate,
  }) : super(key: key);

  final ValueNotifier<DateTime?> startingDate;
  final Function resetToDate;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
        child: Row(
          children: [
            Text(startingDate.value == null
                ? 'chon ngay'
                : DateFormat('dd-MM-yyyy')
                    .format(startingDate.value!)
                    .toString()),
            Spacer(),
            RotatedBox(
              quarterTurns: 3,
              child: IconButton(
                  onPressed: () async {
                    final value = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        lastDate: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day + 1));
                    if (value != null) {
                      startingDate.value = value;
                      resetToDate();
                      // DateFormat('yyyy-MM-dd').format(value);
                    }

                    if (startingDate.value == null) return;
                  },
                  icon: Icon(Icons.chevron_left)),
            ),
          ],
        ),
      ),
    );
  }
}

// typedef void StringCallback(String val);

// class SelectingDate extends StatelessWidget {
//   const SelectingDate({Key? key, required this.callback}) : super(key: key);

//   final StringCallback callback;
//   @override
//   Widget build(BuildContext context) {
//     String? selectingDate;
//     return Row(
//       children: [
//         Text(selectingDate == null ? 'chon ngay thang' : selectingDate),
//         RotatedBox(
//           quarterTurns: 3,
//           child: IconButton(
//               onPressed: () async {
//                 final value = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(2021),
//                     lastDate: DateTime(2023));
//                 if (value != null) {
//                   selectingDate = DateFormat('dd / MM').format(value);
//                   callback(selectingDate!);
//                 }

//                 // startingDate.value =
//                 //     DateFormat('yyyy-MM-dd – kk:mm').format(value!);
//                 if (selectingDate == null) return;
//               },
//               icon: Icon(Icons.chevron_left)),
//         )
//       ],
//     );
//   }
// }

//   // await service.showNotification(
//   //                         id: 0,
//   //                         title: ' notiication title',
//   //                         body: ' some nidy');


// -------------

      // CustomContainer(
        //   containerHeight: 40,
        //   bottompadding: 0,
        //   borderRadius: 10,
        //   leftPadding: 0,
        //   rightPadding: 0,
        //   child: Row(
        //     children: [
        //       Expanded(
        //         flex: 2,
        //         child: Container(
        //           child: Stack(
        //             children: [
        //               CustomerButton(
        //                 backgoundColor:
        //                     tapIndex.value == 0 ? null : Colors.grey.shade200,
        //                 BorderRadiuscircular: 8,
        //                 buttonHeight: 45,
        //                 buttonWidth: 110,
        //                 press: () async {
        //                   funcHomQua();
        //                   // Navigator.pushNamed(context, ChoXacNhan.routeName);
        //                   // await ref
        //                   //     .read(AppStateProvider.orderNotifier.notifier)
        //                   //     .getAllProduct();
        //                   tapIndex.value = 0;
        //                 },
        //                 text: 'Hôm Qua',
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       Expanded(
        //         flex: 2,
        //         child: CustomerButton(
        //           backgoundColor:
        //               tapIndex.value == 1 ? null : Colors.grey.shade200,
        //           BorderRadiuscircular: 8,
        //           buttonHeight: 45,
        //           buttonWidth: 110,
        //           press: () async {
        //             final orderTest = await ref
        //                 .read(AppStateProvider.orderTestNotifier.notifier)
        //                 .searchingorderByBuyingUserId(
        //                   BuyingUserId: useData!.userId!,
        //                   numberOfOrder: 0,
        //                   page: 0,
        //                   statusOrder: 'xac nhan',
        //                 );
        //             func7Ngay();
        //             tapIndex.value = 1;
        //           },
        //           text: '7 Ngày',
        //         ),
        //       ),
        //       SizedBox(
        //         width: getProportionateScreenWidth(10),
        //       ),
        //       Expanded(
        //         flex: 2,
        //         child: CustomerButton(
        //           backgoundColor:
        //               tapIndex.value == 2 ? null : Colors.grey.shade200,
        //           BorderRadiuscircular: 8,
        //           buttonHeight: 45,
        //           buttonWidth: 110,
        //           press: () async {
        //             func30Ngay();
        //             tapIndex.value = 2;
        //             // await service.showNotification(
        //             //     id: 0, title: ' notiication title', body: ' some nidy');
        //           },
        //           text: '30 Ngày ',
        //         ),
        //       ),
        //     ],
        //   ),
        // ),