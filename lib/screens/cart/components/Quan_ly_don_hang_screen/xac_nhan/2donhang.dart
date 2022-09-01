import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'package:untitled1/components/custom_container.dart';
import 'package:untitled1/model/order_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:untitled1/size_config.dart';
import '4acceptordeniebutton.dart';
import '3buying_product.dart';

class DonHang extends HookConsumerWidget {
  const DonHang({
    required this.restartFunc,
    required this.orders,
    Key? key,
  }) : super(key: key);
  final OrderModel orders;
  final Function restartFunc;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buyingProductdetauil = orders.productdetailsIdList;
    final lydotucho = useTextEditingController();
    late IO.Socket socket;
// ---------------------

    // final userData = ref.watch(AppStateProvider.userNotifier);
    // final orders = ref
    //     .watch(AppStateProvider.orderTestNotifier)
    //     .values
    //     .toList()
    //     .firstWhere((element) => element.BuyingUserId == userData!.userId!);
    return CustomContainer(
      bottompadding: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: '  Quán : ',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(text: orders.restaurantName),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: '  Địa Chỉ: ',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(text: orders.address),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: '  Thời Gian Mua Hàng : ',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                const TextSpan(text: 'Ngày '),
                TextSpan(
                  text: orders.day,
                ),
                const TextSpan(text: ',  '),
                TextSpan(text: orders.hour),
                const TextSpan(text: ':'),
                TextSpan(text: orders.minute),
              ],
            ),
          ),
          const Text('  Đơn Hàng:'),
          ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: buyingProductdetauil.length,
              itemBuilder: (context, index) {
                final product = buyingProductdetauil[index];
                return BuyingProduct(
                  index: index,
                  ProductDetailData: product,
                  productId: '',
                  restart: () {},
                  productQuantity: buyingProductdetauil.length,
                );
              }),
          SizedBox(
            height: getProportionateScreenHeight(10),
          )
        ],
      ),
    );
  }
}