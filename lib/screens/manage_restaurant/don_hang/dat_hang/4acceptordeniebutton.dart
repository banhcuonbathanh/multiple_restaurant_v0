import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:untitled1/components/custom_container.dart';
import 'package:untitled1/components/snackbarcontent.dart';
import 'package:untitled1/model/order_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../app_provider/state_provider.dart';
import '3buying_product.dart';

class AcceptOrDenieButton extends HookConsumerWidget {
  const AcceptOrDenieButton({
    required this.restartFun,
    required this.order,
    Key? key,
    required this.socket,
    required this.lydotucho,
  }) : super(key: key);

  final IO.Socket socket;
  final TextEditingController lydotucho;
  final OrderModel order;
  final Function restartFun;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () async {
              socket.emit(
                "xac_nhan_don_hang",
                {
                  "senderId": order.restaurantOnwnerId,
                  'receiveId': order.BuyingUserId,
                  'orderId': order.orderId
                },
              );
              await ref
                  .read(AppStateProvider.orderTestNotifier.notifier)
                  .getOrderandUpdate(
                      restaurantName: order.restaurantName,
                      BuyingUserName: order.BuyingUserName,
                      BuyingUserId: order.BuyingUserId,
                      ProductId: order.ProductId,
                      restaurantId: order.restaurantId,
                      productdetailsIdList: order.productdetailsIdList,
                      toppingsList: order.toppingsList,
                      statusOrder: 'xac nhan',
                      address: order.address,
                      day: order.day,
                      hour: order.hour,
                      minute: order.minute,
                      orderId: order.orderId,
                      restaurantOnwnerId: order.restaurantOnwnerId);
              restartFun();
            },
            child: Text('Chap Nhan')),
        TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(" ly do tu choi"),
                    content: TextFormField(controller: lydotucho),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            if (lydotucho.text != '') {
                              socket.emit(
                                "tu_choi_don_hang",
                                {
                                  "senderId": order.restaurantOnwnerId,
                                  'receiveId': order.BuyingUserId,
                                  'lydo': '${lydotucho.text}',
                                },
                              );
                              await ref
                                  .read(AppStateProvider
                                      .orderTestNotifier.notifier)
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

                              Navigator.pop(context);
                              restartFun();
                              lydotucho.text = '';
                            } else {
                              CustomScaffoldMessger(
                                context: context,
                                contend: 'dien ly do tu choi',
                              );
                            }
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
