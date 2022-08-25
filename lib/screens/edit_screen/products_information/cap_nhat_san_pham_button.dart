import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/api_provider.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/model/product_model.dart';

import '../../../app_provider/utility_provider.dart';

class CapNhatThongTinSanPham extends HookConsumerWidget {
  const CapNhatThongTinSanPham(
      {required this.productImage,
      required this.productNameController,
      required this.productPriceThapNhatController,
      required this.productPriceCaoNhatController,
      required this.productRating,
      required this.productModel,
      Key? key})
      : super(key: key);
  final ValueNotifier<File?> productImage;
  final ProductModel productModel;
  final TextEditingController productNameController;

  final TextEditingController productPriceThapNhatController;
  final TextEditingController productPriceCaoNhatController;
  final String productRating;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(AppStateProvider.userNotifier);
    // print('productImage.value');
    // print(productImage.value);
    // print('productPriceCaoNhat');
    // print(productPriceCaoNhatController.text);
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

    final currentImagePath = productModel.productImage;
    // print('productImage.value');
    // print(productImage.value);
    // print('productModel.folderProductImage!');
    // print(productModel.folderProductImage!);
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
                        if (productImage.value != null) {
                          print('objectasdfasdfsdf');

                          // var imageFoldeStore = await ref
                          //     .read(API.product)
                          //     .createFolderProductImage(
                          //         // category: restaurantData!.restaurantCategory!,
                          //         restaurantName: checkNullStringToString(
                          //             serverData: productModel.restaurantName)!,
                          //         productName: checkInvalidStringToString(
                          //           localData: productName,
                          //           serverData: productModel.productName!,
                          //         )!);
                          image = await ref
                              .read(API.product)
                              .uploadProductImage(
                                  imageLink: productImage,
                                  // category: 'doan',
                                  restaurantName: checkNullStringToString(
                                      serverData: productModel.restaurantName)!,
                                  productName: checkInvalidStringToString(
                                    localData: productNameController.text,
                                    serverData: productModel.productName!,
                                  ),
                                  imageFoldeStore:
                                      '/' + productModel.folderProductImage!);
                          Navigator.pop(context);
                          await ref
                              .read(
                                  AppStateProvider.productEditNotifier.notifier)
                              .deleteProductImage(
                                productImage: currentImagePath!,
                                newProductImage: image,
                                productId: productModel.productId!,
                              );
                        } else {
                          print('elseelseelseelseelse ');
                          await ref
                              .read(
                                  AppStateProvider.productEditNotifier.notifier)
                              .getoneandupdate(
                                productImage: checkInvalidStringToString(
                                    localData: image,
                                    serverData: productModel.productImage!)!,
                                productName: checkInvalidStringToString(
                                  localData: productNameController.text,
                                  serverData: productModel.productName!,
                                )!,
                                productPriceCaoNhat: checkInvalidStringToDouble(
                                  localData: productPriceCaoNhatController.text,
                                  serverData: productModel.productPriceCaoNhat!,
                                )!,
                                productPriceThapNhat:
                                    checkInvalidStringToDouble(
                                  localData:
                                      productPriceThapNhatController.text,
                                  serverData:
                                      productModel.productPriceThapNhat!,
                                )!,
                                productRating: checkInvalidStringToDouble(
                                    localData: productRating,
                                    serverData: productModel.productRating!)!,
                                folderProductImage: productModel.productImage!,
                                isFavourite: productModel.isFavourite!,
                                isPopular: productModel.isPopular!,
                                productdetailIdList:
                                    productModel.productdetailIdList,
                                productId: productModel.productId!,
                                restaurantId: productModel.restaurantId!,
                                restaurantName: productModel.restaurantName!,
                                toppingList: productModel.toppingList,
                              );

                          Navigator.of(context).pop();
                        }

                        // if (productImage.value != null) {
                        //   await ref
                        //       .read(
                        //           AppStateProvider.productEditNotifier.notifier)
                        //       .deleteProductImage(
                        //           productImage: productModel.productImage!);
                        // }
                      },
                      child: Text("Đồng Ý"),
                    ),
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Text("Không"))
                  ],
                );
              });
        },
        child: Text('Cập Nhật'));
  }
}
