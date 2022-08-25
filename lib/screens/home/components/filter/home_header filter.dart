import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';

import 'package:untitled1/components/custom_buttom.dart';

import 'package:untitled1/model/product_model.dart';
import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/model/restaurant_model.dart';
import 'package:untitled1/screens/home/components/filter/item_filter_productdetail.dart';
import 'package:untitled1/screens/home/components/filter/item_filter_restaurant.dart';

import '../../../../size_config.dart';
import 'item_filter_product.dart';

class HomeHeaderFilter extends HookConsumerWidget {
  HomeHeaderFilter({
    required this.controller,
    Key? key,
  }) : super(key: key);
  final ScrollController controller;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProducts =
        ref.read(AppStateProvider.productMapNotifier)!.values.toList();
    final allProductsDetail =
        ref.read(AppStateProvider.productdetailMapNotifier)!.values.toList();
    final allRestaurant =
        ref.read(AppStateProvider.restaurantStateMap).values.toList();
    final filterProducts = useState<List<ProductModel>>([]);
    final filterProductsDetail = useState<List<ProductDetailModel>>([]);
    final filterRestaurant = useState<List<RestaurantModel>>([]);
    void searchProducts({required String search}) {
      final listProducts = allProducts.where((allProducts) {
        final productsName = allProducts.productName!.toLowerCase();
        final input = search.toLowerCase();
        return productsName.contains(input);
      }).toList();
      filterProducts.value = listProducts;

      // -----------------------------
      final listProductsDetail = allProductsDetail.where((allProductsDetail) {
        final productsName = allProductsDetail.productdetaitName!.toLowerCase();
        final input = search.toLowerCase();
        return productsName.contains(input);
      }).toList();
      filterProductsDetail.value = listProductsDetail;
      // -----------------------------
      final listRestaurant = allRestaurant.where((allRestaurant) {
        final restaurantName = allRestaurant.restaurantName!.toLowerCase();
        final input = search.toLowerCase();
        return restaurantName.contains(input);
      }).toList();
      filterRestaurant.value = listRestaurant;
    }

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              width: getProportionateScreenWidth(365),
              decoration: BoxDecoration(
                color: Colors.white,

                // kSecondaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                  onChanged: (value) {
                    searchProducts(search: value);
                    // ref
                    //     .read(Utility.searchValue.notifier)
                    //     .searchValue(searchValue: value);
                    // searchValue.value = value;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20),
                          vertical: getProportionateScreenWidth(9)),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "Search product",
                      prefixIcon: Icon(Icons.search))),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          ItemFilterRestaurant(
            filterRestaurant: filterRestaurant.value,
            title: 'Nhà Hàng',
          ),
          ItemFilterProduct(
            filterProducts: filterProducts,
            title: 'Món Ăn',
          ),
          ItemFilterProductDetail(
            filterProducts: filterProductsDetail,
            title: 'Sản Phẩm',
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomerButton(
                text: 'Xong',
                press: () {
                  Navigator.pop(context);
                },
                buttonHeight: getProportionateScreenHeight(40),
                buttonWidth: getProportionateScreenWidth(300),
                BorderRadiuscircular: 15,
                backgoundColor: null),
          )
        ],
      ),
    );
  }
}
