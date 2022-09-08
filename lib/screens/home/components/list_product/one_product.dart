import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/model/product_model.dart';

import 'package:untitled1/screens/home/components/product_detail_modal_sheet_home/product_detail_list_home.dart';
import 'package:untitled1/size_config.dart';

import '../../../../components/promotionItem.dart';

class GridLayoutOneProduct extends HookConsumerWidget {
  const GridLayoutOneProduct({
    required this.index,
    required this.scontroller,
    Key? key,
    required this.ProductData,
  }) : super(key: key);

  final ProductModel ProductData;
  final ScrollController scontroller;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationIsHalf = useState(true);
    late double offsety = 0;
    final deviceheigh = MediaQuery.of(context).size.height;
    // ---------------------
    final slidingtransCon_LR =
        useAnimationController(duration: Duration(milliseconds: 700));

    final Animation<Offset> slidingAni = Tween<Offset>(
      begin: index.isEven ? Offset(-.4, 0.0) : Offset(.4, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(slidingtransCon_LR);
    // --------------------------------
    final fadetransCon =
        useAnimationController(duration: Duration(milliseconds: 700));

    final Animation<double> fadeAni = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(fadetransCon);
    // --------------------------------

    final Animation<double> scaleAni = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(fadetransCon);
    useEffect(() {
      scontroller.addListener(
        () {
          // print('<<<<<<<<<<<<<<<<<<<<<<<<<<');
          final box = context.findRenderObject() as RenderBox;
          offsety = box.localToGlobal(Offset.zero).dy;

          if (offsety < (deviceheigh) - 150 && offsety > 0) {
            slidingtransCon_LR.forward();
            fadetransCon.forward();
          } else {
            slidingtransCon_LR.reverse();
            fadetransCon.reverse();
          }
        },
      );
    }, [scontroller]);
    // print('GridLayoutOneProduct');
    final productdetails =
        ref.watch(AppStateProvider.productdetailMapNotifier)!;

    return ScaleTransition(
      scale: scaleAni,
      child: FadeTransition(
        opacity: fadeAni,
        child: SlideTransition(
          position: slidingAni,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade50),
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: () async {
                // ref
                //     .read(productDetailNotifierProvider.notifier)
                //     .getProductDetailproductId(searchingKey: ProductData.productId!);

                await ref
                    .read(AppStateProvider.productdetailMapNotifier.notifier)
                    .addItem(productId: ProductData.productId!);
                if (ProductData.toppingList != null) {
                  await ref
                      .read(AppStateProvider.toppingEditMapNotifier.notifier)
                      .searchingToppingWithProductId(
                          productId: ProductData.productId!);
                }

                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return ProductDetailList_Home(
                        serverProductId: ProductData.productId!,
                        restaurantId: ProductData.restaurantId!,
                      );
                    });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PromotionItem(
                    picture: ProductData.productImage!,
                    pictureHeight: 110,
                    pictureWith: 160,
                    promotionList: ProductData.promotionList!,
                    padding: 0,
                  ),
                  // SizedBox(
                  //   width: getProportionateScreenWidth(160),
                  //   height: getProportionateScreenHeight(110),
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(20),
                  //     child: Stack(
                  //       children: [
                  //         Image.network(
                  //           ProductData.productImage!,
                  //           fit: BoxFit.cover,
                  //         ),
                  //         // Positioned(
                  //         //   right: 30,
                  //         //   child: Text(ProductData.pro),
                  //         // )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Text(ProductData.productName!),
                  Row(
                    children: [
                      Text('Giá: '),
                      Text(ProductData.productPriceThapNhat.toString()),
                      Text('   -   '),
                      Text(ProductData.productPriceCaoNhat.toString()),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     CustomerButton(
                  //       backgoundColor: kPrimaryColor,
                  //       BorderRadiuscircular: 8,
                  //       buttonHeight: getProportionateScreenHeight(25),
                  //       buttonWidth: getProportionateScreenWidth(40),
                  //       press: () async {
                  //         // ref.read(CartItemNotifierProvider.notifier).addItem(
                  //         //         cartItem: CartItemModel(
                  //         //       cartdetaiIsFavourite: null,
                  //         //       cartdetaiIsPopular: null,
                  //         //       cartdetailBill: null,
                  //         //       cartdetailQuantity: 1,
                  //         //       cartdetaiPrice: ProductDetailData.productdetaiPrice,
                  //         //       cartdetaiRating: ProductDetailData.productdetaiRating,
                  //         //       cartitemDescription:
                  //         //           ProductDetailData.productdetaiDescription,
                  //         //       cartitemiId: '',
                  //         //       cartitemImage: ProductDetailData.productdetaiImage,
                  //         //       cartitemName: ProductDetailData.productdetaitName,
                  //         //       productdetailId: ProductDetailData.productdetaiId,
                  //         //       productdetailIdList:
                  //         //           ProductDetailData.productdetailIdList,
                  //         //       productId: ProductDetailData.productId,
                  //         //       productName: ProductDetailData.productName,
                  //         //       restaurantId: ProductDetailData.restaurantId,
                  //         //       restaurantName: ProductDetailData.restaurantName,
                  //         //     ));
                  //         // ref
                  //         //     .read(productDetailNotifierProvider.notifier)
                  //         //     .editProductDetailAdd(
                  //         //         productdetaiImage:
                  //         //             ProductDetailData.productdetaiImage,
                  //         //         productdetaiIsFavourite: null,
                  //         //         productdetaiIsPopular: null,
                  //         //         productdetaiRating: 0,
                  //         //         productdetaitName:
                  //         //             ProductDetailData.productdetaitName,
                  //         //         productId: ProductDetailData.productId,
                  //         //         productName: ProductDetailData.productName,
                  //         //         restaurantId: ProductDetailData.restaurantId,
                  //         //         restaurantName: ProductDetailData.restaurantName,
                  //         //         productdetaiDescription:
                  //         //             ProductDetailData.productdetaiDescription,
                  //         //         productdetailIdList:
                  //         //             ProductDetailData.productdetailIdList,
                  //         //         productdetaiId: ProductDetailData.productdetaiId,
                  //         //         productdetaiPrice:
                  //         //             ProductDetailData.productdetaiPrice,
                  //         //         productdetailQuantity:
                  //         //             ProductDetailData.productdetailQuantity!);
                  //         // await ref
                  //         //     .read(DataNotifierProvider.productdetailTest.notifier)
                  //         //     .searchingProductDetailWithProductId(
                  //         //         searchingKey: ProductDetailData.productId!);
                  //       },
                  //       text: '',
                  //       child: Icon(
                  //         Icons.add,
                  //         color: Colors.white,
                  //         size: 20,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: getProportionateScreenWidth(10),
                  //     ),
                  //     CustomerButton(
                  //       backgoundColor: kPrimaryColor,
                  //       BorderRadiuscircular: 8,
                  //       buttonHeight: getProportionateScreenHeight(25),
                  //       buttonWidth: getProportionateScreenWidth(40),
                  //       press: () async {
                  //         // ref
                  //         //     .read(productDetailNotifierProvider.notifier)
                  //         //     .editProductDetailRemove(
                  //         //         productdetaiImage:
                  //         //             ProductDetailData.productdetaiImage,
                  //         //         productdetaiIsFavourite: null,
                  //         //         productdetaiIsPopular: null,
                  //         //         productdetaiRating: 0,
                  //         //         productdetaitName:
                  //         //             ProductDetailData.productdetaitName,
                  //         //         productId: ProductDetailData.productId,
                  //         //         productName: ProductDetailData.productName,
                  //         //         restaurantId: ProductDetailData.restaurantId,
                  //         //         restaurantName: ProductDetailData.restaurantName,
                  //         //         productdetaiDescription:
                  //         //             ProductDetailData.productdetaiDescription,
                  //         //         productdetailIdList:
                  //         //             ProductDetailData.productdetailIdList,
                  //         //         productdetaiId: ProductDetailData.productdetaiId,
                  //         //         productdetaiPrice:
                  //         //             ProductDetailData.productdetaiPrice,
                  //         //         productdetailQuantity:
                  //         //             ProductDetailData.productdetailQuantity!);
                  //         // await ref
                  //         //     .read(DataNotifierProvider.productdetailTest.notifier)
                  //         //     .searchingProductDetailWithProductId(
                  //         //         searchingKey: ProductDetailData.productId!);

                  //         // ref.read(productDetailNotifierProvider.notifier).editProduct(
                  //         //       productdetaiId: ProductDetailData.productdetaiId,
                  //         //       productdetaiImage: ProductDetailData.productdetaiImage,
                  //         //       productdetaiIsFavourite: null,
                  //         //       productdetaiIsPopular: null,
                  //         //       productdetailQuantity:
                  //         //           ProductDetailData.productdetailQuantity! - 1,
                  //         //       productdetaiPrice: ProductDetailData.productdetaiPrice,
                  //         //       productdetaiRating: 0,
                  //         //       productdetaitName: ProductDetailData.productdetaitName,
                  //         //       productId: ProductDetailData.productId,
                  //         //       productName: ProductDetailData.productName,
                  //         //       restaurantId: ProductDetailData.restaurantId,
                  //         //       restaurantName: ProductDetailData.restaurantName,
                  //         //       productdetaiDescription:
                  //         //           ProductDetailData.productdetaiDescription,
                  //         //       productdetailIdList:
                  //         //           ProductDetailData.productdetailIdList,
                  //         //     );
                  //       },
                  //       text: '+',
                  //       child: Icon(
                  //         Icons.remove,
                  //         color: Colors.white,
                  //         size: 20,
                  //       ),
                  //     ),
                  //     Spacer(),
                  //     // Text(ProductDetailData.productdetailQuantity.toString()),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Tổng Tiền :'),
                  //     // Text(ProductDetailData.productdetailBill.toString()),
                  //   ],
                  // ),

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
      ),
    );
  }
}
