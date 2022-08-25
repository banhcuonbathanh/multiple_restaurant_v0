import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/model/product_model.dart';
import 'package:untitled1/model/restaurant_model.dart';
import 'package:untitled1/screens/home/components/list_all_restaurant_product/one_restaurant.dart';
import 'package:untitled1/screens/home/components/product_detail_modal_sheet_home/product_detail_list_home.dart';
import 'package:untitled1/size_config.dart';

class ItemFilterRestaurant extends HookConsumerWidget {
  // final ScrollController controller;
  const ItemFilterRestaurant({
    // required this.controller,
    Key? key,
    required this.filterRestaurant,
    required this.title,
  }) : super(key: key);

  final List<RestaurantModel> filterRestaurant;
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restart = useState<bool>(true);
    final restarauntProduct = useState<bool>(true);
    final restaurandata = useState<RestaurantModel?>(null);
    List<ProductModel> restaurantProduct = [];
    if (restaurandata.value != null) {
      final allProduct =
          ref.watch(AppStateProvider.productMapNotifier)!.values.toList();
      restaurantProduct = allProduct
          .where((element) =>
              element.restaurantId == restaurandata.value!.restaurantId)
          .toList();
    }

    // final isTap = useState<bool>(false);
    //  final products = await ref
    //                           .read(
    //                               AppStateProvider.productMapNotifier.notifier)
    //                           .searchingProductsOfRestaurantUserId(
    //                               searchingKey: restaurantData.restaurantId!);
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: getProportionateScreenHeight(30),
            decoration: BoxDecoration(
              // color: Colors.white,
              color: Colors.white.withOpacity(1),
              // kSecondaryColor,
              borderRadius: BorderRadius.circular(14),
            ),
            width: double.infinity,
            child: Text(
              '    ${title}',
              style:
                  TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 14),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          restarauntProduct.value
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: filterRestaurant.length,
                  itemBuilder: (context, index) {
                    final restaurantData = filterRestaurant[index];
                    return rowofproductrestuant1(
                      restaurantData: restaurantData,
                      filterRestaurant: filterRestaurant,
                      index: index,
                      hideShowRestaurant: () {
                        restarauntProduct.value = !restarauntProduct.value;
                        restaurandata.value = restaurantData;
                        restart.value = !restart.value;
                      },
                    );
                  })
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(restaurandata.value!.restaurantName!),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          OneRestaurant(
                            restaurantData: restaurandata.value!,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          WrapProduct(
                            products: restaurantProduct,
                          ),
                          CustomerButton(
                              text: 'Xong Tìm Kiếm Nhà Hàng ',
                              press: () {
                                restarauntProduct.value =
                                    !restarauntProduct.value;
                                restart.value = !restart.value;
                              },
                              buttonHeight: getProportionateScreenHeight(30),
                              buttonWidth: getProportionateScreenWidth(350),
                              BorderRadiuscircular: 10,
                              backgoundColor: null)
                        ],
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

class rowofproductrestuant1 extends HookConsumerWidget {
  const rowofproductrestuant1({
    required this.hideShowRestaurant,
    required this.index,
    Key? key,
    required this.restaurantData,
    required this.filterRestaurant,
  }) : super(key: key);

