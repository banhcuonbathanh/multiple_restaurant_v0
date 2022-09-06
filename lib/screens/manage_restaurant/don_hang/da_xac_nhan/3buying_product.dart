import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:untitled1/app_provider/state_provider.dart';

import 'package:untitled1/components/custom_buttom.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/screens/home/components/product_detail_modal_sheet_home/topping_with_inform_home.dart';

import 'package:untitled1/size_config.dart';
import '4acceptordeniebutton.dart';

class BuyingProduct extends HookConsumerWidget {
  const BuyingProduct({
    required this.index,
    required this.productQuantity,
    required this.restart,
    required this.productId,
    Key? key,
    required this.ProductDetailData,
  }) : super(key: key);

  final ProductDetailModel ProductDetailData;
  final int index;
  final String productId;
  final Function restart;
  final int productQuantity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countConsitionForAnimation = useState<int>(0);

    final user = ref.watch(AppStateProvider.userNotifier);
    bool isFavorite = false;
    for (final String i in user!.favouriteProductDetails!) {
      if (ProductDetailData.productdetaiId == i) {
        isFavorite = true;
      }
    }
    final allToppings =
        ref.watch(AppStateProvider.toppingEditMapNotifier).values.toList();
    final toppingsProductdetail = allToppings
        .where(((element) =>
            element.productDetailId == ProductDetailData.productdetaiId))
        .toList();
    final isShowTopping = useState(true);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Picture(ProductDetailData: ProductDetailData),
              SizedBox(
                width: getProportionateScreenWidth(10),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Text(ProductDetailData.productdetaitName!),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Text('Thanh Phan'),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  FavoriteButton(
                    iconColor: Colors.blue,
                    isFavorite: isFavorite,
                    iconSize: 13,
                    // iconDisabledColor: Colors.white,
                    valueChanged: (_isFavorite) {
                      if (_isFavorite == true) {
                        // print('this true');
                        ref
                            .read(AppStateProvider.userNotifier.notifier)
                            .addFavouriteProductDetails(
                                productDetailId:
                                    ProductDetailData.productdetaiId!);
                        ProductDetailData.productdetaiIsFavourite;
                      }
                      if (_isFavorite == false) {
                        // print('this false');
                        ref
                            .read(AppStateProvider.userNotifier.notifier)
                            .removeFavouriteProductDetails(
                                productDetailId:
                                    ProductDetailData.productdetaiId!);
                        ProductDetailData.productdetaiIsFavourite;
                      }
                    },
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Text(ProductDetailData.productdetaiPrice!.toString()),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Text(ProductDetailData.productdetailBill.toString()),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomerButton(
            backgoundColor: null,
            BorderRadiuscircular: 10,
            buttonHeight: getProportionateScreenHeight(30),
            buttonWidth: double.infinity,
            press: () {
              isShowTopping.value = !isShowTopping.value;
            },
            text: 'Tuỳ Chọn',
          ),
        ),
        if (isShowTopping.value)
          for (var index = 0; index < toppingsProductdetail.length; index++)
            ToppingWithInformHome(
              toppingModel: toppingsProductdetail.elementAt(index),
              restartFunc: () {},
            ),
        // show greey distance
        if (productQuantity > 1 && index < productQuantity - 1)
          SizedBox(
            height: 10,
          ),
        if (productQuantity > 1 && index < productQuantity - 1)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade200,
            ),
            height: 15,
          ),
        if (productQuantity > 1 && index < productQuantity - 1)
          SizedBox(
            height: 10,
          ),
      ],
    );
  }
}

class Picture extends StatelessWidget {
  const Picture({
    Key? key,
    required this.ProductDetailData,
  }) : super(key: key);

  final ProductDetailModel ProductDetailData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(110),
      height: getProportionateScreenHeight(110),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          ProductDetailData.productdetaiImage!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
