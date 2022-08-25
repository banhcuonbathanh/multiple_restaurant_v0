import 'package:flutter/material.dart';
import 'package:untitled1/model/product_model.dart';
import 'package:untitled1/model/restaurant_model.dart';
import 'package:untitled1/size_config.dart';

import 'one_product.dart';

class gridlayoutproduct extends StatelessWidget {
  const gridlayoutproduct({
    Key? key,
    required this.listProducts,
    required this.restaurantData,
    required this.scontroller,
  }) : super(key: key);

  final List<ProductModel> listProducts;
  final RestaurantModel restaurantData;
  final ScrollController scontroller;
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      removeBottom: true,
      context: context,
      child: GridView.count(
        primary: false,
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 6 / 6,
        mainAxisSpacing: getProportionateScreenHeight(10),
        crossAxisSpacing: getProportionateScreenWidth(10),
        children: [
          for (int index = 0; index < listProducts.length; index++)
            GridLayoutOneProduct(
              ProductData: listProducts[index],
              scontroller: scontroller,
              index: index,
            ),
        ],
      ),
    );
  }
}
