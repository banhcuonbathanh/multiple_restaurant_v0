import 'dart:io';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/constants.dart';
import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/screens/edit_screen/topping/topping_with_inform/topping_with_inform.dart';
import 'package:untitled1/screens/edit_screen/topping/topping_with_no_inform/topping_with_no_inform.dart';

import 'package:untitled1/size_config.dart';

import '../picture_frame/picture_frame_With_information.dart';
import 'row_product_detail_bill_with_inform.dart';
import 'row_product_detail_description_with_inform.dart';
import 'row_product_detail_name_with_inform.dart';
import 'row_product_detail_price_with_inform.dart';
import 'row_product_detail_promotion_with_inform.dart';
import 'update_button.dart';
import 'xoa_button.dart';

class ProductDetailOneEditWithInform extends HookConsumerWidget {
  const ProductDetailOneEditWithInform({
    required this.productId,
    Key? key,
    required this.ProductDetailData,
  }) : super(key: key);

  final ProductDetailModel ProductDetailData;
  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restart = useState<bool>(false);
    Function restartFunc = () {
      // print('restartFunc');
      restart.value = !restart.value;
    };
    final productdetailImageLink = useState<File?>(null);
    final productdetalPromotionController = useTextEditingController();
    final productdetalNameController = useTextEditingController();
    final descriptionSanPhamController = useTextEditingController();
    final priceSanPhamController = useTextEditingController();

