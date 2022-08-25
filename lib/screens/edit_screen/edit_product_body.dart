import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/coustom_bottom_nav_bar.dart';
import 'package:untitled1/enums.dart';

import 'package:untitled1/size_config.dart';

import 'products_information/list_of_restaurant_product.dart';
import 'products_with_no_infor/restaurant_product_with_no_infor.dart';
import 'restaurant_no_infomration/restaurant_no_information.dart';
import 'restaurant_with_infomration/restaurant_with_information.dart';

class EditProduct extends HookConsumerWidget {
  static String routeName = "/Edit_Product";
  const EditProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build EditProduct');

    SizeConfig().init(context);
    final currentUser = ref.watch(AppStateProvider.userNotifier);
    // print('currentUser?.restaurantId!');
    // print(currentUser?.restaurantId);
    return Scaffold(
      appBar: AppBar(
        title: Text('edit product'),
      ),
      body: SingleChildScrollView(
        child: (currentUser?.restaurantId != null &&
                currentUser?.restaurantId != '')
            ? const RestaurantsAndProductsWithInformation()
            : const RestaurantNoInformation(),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.message),
    );
  }
}

class RestaurantsAndProductsWithInformation extends StatelessWidget {
  const RestaurantsAndProductsWithInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          RestaurantWithInformation(),

          Divider(),
          ListProductWithInfor(),

          ProductsWithNoInfor(),

          //
        ],
      ),
    );
  }
}
