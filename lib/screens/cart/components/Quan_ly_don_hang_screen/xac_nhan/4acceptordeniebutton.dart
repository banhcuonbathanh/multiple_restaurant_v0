import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';

import 'package:untitled1/components/snackbarcontent.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:untitled1/model/order_model.dart';

class AcceptOrDenieButton extends HookConsumerWidget {
  const AcceptOrDenieButton({
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
                          onPressed: () {
                            // if (lydotucho.text != '') {
                            socket.emit(
                              "tu_choi_don_hang",
                              {
                                "senderId": order.BuyingUserId,
                                'receiveId': order.restaurantOnwnerId,
                                'lydo': '${lydotucho.text}',
                              },
                            );
                            print('order.orderId huyyyyyy');
                            print(order.orderId);
                            ref
                                .read(
                                    AppStateProvider.orderTestNotifier.notifier)
                                .getOrderandUpdate(
                                    restaurantName: order.restaurantName,
                                    BuyingUserName: order.BuyingUserName,
                                    BuyingUserId: order.BuyingUserId,
                                    ProductId: order.ProductId,
                                    restaurantId: order.restaurantId,
                                    productdetailsIdList:
                                        order.productdetailsIdList,
                                    toppingsList: order.toppingsList,
                                    statusOrder: 'huy',
                                    address: order.address,
                                    day: order.day,
                                    hour: order.hour,
                                    minute: order.minute,
                                    orderId: order.orderId,
                                    restaurantOnwnerId:
                                        order.restaurantOnwnerId);
                            print('object111111111111');
                            lydotucho.text = '';
                            // print('222222222');
                            Navigator.pop(context);
                            print('3333333333');
                            restartFunc();
                            print('4444444444');
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
            child: Text('Huỷ Đơn Hàng')),
      ],
    );
  }
}
