import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/api_provider.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/model/productdetail_model.dart';

class UpdateButton extends HookConsumerWidget {
  const UpdateButton({
    Key? key,
    required this.productdetailImage,
    required this.productDetailModel,
    required this.productdetailNameController,
    required this.productdetailDescriptionController,
    required this.productdetailPriceController,
  }) : super(key: key);
  final ValueNotifier<File?> productdetailImage;
  final ProductDetailModel productDetailModel;
  final TextEditingController productdetailNameController;
  final TextEditingController productdetailDescriptionController;
  final TextEditingController productdetailPriceController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print('builf UpdateButton');
    // print('productdetailDescriptionController == ' '');
    // print(productDetailModel.productdetaiDescription);
    double? checkInvalidStringToDouble(
        {required String localData, required double serverData}) {
      return localData == '' ? serverData : double.parse(localData);
    }

    String? checkInvalidStringToString(
        {required String? localData, required String serverData}) {
      return localData == '' ? serverData : localData;
    }

    bool? checkInvalidBool(
        {required bool localData, required bool serverData}) {
      return localData == null ? serverData : localData;
    }

    String? checkNullStringToString({required String? serverData}) {
      String? response = '';
      if (serverData == null) {
        response = '';
      } else {
        response = serverData;
      }
      return response;
    }

    final currentImagePath = productDetailModel.productdetaiImage;
    return ElevatedButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('Cập Nhật'),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          String image = '';
                          if (productdetailImage.value != null) {
                            image = await ref
                                .read(API.productdetail)
                                .uploadProductDetailImage(
                                    imageLink: productdetailImage,
                                    // category: 'doan',
                                    restaurantName:
                                        productDetailModel.restaurantName!,
                                    productName: productDetailModel.productName,
                                    imageFoldeStore: '/' +
                                        productDetailModel.productdetailFolder!,
                                    productDetailName:
                                        checkInvalidStringToString(
                                      localData:
                                          productdetailNameController.text,
                                      serverData:
                                          productDetailModel.productdetaitName!,
                                    ));
                            Navigator.pop(context);
                            await ref
                                .read(AppStateProvider
                                    .productDetailEditState.notifier)
                                .deleteProductDetailImage(
                                  newProductDetailImage: image,
                                  productdetailId:
                                      productDetailModel.productdetaiId!,
                                  productdetailImage: currentImagePath!,
                                );
                          } else {
                            await ref
                                .read(AppStateProvider
                                    .productDetailEditState.notifier)
                                .getoneandupdate(
                                    productdetaitName:
                                        checkInvalidStringToString(
                                      localData:
                                          productdetailNameController.text,
                                      serverData:
                                          productDetailModel.productdetaitName!,
                                    )!,
                                    productdetaiDescription:
                                        checkInvalidStringToString(
                                      localData:
                                          productdetailDescriptionController
                                              .text,
                                      serverData: productDetailModel
                                          .productdetaiDescription!,
                                    )!,
                                    productdetaiImage:
                                        checkInvalidStringToString(
                                            localData: image,
                                            serverData: productDetailModel
                                                .productdetaiImage!)!,
                                    productdetaiId:
                                        productDetailModel.productdetaiId!,
                                    productdetaiPrice:
                                        checkInvalidStringToDouble(
                                      localData:
                                          productdetailPriceController.text,
                                      serverData:
                                          productDetailModel.productdetaiPrice!,
                                    )!,
                                    productdetaiRating:
                                        productDetailModel.productdetaiRating!,
                                    productdetailQuantity: productDetailModel
                                        .productdetailQuantity!,
                                    productdetailBill:
                                        productDetailModel.productdetailBill!,
                                    productdetaiIsFavourite: false,
                                    productdetaiIsPopular: false,
                                    restaurantName:
                                        productDetailModel.restaurantName!,
                                    restaurantId:
                                        productDetailModel.restaurantId!,
                                    productName:
                                        productDetailModel.productName!,
                                    productId: productDetailModel.productId!,
                                    productdetailIdList: [],
                                    productdetailFolder:
                                        productDetailModel.productdetailFolder,
                                    userId: productDetailModel.userId!);

                            Navigator.of(context).pop();
                          }
                        },
                        child: Text("Đồng Ý")),
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Text("Không"))
                  ],
                );
              });
        },
        child: Text("Cập Nhật"));
  }
}
