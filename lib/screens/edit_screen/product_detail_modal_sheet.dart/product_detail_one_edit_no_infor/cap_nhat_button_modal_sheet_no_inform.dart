import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/api_provider.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/snackbarcontent.dart';
import 'package:untitled1/model/product_model.dart';
import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/model/restaurant_model.dart';
import '../../../../app_provider/utility_provider.dart';

class CapNhatButtonModalSheetNoInfor extends HookConsumerWidget {
  CapNhatButtonModalSheetNoInfor({
    required this.promotion,
    required this.formKey,
    required this.productDetailDescription,
    required this.productDetailName,
    required this.productData,
    required this.restaurantsUserIdData,
    required this.productRestaurantImageLink,
    required this.productdetaiPrice,
    Key? key,
  }) : super(key: key);

  final TextEditingController productDetailName;
  final TextEditingController productDetailDescription;
  final ProductModel productData;
  final RestaurantModel? restaurantsUserIdData;
  final ValueNotifier<File?> productRestaurantImageLink;
  final TextEditingController productdetaiPrice;
  final GlobalKey<FormState> formKey;
  final TextEditingController promotion;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double? checkInvalidStringToDouble(
        {required String appData, required double? serverData}) {
      return appData == ''
          ? (serverData == null ? null : serverData)
          : double.parse(appData);
    }

    String? checkInvalidStringToString(
        {required String appData, required String? serverData}) {
      return appData == '' ? (serverData == null ? null : serverData) : appData;
    }

    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                String image = '';
                var imageFoldeStore = await ref
                    .read(API.productdetail)
                    .createFolderProductDetailImage(
                        category: restaurantsUserIdData!.restaurantCategory!,
                        productDetailName: productDetailName.text,
                        productName: productData.productName!,
                        restaurantName: restaurantsUserIdData!.restaurantName!);
                if (productRestaurantImageLink.value == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: SnackbarContend(
                      contend: 'Chưa Chọn Ảnh Sản Phẩm',
                    ),
                    action: SnackBarAction(
                      label: 'close',
                      textColor: Colors.red,
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ));
                  return;
                } else {
                  image = await ref
                      .read(API.productdetail)
                      .uploadProductDetailImage(
                        imageFoldeStore: imageFoldeStore,
                        imageLink: productRestaurantImageLink,
                        productDetailName: productDetailName.text,
                        productName: productData.productName!,
                        restaurantName: restaurantsUserIdData!.restaurantName!,
                      );
                }

                await ref
                    .read(AppStateProvider.productDetailEditState.notifier)
                    .createProductDetail(
                        productdetail: ProductDetailModel(
                      productdetaiId: null,
                      productdetaiImage: image,
                      productdetaiIsFavourite: null,
                      productdetaiIsPopular: null,
                      productdetaiPrice: double.parse(productdetaiPrice.text),
                      productdetaiRating: 0,
                      productdetaitName: productDetailName.text,
                      productId: productData.productId,
                      productName: productData.productName,
                      restaurantId: restaurantsUserIdData!.restaurantId,
                      restaurantName: restaurantsUserIdData!.restaurantName,
                      productdetailBill: 0,
                      productdetailQuantity: 0,
                      productdetaiDescription: productDetailDescription.text,
                      productdetailIdList: [],
                      productdetailFolder: imageFoldeStore,
                      userId: restaurantsUserIdData!.userId!,
                      toppingList: [],
                      promotion: int.parse(promotion.text),
                    ));

                productRestaurantImageLink.value = null;
                productDetailName.text = '';
                productDetailDescription.text = '';
                productdetaiPrice.text = '';
                promotion.text = '';
              }
              // ref.read(EditProductProvider.notifier).changetofalse();

              // await ref
              //     .read(DataNotifierProvider.productdetailTest.notifier)
              //     .searchingProductDetailWithProductId(
              //         searchingKey: productData.productId!);
              // print('4');
              // ref.read(EditProductProvider.notifier).changetotrue();
            },
            child: Text('Tạo Sản Phẩm')),
      ],
    );
  }
}