    final billSanPhamController = useTextEditingController();
    // print('ProductDetailOneHome');
    // final listCartItem = ref.watch(CartItemNotifierProvider);
    final user = ref.watch(AppStateProvider.userNotifier);
    bool isFavorite = false;
    for (final String i in user!.favouriteProductDetails!) {
      if (ProductDetailData.productdetaiId == i) {
        isFavorite = true;
      }
    }
    final toppingList =
        ref.watch(AppStateProvider.toppingEditMapNotifier).values.toList();
    final toppingListOfProductDetail = toppingList
        .where((element) =>
            element.productDetailId == ProductDetailData.productdetaiId)
        .toList();
    // print('ProductDetailData');
    // print(ProductDetailData);
    return Padding(
      padding: EdgeInsets.only(bottom: getProportionateScreenHeight(25)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Flexible(
              //   flex: 3,
              //   child: Picture(ProductDetailData: ProductDetailData),
              // ),
              Container(
                width: getProportionateScreenWidth(90),
                child: PictureFrameProductDetailWithInfomation(
                  imageFileRestaurant: productdetailImageLink,
                  onPressImageFile: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      productdetailImageLink.value = File(image.path);
                    }
                  },
                  imageServer: ProductDetailData.productdetaiImage!,
                  longPressToDelete: () {},
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(5),
              ),
              Expanded(
                child: Container(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RowProductDetailName(
                        ref: ref,
                        serverProductName: ProductDetailData.productdetaitName!,
                        tenSanPhamController: productdetalNameController,
                      ),
                      RowProductDetailDescription(
                        ref: ref,
                        descriptionSanPhamController:
                            descriptionSanPhamController,
                        serverProductDetailDescription:
                            ProductDetailData.productdetaiDescription,
                      ),
                      RowProductDetailPromotion(
                        promotionSanPhamController:
                            productdetalPromotionController,
                        ref: ref,
                        serverProductPromotion:
                            ProductDetailData.promotion.toString(),
                      ),
                      // Text(
                      //   ProductDetailData.productdetaiDescription!,
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 2,
                      //   style: TextStyle(fontSize: 13),
                      // ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      FavoriteButton(
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
                ),
              ),
              Container(
                width: getProportionateScreenWidth(110),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),
                    // Text(ProductDetailData.productdetaiPrice!.toString()),
                    RowProductDetailPrice(
                      priceSanPhamController: priceSanPhamController,
                      ref: ref,
                      serverProductPrice:
                          ProductDetailData.productdetaiPrice!.toString(),
                    ),

                    RowProductDetailBill(
                      billSanPhamController: billSanPhamController,
                      ref: ref,
                      serverProductBill:
                          ProductDetailData.productdetailBill.toString(),
                    ),

                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),
                    Row(
                      children: [
                        AddButton(
                          ProductDetailData: ProductDetailData,
                          productId: productId,
                          ref: ref,
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(10),
                        ),
                        Text(
                          ProductDetailData.productdetailQuantity.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(10),
                        ),
                        RemoveButton(
                          ProductDetailData: ProductDetailData,
                          ref: ref,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          for (var index = 0;
              index < toppingListOfProductDetail.length;
              index++)
            ToppingWithInformEdit(
              toppingModel: toppingListOfProductDetail[index],
              restartFunc: restartFunc,
            ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Topping_NoInform(
              serverProductId: productId,
              restartFunc: restartFunc,
              serverProductdetailId: ProductDetailData.productdetaiId!),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              xoaButton(
                productdetaiId: ProductDetailData.productdetaiId!,
                productId: productId,
              ),
              SizedBox(
                width: getProportionateScreenWidth(20),
              ),
              UpdateButton(
                productdetailDescriptionController:
                    descriptionSanPhamController,
                productdetailImage: productdetailImageLink,
                productDetailModel: ProductDetailData,
                productdetailNameController: productdetalNameController,
                productdetailPriceController: priceSanPhamController,
              ),
            ],
          ),
        ],
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
      width: getProportionateScreenWidth(80),
      height: getProportionateScreenHeight(80),
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

class RemoveButton extends StatelessWidget {
  const RemoveButton({
    Key? key,
    required this.ProductDetailData,
    required this.ref,
  }) : super(key: key);

  final ProductDetailModel ProductDetailData;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return CustomerButton(
      backgoundColor: kPrimaryColor,
      BorderRadiuscircular: 8,
      buttonHeight: getProportionateScreenHeight(20),
      buttonWidth: getProportionateScreenWidth(30),
      press: () async {
        ref
            .read(AppStateProvider.productdetailMapNotifier.notifier)
            .editProductDetailRemove(
              productdetaiId: ProductDetailData.productdetaiId!,
              productId: ProductDetailData.productId!,
            );
        // ref
        //     .read(productDetailNotifierProvider.notifier)
        //     .editProductDetailRemove(
        //         productdetaiId: ProductDetailData.productdetaiId,
        //         productdetaiPrice: ProductDetailData.productdetaiPrice,
        //         productdetailQuantity:
        //             ProductDetailData.productdetailQuantity!);
      },
      text: '+',
      child: Icon(
        Icons.remove,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
    required this.ProductDetailData,
    required this.productId,
    required this.ref,
  }) : super(key: key);

  final ProductDetailModel ProductDetailData;
  final String productId;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return CustomerButton(
      backgoundColor: kPrimaryColor,
      BorderRadiuscircular: 8,
      buttonHeight: getProportionateScreenHeight(20),
      buttonWidth: getProportionateScreenWidth(30),
      press: () {
        ref
            .read(AppStateProvider.productdetailMapNotifier.notifier)
            .editProductDetailAdd(
              productdetaiId: ProductDetailData.productdetaiId!,
              productId: productId,
            );
      },
      text: '',
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}

//   TextButton(
//                           onPressed: () async {
//                             // ref.read(EditProductProvider.notifier).changetoState();
//                             // xoa san pham
//                             // ref
//                             //     .read(EditProductProvider.notifier)
//                             //     .changetoState();

//                             await ref
//                                 .read(DataNotifierProvider
//                                     .productdetailTest.notifier)
//                                 .deleteProductDetailWithId(
//                                     productdetaiId:
//                                         ProductDetailData.productdetaiId!,
//                                     productId: ProductDetailData.productId!);
//                             // await ref
//                             //     .read(productDetailNotifierProvider.notifier)
//                             //     .deleteProductDetailWithId(
//                             //         productdetaiId:
//                             //             ProductDetailData.productdetaiId!,
//                             //         productId: ProductDetailData.productId!);
//                             // Navigator.of(context).pop();
//                             await ref
//                                 .read(productDetailNotifierProvider.notifier)
//                                 .searchingProductDetailproductId(
//                                     searchingKey: ProductDetailData.productId!);

//                             // await ref
//                             //     .read(productNotifierProvider.notifier)
//                             //     .deleteProduct(
//                             //         productId: serverProductId,
//                             //         restaurantId: serverRestaurantId);
//                             // final restaruatdata = await ref
//                             //     .read(restaurantsNotifierProvider.notifier)
//                             //     .searchRestaurantsUserId(
//                             //         searchingkey: user!.restaurantId!);
//                             Navigator.of(context).pop();
// // cap nhat thong tin san pham

//                             //        await ref
//                             // .read(restaurantsNotifierProvider.notifier)
//                             // .searchUserSId(userId: restaurantData.userId!);
//                           },
//                           child: Text("Đồng Ý"),
//                         ),
