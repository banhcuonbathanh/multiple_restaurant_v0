import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/model/product_model.dart';

import 'package:untitled1/model/restaurant_model.dart';

import '../../../../components/promotionItem.dart';
import '../../../../size_config.dart';
import '../filter/item_filter_restaurant.dart';
import '../list_all_restaurant_product/one_restaurant.dart';
import '../section_title.dart';

class Promotion extends HookConsumerWidget {
  const Promotion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promotionScrollerController = useScrollController();

    final isShowLoadingToFetch = useState(true);
    final page = useState<int>(1);
    // print('build Promotion');
    final allRestaurant =
        ref.watch(AppStateProvider.restaurantStateMap).values.toList();

    final promotionRestaurant = allRestaurant.where((res) {
      return res.promotionList!.length > 0;
    }).toList();
    final restarauntProduct = useState<bool>(true);
// ---------------------------------------------------
    bool isLodingMore = false;
    final hasMoreData = useState<bool>(true);
    Future<void> refresh() async {
      if (isLodingMore) return;

      isLodingMore = true;

      final test = await ref
          .read(AppStateProvider.restaurantStateMap.notifier)
          .searchingRestaurantPromotion(
              numberOfRestaurant: promotionRestaurant.length, page: page.value);
      if (test.length < 1) {
        hasMoreData.value = false;
      }
      isLodingMore = false;
      page.value = page.value + 1;
    }

    promotionScrollerController.addListener(() {
      if (promotionScrollerController.offset ==
          promotionScrollerController.position.maxScrollExtent) {
        isShowLoadingToFetch.value = true;
        refresh();
      } else {
        isShowLoadingToFetch.value = false;
      }
    });

    // for (final rest in allRestaurant) {
    //   print('rest.promotionList');
    //   print(rest.restaurantName);
    // }
    // print('res.promotionRestaurant');
    // print(promotionRestaurant[0].promotionList![0]);
    return Column(
      // shrinkWrap: true,
      // primary: false,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: PromotionTitle(
            press: () {},
            promotionRestaurant: promotionRestaurant,
          ),
        ),

        Container(
          height: getProportionateScreenHeight(100),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            controller: promotionScrollerController,
            children: [
              for (int index = 0; index < promotionRestaurant.length; index++)
                PromotionRestaurant(
                    promotionRestaurant: promotionRestaurant,
                    index: index,
                    restarauntProduct: restarauntProduct),
              // if (isShowLoadingToFetch.value)
              // if (true)
              //   Center(
              //     child: CircularProgressIndicator(),
              //   ),
              SizedBox(
                width: getProportionateScreenWidth(10),
              ),
              if (!isShowLoadingToFetch.value)
                Center(
                  child: hasMoreData.value
                      ? CircularProgressIndicator()
                      : Text('no data to load'),
                ),
              //  if (index == (restaurantDataWithCategories.length - 1) &&
              //     isShowLoadingToFetch.value)
              //   Center(
              //     child: hasMoreData.value
              //         ? CircularProgressIndicator()
              //         : Text('no more data to load'),
              //   ),
              //     children: [

              // for (int index = 0; index < promotionRestaurant.length; index++)
              //   PromotionItem(promotionRestaurant: promotionRestaurant[index])
              //     ],
            ],
          ),
        ),

        //   ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}

class PromotionRestaurant extends HookConsumerWidget {
  const PromotionRestaurant({
    Key? key,
    required this.promotionRestaurant,
    required this.index,
    required this.restarauntProduct,
  }) : super(key: key);

  final List<RestaurantModel> promotionRestaurant;
  final int index;
  final ValueNotifier<bool> restarauntProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restart = useState<bool>(true);
    List<ProductModel> restaurantProduct = [];
    final allProduct =
        ref.watch(AppStateProvider.productMapNotifier)!.values.toList();
    restaurantProduct = allProduct
        .where((element) =>
            element.restaurantId == promotionRestaurant[index].restaurantId)
        .toList();
    for (final product in restaurantProduct) {
      product.promotionList!.sort();
    }
    // restaurantProduct.sort((a, b) => b.promotionList!.reversed
    //     .toList()[0]!
    //     .compareTo(a.promotionList!.reversed.toList()[0]!));
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Container(
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
                      Text(promotionRestaurant[index].restaurantName!),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      OneRestaurant(
                        restaurantData: promotionRestaurant[index],
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
                            restarauntProduct.value = !restarauntProduct.value;
                            restart.value = !restart.value;
                            Navigator.pop(context);
                          },
                          buttonHeight: getProportionateScreenHeight(30),
                          buttonWidth: getProportionateScreenWidth(350),
                          BorderRadiuscircular: 10,
                          backgoundColor: null)
                    ],
                  ),
                ),
              );
            });
      },
      child: PromotionItem(
        picture: promotionRestaurant[index].restaurantImage!,
        promotionList: promotionRestaurant[index].promotionList!,
        pictureHeight: 100,
        pictureWith: 200,
      ),
    );
  }
}

class PromotionItem1 extends StatelessWidget {
  const PromotionItem1({
    Key? key,
    required this.promotionList,
    required this.picture,
    required this.pictureWith,
    required this.pictureHeight,
  }) : super(key: key);

  // final RestaurantModel promotionRestaurant;
  final List<int?> promotionList;
  final String picture;
  final double pictureWith;
  final double pictureHeight;
  @override
  Widget build(BuildContext context) {
    // final promotionList = promotionRestaurant.promotionList!;
    promotionList.sort();

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: Stack(
        children: [
          SizedBox(
            width: getProportionateScreenWidth(pictureWith),
            height: getProportionateScreenWidth(pictureHeight),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                picture,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            right: getProportionateScreenWidth(0),
            top: getProportionateScreenHeight(0),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(17)),
              child: Text(promotionList.last.toString() + ' %',
                  style: TextStyle(
                    backgroundColor: Colors.orange.withOpacity(0.7),
                    fontSize: 15,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 7.0,
                        color: Colors.white,
                        offset: Offset(0, 0),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
