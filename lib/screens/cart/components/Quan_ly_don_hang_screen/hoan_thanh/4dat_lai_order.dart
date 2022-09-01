import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:untitled1/model/order_model.dart';

class DatLaiOrder extends HookConsumerWidget {
  const DatLaiOrder({
    required this.restartFunc,
    required this.order,
    Key? key,
    required this.socket,
    required this.lydotucho,
  }) : super(key: key);

  final IO.Socket socket;
  final TextEditingController lydotucho;

  final OrderModel order;
  final Function restartFunc;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(" ly do tu choi"),
                    content: Text('asdf'),
                    //  TextFormField(controller: lydotucho),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            // if (lydotucho.text != '') {
                            socket.emit(
                              "dat_lai_don_hang",
                              {
                                "senderId": order.BuyingUserId,
                                'receiveId': order.restaurantOnwnerId,
                                'lydo': '${lydotucho.text}',
                              },
                            );
// -------------------------
                            final orderTest = await ref
                                .read(
                                    AppStateProvider.orderTestNotifier.notifier)
                                .createOrderTest(
                                    address: order.address,
                                    BuyingUserId: order.BuyingUserId,
                                    ProductId: order.ProductId,
                                    restaurantId: order.restaurantId,
                                    productdetailsList:
                                        order.productdetailsIdList,
                                    toppingsList: order.toppingsList,
                                    day: order.day,
                                    hour: order.hour,
                                    minute: order.minute,
                                    restaurantOnwnerId:
                                        order.restaurantOnwnerId,
                                    BuyingUserName: order.BuyingUserName,
                                    restaurantName: order.restaurantName);

                            // ----------

                            Navigator.pop(context);

                            restartFunc();

                            // } else {
                            //   CustomScaffoldMessger(
                            //     context: context,
                            //     contend: 'dien ly do tu choi',
                            //   );
                            // }
                          },
                          child: Text('Ok')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('thoi')),
                    ],
                  );
                },
              );
            },
            child: Text('Đặt Lại Đơn Hàng')),
      ],
    );
  }
}
