import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';

import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/components/custom_container.dart';
import 'package:untitled1/components/customer_favorite_button.dart';

import 'package:untitled1/model/productdetail_model.dart';

import 'package:untitled1/size_config.dart';

import '../../../../components/add_button.dart';
import '../../../../components/remove_button.dart';
import 'topping_with_inform_home.dart';

class ProductDetailOneHome extends HookConsumerWidget {
  const ProductDetailOneHome({
    required this.restart,
    required this.productId,
    Key? key,
    required this.ProductDetailData,
  }) : super(key: key);

  final ProductDetailModel ProductDetailData;

  final String productId;
  final Function restart;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print('ProductDetailOneHome');
    // final listCartItem = ref.watch(CartItemNotifierProvider);
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
    return Padding(
      padding: EdgeInsets.only(bottom: getProportionateScreenHeight(20)),
      child: CustomContainer(
        bottompadding: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
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
                      if (ProductDetailData.promotion != null)
                        Text(
                          'KM: ${ProductDetailData.promotion.toString()} %',
                          style: const TextStyle(color: Colors.red),
                        ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Text('Thanh Phan'),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      CustomerFavoriteButton(
                        isFavorite: isFavorite,
                        ProductDetailData: ProductDetailData,
                        ref: ref,
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      RichText(
                        text: TextSpan(
                          text: ProductDetailData.productdetaiPrice!.toString(),
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            if (ProductDetailData.promotion != null)
                              TextSpan(
                                  text: ' x ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10)),
                            if (ProductDetailData.promotion != null)
                              TextSpan(
                                  text: ProductDetailData.promotion!.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.red)),
                            if (ProductDetailData.promotion != null)
                              TextSpan(
                                  text: '%',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.red)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      if (ProductDetailData.promotion != null)
                        Text(((ProductDetailData.productdetailBill!) *
                                (ProductDetailData.promotion!) /
                                100)
                            .toString()),
                      if (ProductDetailData.promotion == null)
                        Text(((ProductDetailData.productdetailBill!)
                            .toString())),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Row(
                        children: [
                          AddButton(
                            restart: restart,
                            ProductDetailData: ProductDetailData,
                            productId: productId,
                            ref: ref,
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(10),
                          ),
                          Text(ProductDetailData.productdetailQuantity
                              .toString()),
                          SizedBox(
                            width: getProportionateScreenWidth(10),
                          ),
                          RemoveButton(
                            restart: restart,
                            ProductDetailData: ProductDetailData,
                            ref: ref,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              CustomerButton(
                backgoundColor: null,
                BorderRadiuscircular: 10,
                buttonHeight: getProportionateScreenHeight(30),
                buttonWidth: double.infinity,
                press: () {
                  isShowTopping.value = !isShowTopping.value;
                },
                text: 'Tuỳ Chọn',
              ),
              if (isShowTopping.value)
                for (var index = 0;
                    index < toppingsProductdetail.length;
                    index++)
                  ToppingWithInformHome(
                    toppingModel: toppingsProductdetail.elementAt(index),
                    restartFunc: () {},
                  ),

              // ToppingWithInformHome(
              //   restartFunc: () {}, toppingModel: null,
              // ),
            ],
          ),
        ),
      ),
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
