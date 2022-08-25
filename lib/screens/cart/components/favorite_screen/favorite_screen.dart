import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/model/topping_model.dart';

import 'package:untitled1/size_config.dart';

import '../../../home/components/product_detail_modal_sheet_home/topping_with_inform_home.dart';
import '../order_screen/product_visual/product_detail_one_cart.dart';
import 'product_detail_one_favorite.dart';
import 'topping_with_inform_favorite.dart';

class FavoriteScreen extends HookConsumerWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restart = useState<bool>(true);

    final favoriteProduct =
        ref.watch(AppStateProvider.productdetailMapNotifier);
    final user = ref.watch(AppStateProvider.userNotifier);
    final favoutielist = user!.favouriteProductDetails;
    final favoriteItem = ref
        .read(AppStateProvider.productdetailMapNotifier.notifier)
        .pullOutFavoriteItem(
          favoutielist: favoutielist!,
          stateData: favoriteProduct!.values.toList(),
        );

    Set<String> setOfproduct = {};
    for (final test in favoriteItem) {
      setOfproduct.add(test.productId!);
    }

    // print(toppings);

    // print('toppings');
    // print(toppings);
    // print('favoutielist');
    // print(favoutielist);

    // print('stateData.length favoriteScreen');
    // print(stateData.length);

    return ListView(
      shrinkWrap: true,
      primary: true,
      children: [
        if (favoriteItem.isEmpty)
          Container(
              alignment: Alignment.center,
              height: getProportionateScreenHeight(500),
              child: Text('Chọn sản phẩm')),
        if (favoriteItem.isNotEmpty)
          ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              shrinkWrap: true,
              primary: false,
              itemCount: setOfproduct.length,
              itemBuilder: (context, index) {
                final productsDetail = favoriteItem.where((element) {
                  return element.productId == setOfproduct.elementAt(index);
                }).toList();
                // final toppingsProduct = toppings.where((element) =>
                //     element.productId == '629610e7911c7e549dc8f812');
                // print('toppingsProduct');
                // print(toppingsProduct);
                return ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    ...productsDetail.map((e) => ProductDetailOneFavorite(
                          ProductDetailData: e,
                          productId: e.productId!,
                          restart: () {
                            restart.value = !restart.value;
                          },
                        )),
                    // ToppingButton(
                    //     toppingsProduct: toppingsProduct, restart: restart),
                  ],
                );
              })
      ],
    );
  }
}

class ToppingButton extends StatefulWidget {
  const ToppingButton({
    Key? key,
    required this.toppingsProduct,
    required this.restart,
  }) : super(key: key);

  final Iterable<ToppingModel> toppingsProduct;
  final ValueNotifier<bool> restart;

  @override
  State<ToppingButton> createState() => _ToppingButtonState();
}

class _ToppingButtonState extends State<ToppingButton> {
  var isShow = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isShow)
          for (var index = 0; index < widget.toppingsProduct.length; index++)
            ToppingWithInformFavorite(
              toppingModel: widget.toppingsProduct.elementAt(index),
              restartFunc: () {
                widget.restart.value = !widget.restart.value;
              },
            ),
        if (isShow)
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
        CustomerButton(
            text: ('Tuy Chon'),
            press: () async {
              setState(() {
                isShow = !isShow;
              });
            },
            buttonHeight: getProportionateScreenHeight(30),
            buttonWidth: double.infinity,
            BorderRadiuscircular: 10,
            backgoundColor: null),
      ],
    );
  }
}

// Container(
//   child: Text('sdkjfh'),
// );
