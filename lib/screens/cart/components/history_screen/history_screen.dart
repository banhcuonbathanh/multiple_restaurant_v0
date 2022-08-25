import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:untitled1/app_api/local_notification.dart';
import 'package:untitled1/app_provider/api_provider.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/screens/home/home_screen.dart';
import 'package:untitled1/size_config.dart';

final socketProvider = Provider<IO.Socket>((ref) {
  final IO.Socket socket = IO.io('http://127.0.0.1:3000',
      // OptionBuilder().setTransports(['websocket']).build(),
      {
        "transport": ["websocket"],
        "autoConnect": false,
      });
  return socket;
});

class HistoryScreen extends HookConsumerWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
// ---------------------------------
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
// -------------------------

    final StreamController<List<dynamic>> counterController =
        StreamController<List<dynamic>>();
    final restart = useState(true);
    final orders = ref.watch(AppStateProvider.orderNotifier).values.toList();
    print('objectordersordersordersordersordersorders');
    print(orders.length);
    late IO.Socket socket;
// ---------------------

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
// ------------------------

    useEffect(() {
      connectAndListen(userId: '62b2d37d9176c5d25ac393ab');
    });
    // void connectAndListen() {
    //   socket.onConnect((_) {
    //     print('connect asdfasfasfasdfsd');
    //     socket.emit('sign_in', '62b2d37d9176c5d25ac393ab');
    //   });
    //   socket.onDisconnect((_) => print('disconnect'));
    // }
    // late IO.Socket socket;
    // Socket socket = io('http://localhost:3000', <String, dynamic>{
    //   'transports': ['websocket'],
    //   'autoConnect': false,
    //   'extraHeaders': {'foo': 'bar'} // optional
    // });

    // void connectAndListen() {
    //   // socket = IO.io('http://127.0.0.1:3000',
    //   //     OptionBuilder().setTransports(['websocket']).build());
    //   // print('socket');

    //   socket.onConnect((_) {
    //     // print('connect');
    //     socket.emit('fromclient', 'test from history');

// -------------------------
    // useEffect(() {
    //   connectAndListen();
    //   print('HistoryScreen');
    // });

    // --------------
    // socket.connect();
    // final IO.Socket socket = IO.io('http://127.0.0.1:3000',
    //     OptionBuilder().setTransports(['websocket']).build());
    // final IO.Socket socket = IO.io('http://127.0.0.1:3000',
    //     // OptionBuilder().setTransports(['websocket']).build(),
    //     {
    //       "transport": ["websocket"],
    //       "autoConnect": false,
    //     });
    // socket.connect();
    socket.on('getmessage', (data) async {
      print('1111111111111111');

      await ref.read(AppStateProvider.orderNotifier.notifier).getAllProduct();
      restart.value = !restart.value;
    });

    // socket.on('getmessage', ((data) {
    //   print('data');
    //   print(data);
    // }));
    return ListView(
      children: [
        Divider(),
        // CartCategoryHistoryScreen(
        //   funcIsShowDeliveryScreen: () {},
        //   funcIsShowFavoriteScreen: () {},
        //   funcIsShowHistoryScreen: () {},
        //   funcIsShowOrderScreen: () {},
        // ),
        ElevatedButton(
            onPressed: () {
              ref.read(API.socket).sendMessage(
                  userId: '62b2d37d9176c5d25ac393ab',
                  orderId: '62b2d37d9176c5d25ac393ab',
                  receiveId: '62b2d37d9176c5d25ac393ab');
            },
            child: Text('connect')),
        ElevatedButton(
            onPressed: () {
              ref.read(API.socket).sign_in(userId: '62b2d37d9176c5d25ac393ab');
            },
            child: Text('sign in ')),
        ElevatedButton(
            onPressed: () async {
              final order = await ref.read(API.order).createOrder(
                  BuyingUserId: 'user!.userId!',
                  ProductId: 'ListproductsDetail[0].productId!',
                  restaurantId: ' ListproductsDetail[0].restaurantId!',
                  productdetailsList: [],
                  toppingsList: [],
                  address: 'lkj',
                  day: '1.2.3.4',
                  hour: '123',
                  minute: 'q2134',
                  restaurantOnwnerId: '111111111111111');
              ref.read(API.socket).sendMessage(
                  userId: '62b2d37d9176c5d25ac393ab',
                  orderId: '62b2d37d9176c5d25ac393ab',
                  receiveId: '62b2d37d9176c5d25ac393ab');
              restart.value = !restart.value;
              // ref.read(API.socket).sign_in(userId: '1234124');
            },
            child: Text('sign in 2')),
        ElevatedButton(
            onPressed: () async {
              await service.showNotification(
                  id: 0, title: ' notiication title', body: ' some nidy');
            },
            child: Text('local notification ')),
        ElevatedButton(
            onPressed: () async {
              await service.showNotificationPayLoad(
                  id: 0,
                  title: ' notiication title',
                  body: ' some nidy',
                  payLoad: 'pay load to nvatioan');
            },
            child: Text('local notification pay load')),
        if (orders.length == 0)
          Container(
              alignment: Alignment.center,
              height: getProportionateScreenHeight(500),
              child: Text('Chọn sản phẩm')),
      ],
    );
  }
}

// class streamdatatest extends StatelessWidget {
//   const streamdatatest({
//     Key? key,
//     required this.testStream,
//   }) : super(key: key);
//   final Stream<List<dynamic>> testStream;
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<dynamic>>(
//         stream: testStream,
//         builder: (context, snapshot) {
//           if (snapshot.hasError)
//             return Text('there error');
//           else if (snapshot.hasData) {
//             final test = snapshot.data!;

//             // ----------------
//             final test1 = List<OrderModel>.from((test).map((response) {
//               final productdetaullist =
//                   productDetailFromJson(response['productdetailsList']);

//               final toppinglist = toppingsFromJson(response['toppingsList']);

//               OrderModel test1 = OrderModel(
//                   BuyingUserId: response['BuyingUserId'],
//                   productdetailsIdList: productdetaullist,
//                   ProductId: response['ProductId'],
//                   restaurantId: response['restaurantId'],
//                   toppingsList: toppinglist,
//                   statusOrder: response['statusOrder'],
//                   address: response['address'],
//                   orderTiming: response['orderTiming'],
//                   orderId: response['orderId'],
//                   restaurantOnwnerId: response['restaurantOnwnerId']);

//               return test1;
//             }));
//             // -----------------

//             return ListView.builder(
//                 primary: true,
//                 shrinkWrap: true,
//                 itemCount: test1.length,
//                 itemBuilder: (context, index) {
//                   final order = test1[index];
//                   return Text(order.statusOrder);
//                 });
//           } else {
//             return Text('snapshot.data!.length.toString()');
//           }
//         });
//   }
// }