  final RestaurantModel restaurantData;
  final List<RestaurantModel> filterRestaurant;
  final Function hideShowRestaurant;
  final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIsMounted = useIsMounted();
    final isShowListProducts = useState<bool>(false);
    // final restaurantIsShow = useState<int?>(null);
    final allProduct =
        ref.watch(AppStateProvider.productMapNotifier)!.values.toList();
    List<ProductModel> restaurantProduct = allProduct
        .where((element) => element.restaurantId == restaurantData.restaurantId)
        .toList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.9)),
          color: Colors.white.withOpacity(0.9),

          // kSecondaryColor,
          borderRadius: BorderRadius.circular(17),
        ),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenHeight(100),
        child: InkWell(
            onTap: () async {
              if (checkIsMounted() == true) {
                hideShowRestaurant();
                for (int index1 = 0;
                    index1 < filterRestaurant.length;
                    index1++) {
                  if (index1 == index) {
                    isShowListProducts.value = !isShowListProducts.value;
                  }
                }
              }

              final products = await ref
                  .read(AppStateProvider.productMapNotifier.notifier)
                  .searchingProductsOfRestaurantUserId(
                      searchingKey: restaurantData.restaurantId!);
              // restaurantIsShow.value = index;
              // if (restaurantIsShow.value == null) {
              //   print('bang null');
              //   restaurantIsShow.value = index;
              // } else {
              //   restaurantIsShow.value = null;
              //   print('khac null');
              // }

              // print(index);
              // isShowListProducts.value = !isShowListProducts.value;
              // showDialog(
              //     context: context,
              //     builder: (context) {
              //       return test(products: products);
              //     });
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(restaurantData.restaurantImage!),
                ),
                Spacer(),
                Text(restaurantData.restaurantName!,
                    style: TextStyle(color: Colors.black))
              ],
            )

            // !isShowListProducts.value
            //     ? Row(
            //         children: [
            //           ClipRRect(
            //             borderRadius: BorderRadius.circular(15),
            //             child: Image.network(restaurantData.restaurantImage!),
            //           ),
            //           Spacer(),
            //           Text(restaurantData.restaurantName!,
            //               style: TextStyle(color: Colors.black))
            //         ],
            //       )
            //     : test(products: restaurantProduct)

            ),
      ),
    );
  }
}

class WrapProduct extends HookConsumerWidget {
  const WrapProduct({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<ProductModel>? products;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      primary: false,
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 5 / 6,
      mainAxisSpacing: getProportionateScreenHeight(10),
      crossAxisSpacing: getProportionateScreenWidth(10),
      // alignment: WrapAlignment.start,
      children: [
        for (int index = 0; index < products!.length; index++)
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: GestureDetector(
              onTap: () async {
                await ref
                    .read(AppStateProvider.productdetailMapNotifier.notifier)
                    .addItem(productId: products![index].productId!);
                if (products![index].toppingList != null) {
                  await ref
                      .read(AppStateProvider.toppingEditMapNotifier.notifier)
                      .searchingToppingWithProductId(
                          productId: products![index].productId!);
                }

                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return ProductDetailList_Home(
                        serverProductId: products![index].productId!,
                        restaurantId: products![index].restaurantId!,
                      );
                    });
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(160),
                      height: getProportionateScreenHeight(110),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          products![index].productImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(products![index].productName!),
                        Row(
                          children: [
                            Text('Giá: '),
                            Text(products![index]
                                .productPriceThapNhat
                                .toString()),
                            Text('   -   '),
                            Text(products![index]
                                .productPriceCaoNhat
                                .toString()),
                          ],
                        ),
                      ],
                    ),
                    RatingBar.builder(
                        minRating: 1,
                        itemSize: 17,
                        updateOnDrag: true,
                        itemBuilder: (context, index) {
                          return Icon(
                            Icons.star,
                            color: Colors.yellowAccent,
                          );
                        },
                        onRatingUpdate: (rating) {}),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// class RestaurantProduct extends HookConsumerWidget {
//   final ScrollController controller;
//   const RestaurantProduct({
//     required this.controller,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final dx = useState(0.0);
//     final dy = useState(0.0);
//     useEffect(() {
//       // get dy of widget
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         final box = context.findRenderObject() as RenderBox;
//         dy.value = box.localToGlobal(Offset.zero).dy;
//         dx.value = box.localToGlobal(Offset.zero).dx;

// // store dy
//       });
//     });
//     print('-dy.value');
//     print(-dy.value);
//     print('controller');
//     print(controller.offset);
//     return gridlayoutproduct(listProducts: [], restaurantData: null, scontroller: null,);
//   }
// }
