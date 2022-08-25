import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/api_provider.dart';
import 'package:untitled1/app_provider/state_provider.dart';

import 'package:untitled1/model/productdetail_model.dart';

import 'package:untitled1/size_config.dart';

import '../../../home/components/product_detail_modal_sheet_home/customer_ordering_information.dart';
import 'ordering_button/ordering_button.dart';

import 'product_visual/productview.dart';

class Orderscreen extends HookConsumerWidget {
  final List<ProductDetailModel>? orderedProductdetails;
  const Orderscreen({required this.orderedProductdetails, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newAdressController = useTextEditingController();

    final restart = useState(false);
    final user = ref.watch(AppStateProvider.userNotifier);

    Set<String> setOfproduct = {};

    double totalBill = 0.0;
    if (orderedProductdetails != null) {
      for (final product in orderedProductdetails!) {
        setOfproduct.add(product.productId!);
      }

      for (final orderedProduct in orderedProductdetails!) {
        totalBill = totalBill + orderedProduct.productdetailBill!;
      }
    }

    final toppings =
        ref.watch(AppStateProvider.toppingEditMapNotifier).values.toList();

    return orderedProductdetails!.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: [
                CustomerOrderingInformation(
                  restaurantId: orderedProductdetails![0].restaurantId!,
                  newAdressController: newAdressController,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: setOfproduct.length,
                  itemBuilder: (context, index) {
                    final productsDetail =
                        orderedProductdetails!.where((element) {
                      return element.productId == setOfproduct.elementAt(index);
                    }).toList();
                    final toppingsProduct = toppings
                        .where((element) =>
                            element.productId == setOfproduct.elementAt(index))
                        .toList();
                    return ViewOfProduct(
                      restaurantId: orderedProductdetails![0].restaurantId!,
                      orderedProducts: productsDetail,
                      toppingList: toppingsProduct,
                      productId: setOfproduct.elementAt(index),
                      restartFunc: () {
                        restart.value = !restart.value;
                      },
                    );
                  },
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Tổng Tiền: ${totalBill}'),
                  ],
                ),
                orderbutton(
                    setOfproduct: setOfproduct,
                    orderedProductdetails: orderedProductdetails,
                    toppings: toppings,
                    newAdressController: newAdressController,
                    user: user),
                ElevatedButton(
                    onPressed: () {
                      ref.read(API.socket).sign_in(userId: user!.userId!);
                    },
                    child: Text('sing in')),
                ElevatedButton(
                    onPressed: () async {
                      final test = await ref
                          .read(AppStateProvider.orderNotifier.notifier)
                          .getOneOrderByBuyingUserId(
                              BuyingUserId: '62b2d37d9176c5d25ac393ab');
                      // print('test');
                      // print(test);
                    },
                    child: Text('get order')),
              ],
            ),
          )
        : Container(
            constraints: BoxConstraints.expand(),
            child: Center(child: Text('chua co san pham nao')),
          );
  }
}
