import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/model/topping_model.dart';
import 'package:untitled1/size_config.dart';

import '../../favorite_screen/topping_with_inform_favorite.dart';
import 'product_detail_one_cart.dart';
import 'time_ordering.dart';

class ViewOfProduct extends HookConsumerWidget {
  const ViewOfProduct({
    required this.restaurantId,
    required this.restartFunc,
    required this.productId,
    Key? key,
    required this.orderedProducts,
    required this.toppingList,
  }) : super(key: key);

  final List<ProductDetailModel> orderedProducts;
  final Function restartFunc;
  final List<ToppingModel> toppingList;
  final String productId;

  final String restaurantId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isShow = useState(false);
    final recevingHour = useState<int>(6);
    final recevingMinute = useState<int>(0);
    final recevingDay = useState<String>('hom_nay');

    double totalBill = 0.0;
    for (final orderedProduct in orderedProducts) {
      totalBill = totalBill + orderedProduct.productdetailBill!;
    }
    // print('toppingList');
    // print(toppingList);
    return ListView(
      shrinkWrap: true,
      primary: false,
      children: [
        if (orderedProducts.length == 0)
          Container(
              alignment: Alignment.center,
              height: getProportionateScreenHeight(500),
              child: Text('Bạn Chưa Chọn Sản Sản Phẩm Nào')),
        if (orderedProducts.length != 0)
          Text('    :  ${orderedProducts[0].productName}  '),
        if (orderedProducts.length != 0)
          ...orderedProducts.map((data) => ProductDetailOnecart(
                ProductDetailData: data,
                productId: data.productId!,
                restart: () {
                  restartFunc();
                },
              )),

        // Timingorder(
        //     recevingHour: recevingHour,
        //     recevingMinute: recevingMinute,
        //     recevingDay: recevingDay,
        //     restaurantId: restaurantId),
        // SizedBox(
        //   height: getProportionateScreenHeight(15),
        // ),
        // CustomerButton(
        //     text: ('Tuy Chon'),
        //     press: () async {
        //       ref
        //           .read(AppStateProvider.toppingEditMapNotifier.notifier)
        //           .searchingToppingWithProductId(productId: productId);
        //       isShow.value = !isShow.value;
        //       // print('isShow.value');
        //       // print(isShow.value);
        //     },
        //     buttonHeight: getProportionateScreenHeight(30),
        //     buttonWidth: double.infinity,
        //     BorderRadiuscircular: 10,
        //     backgoundColor: null),
        if (isShow.value)
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
        if (isShow.value)
          ListView(
            shrinkWrap: true,
            children: [
              for (var index = 0; index < toppingList.length; index++)
                ToppingWithInformFavorite(
                  toppingModel: toppingList.elementAt(index),
                  restartFunc: () {
                    restartFunc();
                  },
                ),
            ],
          ),

        // ToppingButtonOrder(toppingsProduct: toppingList, restart: restart),
      ],
    );
  }
}
