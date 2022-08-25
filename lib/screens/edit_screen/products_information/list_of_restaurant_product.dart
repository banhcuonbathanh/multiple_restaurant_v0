import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';

import 'restaurant_product_with_infor.dart';

class ListProductWithInfor extends HookConsumerWidget {
  const ListProductWithInfor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build ListProductWithInfor');
    final searchingProductsOfRestaurantUserId =
        ref.watch(AppStateProvider.productEditNotifier);
    print('searchingProductsOfRestaurantUserId.length');
    print(searchingProductsOfRestaurantUserId.length);
    // print(searchingProductsOfRestaurantUserId[1].restaurantName);
    // print(searchingProductsOfRestaurantUserId[8].restaurantName);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: searchingProductsOfRestaurantUserId.length,
          itemBuilder: (context, index) {
            final productData = searchingProductsOfRestaurantUserId[index];

            return RestaurantProductsWithInfor(
              serverRestaurantId: productData.restaurantId,
              index: index,
              productModel: productData,
            );
          }),
    );
  }
}
