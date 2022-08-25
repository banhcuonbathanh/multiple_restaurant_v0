import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/model/product_model.dart';

import '../../../model/restaurant_model.dart';
import '../../../size_config.dart';
import 'filter/item_filter_restaurant.dart';
import 'list_all_restaurant_product/one_restaurant.dart';

class PromotionTitle extends HookConsumerWidget {
  const PromotionTitle({
    required this.promotionRestaurant,
    Key? key,
    required this.press,
  }) : super(key: key);

  final GestureTapCallback press;
  final List<RestaurantModel> promotionRestaurant;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Khuyến Mại',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(14),
            color: Colors.black,
          ),
        ),
        IconButton(
            onPressed: () async {
              if (promotionRestaurant.length < 5) {
                final test = await ref
                    .read(AppStateProvider.restaurantStateMap.notifier)
                    .searchingRestaurantPromotion(
                        numberOfRestaurant: promotionRestaurant.length,
                        page: 1);
              }
              if (promotionRestaurant.length < 9 &&
                  promotionRestaurant.length > 5) {
                final test = await ref
                    .read(AppStateProvider.restaurantStateMap.notifier)
                    .searchingRestaurantPromotion(
                        numberOfRestaurant: promotionRestaurant.length,
                        page: 2);
              }
              showDialog(
                  context: context,
                  builder: (context) {
                    return Scaffold(
                      backgroundColor: Colors.white.withOpacity(0),
                      body: ListView.builder(
                          itemCount: promotionRestaurant.length + 1,
                          itemBuilder: (context, index) {
                            if (index < promotionRestaurant.length) {
                              final restaurant = promotionRestaurant[index];
                              final promotion = restaurant.promotionList!;
                              promotion.sort();
                              return RestaurantItem(
                                  restaurant: restaurant, promotion: promotion);
                            } else {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        getProportionateScreenWidth(10)),
                                child: CustomerButton(
                                  backgoundColor: null,
                                  BorderRadiuscircular: 10,
                                  buttonHeight:
                                      getProportionateScreenHeight(30),
                                  buttonWidth: getProportionateScreenWidth(300),
                                  press: () {
                                    Navigator.pop(context);
                                  },
                                  text: 'Xong',
                                ),
                              );
                            }
                          }),
                    );
                  });
            },
            icon: Icon(
              Icons.chevron_right,
              color: Colors.grey,
            )),
      ],
    );
  }
}

class RestaurantItem extends HookConsumerWidget {
  const RestaurantItem({
    Key? key,
    required this.restaurant,
    required this.promotion,
  }) : super(key: key);

  final RestaurantModel restaurant;
  final List<int?> promotion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ProductModel> restaurantProduct = [];
    final allProduct =
        ref.watch(AppStateProvider.productMapNotifier)!.values.toList();
    restaurantProduct = allProduct
        .where((element) => element.restaurantId == restaurant.restaurantId)
        .toList();
    promotion.sort();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(5),
        alignment: Alignment.centerLeft,
        height: getProportionateScreenHeight(115),
        decoration: BoxDecoration(
          // color: Colors.white,
          color: Colors.white.withOpacity(1),
          // kSecondaryColor,
          borderRadius: BorderRadius.circular(14),
        ),
        width: double.infinity,
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Scaffold(
                    backgroundColor: Colors.white.withOpacity(0),
                    body: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView(
                            shrinkWrap: true,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(restaurant.restaurantName!)),
                                  Text(
                                    'KM: ' + promotion.last!.toString() + '%',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(10),
                              ),
                              OneRestaurant(
                                restaurantData: restaurant,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              WrapProduct(
                                products: restaurantProduct,
                              ),
                              CustomerButton(
                                  text: 'Xong  ',
                                  press: () {
                                    Navigator.pop(context);
                                  },
                                  buttonHeight:
                                      getProportionateScreenHeight(30),
                                  buttonWidth: getProportionateScreenWidth(350),
                                  BorderRadiuscircular: 10,
                                  backgoundColor: null)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(restaurant.restaurantImage!),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '  Quán: ${restaurant.restaurantName}',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7), fontSize: 14),
                    ),
                    Text(
                      '  Địa Chỉ: ${restaurant.restaurantAdrress}',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7), fontSize: 14),
                    ),
                    Row(
                      children: [
                        Text(
                          '  Giờ mở quán: ',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 14),
                        ),
                        Text(
                          '${restaurant.restaurantStartTime}',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 14),
                        ),
                        Text(
                          ' - ',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 14),
                        ),
                        Text(
                          ' ${restaurant.restaurantEndingTime}',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 14),
                        ),
                      ],
                    ),
                    Text(
                      '  KM:  ${promotion.last} % ',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
