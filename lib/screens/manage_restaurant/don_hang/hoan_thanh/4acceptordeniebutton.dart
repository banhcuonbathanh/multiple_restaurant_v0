import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:untitled1/components/custom_container.dart';
import 'package:untitled1/components/snackbarcontent.dart';
import 'package:untitled1/model/order_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '3buying_product.dart';

class AcceptOrDenieButton extends HookConsumerWidget {
  const AcceptOrDenieButton({
    Key? key,
    required this.socket,
    required this.lydotucho,
  }) : super(key: key);

  final IO.Socket socket;
  final TextEditingController lydotucho;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              socket.emit(
                "xac_nhan_don_hang",
                {
                  "senderId": '62b2d37d9176c5d25ac393ab',
                  'receiveId': '62a6ade2bfb7adc84ef4da57',
                  'orderId': '62b2d37d9176c5d25ac393ab'
                },
              );
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
                          onPressed: () {
                            if (lydotucho.text != '') {
                              socket.emit(
                                "tu_choi_don_hang",
                                {
                                  "senderId": '62b2d37d9176c5d25ac393ab',
                                  'receiveId': '62a6ade2bfb7adc84ef4da57',
                                  'lydo': '${lydotucho.text}',
                                },
                              );
                              Navigator.pop(context);
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
