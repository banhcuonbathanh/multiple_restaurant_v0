import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/model/restaurant_model.dart';
import 'package:untitled1/model/user_model.dart';
import 'package:untitled1/size_config.dart';
import '../../../../app_provider/api_provider.dart';

class UpdateRestaurantInform extends HookConsumerWidget {
  UpdateRestaurantInform({
    Key? key,
    required this.restaurantCategory,
    required this.restaurantNameController,
    required this.restaurantImageLink,
    required this.categoryIndex,
    required this.restaurantsUserIdData,
    required this.restaurantAddressController,
    required this.restaurantServiceTimeStartController,
    required this.restaurantServiceTimeEndController,
    required this.restaurantTimeMealPreparationController,
    required this.isShip,
    required this.isBooking,
    required this.user,
  }) : super(key: key);

  final String restaurantCategory;
  final TextEditingController restaurantNameController;
  final ValueNotifier<File?> restaurantImageLink;
  final ValueNotifier<String> categoryIndex;
  final RestaurantModel restaurantsUserIdData;
  final TextEditingController restaurantAddressController;
  final TextEditingController restaurantServiceTimeStartController;
  final TextEditingController restaurantServiceTimeEndController;
  final TextEditingController restaurantTimeMealPreparationController;
  final ValueNotifier<bool> isShip;
  final ValueNotifier<bool> isBooking;
  final UserModel? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print('restaurantAddressController.text');
    // print(restaurantAddressController.text);
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

    final currentImagePath = restaurantsUserIdData.restaurantImage;
    return CustomerButton(
        text: 'Cập Nhật',
        press: () async {
          await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(' Cập Nhật ?'),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          String image = '';
                          if (restaurantImageLink.value != null) {
                            // var imageFoldeStore = await ref
                            //     .read(API.restaurant)
                            //     .createFolderRestaurantImage(
                            //         category: restaurantCategory,
                            //         restaurantName:
                            //             restaurantNameController.text);
                            image = await ref.read(API.restaurant).uploadImage(
                                imageLink: restaurantImageLink,
                                category: checkInvalidStringToString(
                                    localData: categoryIndex.value,
                                    serverData: restaurantsUserIdData
                                        .restaurantCategory!)!,
                                restaurantName: checkInvalidStringToString(
                                    localData: restaurantNameController.text,
                                    serverData:
                                        restaurantsUserIdData.restaurantName!)!,
                                imageFoldeStore: '/' +
                                    restaurantsUserIdData
                                        .restaurantImageStoreFolder!);
                            // print('image');
                            // print(image);
                            Navigator.pop(context);
                            await ref
                                .read(AppStateProvider
                                    .restaurantEditNotifier.notifier)
                                .deleteRestaurantImage(
                                    restaurantImage: currentImagePath!,
                                    newRestaurantImage: image,
                                    restaurantId:
                                        restaurantsUserIdData.restaurantId!);
                          } else {
                            // print('elseelseelseelse');
                            await ref
                                .read(AppStateProvider
                                    .restaurantEditNotifier.notifier)
                                .getoneandupdate(
                                  booking: checkInvalidBool(
                                      localData: isBooking.value,
                                      serverData:
                                          restaurantsUserIdData.booking!),
                                  restaurantAdrress: checkInvalidStringToString(
                                      localData:
                                          restaurantAddressController.text,
                                      serverData: restaurantsUserIdData
                                          .restaurantAdrress!),
                                  restaurantCategory:
                                      checkInvalidStringToString(
                                          localData: restaurantCategory,
                                          serverData: restaurantsUserIdData
                                              .restaurantCategory!),
                                  restaurantComment: checkInvalidStringToDouble(
                                      localData: '',
                                      serverData: restaurantsUserIdData
                                          .restaurantComment!),
                                  restaurantEndingTime:
                                      checkInvalidStringToDouble(
                                          localData:
                                              restaurantServiceTimeEndController
                                                  .text,
                                          serverData: restaurantsUserIdData
                                              .restaurantEndingTime!),
                                  restaurantId:
                                      restaurantsUserIdData.restaurantId,
                                  restaurantImage: checkInvalidStringToString(
                                      localData: image,
                                      serverData: restaurantsUserIdData
                                          .restaurantImage!),
                                  restaurantMealPreparation:
                                      checkInvalidStringToDouble(
                                          localData:
                                              restaurantTimeMealPreparationController
                                                  .text,
                                          serverData: restaurantsUserIdData
                                              .restaurantMealPreparation!),
                                  restaurantName: checkInvalidStringToString(
                                    localData: restaurantNameController.text,
                                    serverData:
                                        restaurantsUserIdData.restaurantName!,
                                  ),
                                  restaurantRating:
                                      restaurantsUserIdData.restaurantRating,
                                  restaurantStartTime: checkInvalidStringToDouble(
                                      localData:
                                          restaurantServiceTimeStartController
                                              .text,
                                      serverData: restaurantsUserIdData
                                          .restaurantStartTime!),
                                  ship: checkInvalidBool(
                                      localData: isShip.value,
                                      serverData: restaurantsUserIdData.ship!),
                                  userId: restaurantsUserIdData.userId,
                                  restaurantImageStoreFolder:
                                      restaurantsUserIdData
                                          .restaurantImageStoreFolder,
                                  listProductId:
                                      restaurantsUserIdData.listProductId,
                                  productId: restaurantsUserIdData.productId,
                                  productName:
                                      restaurantsUserIdData.productName,
                                );
                            Navigator.pop(context);
                          }
                        },
                        child: Text('OK')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Không'))
                  ],
                );
              });

          // String image = '';
          // var imageFoldeStore = await ref
          //     .read(API.restaurant)
          //     .createFolderRestaurantImage(
          //         category: restaurantCategory,
          //         restaurantName: restaurantNameController.text);

          // if (restaurantImageLink.value != null) {
          //   image = await ref.read(API.restaurant).uploadImage(
          //       imageLink: restaurantImageLink,
          //       category: checkInvalidStringToString(
          //           appData: categoryIndex.value,
          //           serverData: restaurantsUserIdData?.restaurantCategory)!,
          //       restaurantName: checkInvalidStringToString(
          //           appData: restaurantNameController.text,
          //           serverData: restaurantsUserIdData?.restaurantName)!,
          //       imageFoldeStore: imageFoldeStore);
          // }

          // await ref.read(API.restaurant).createRestaurant(
          //       restaurantCategory: checkInvalidStringToString(
          //           appData: categoryIndex.value,
          //           serverData: restaurantsUserIdData?.restaurantCategory)!,
          //       restaurantName: checkInvalidStringToString(
          //           appData: restaurantNameController.text,
          //           serverData: restaurantsUserIdData?.restaurantName)!,
          //       restaurantImage: checkInvalidStringToString(
          //           appData: image,
          //           serverData: restaurantsUserIdData?.restaurantImage!),
          // restaurantId: checkInvalidStringToString(
          //         appData: restaurantNameController.text,
          //         serverData: restaurantsUserIdData?.restaurantName)! +
          //     '__' +
          //     checkInvalidStringToString(
          //         appData: restaurantAddressController.text,
          //         serverData: restaurantsUserIdData?.restaurantAdrress)!,
          // restaurantAdrress: checkInvalidStringToString(
          //     appData: restaurantAddressController.text,
          //     serverData: restaurantsUserIdData?.restaurantAdrress)!,
          // restaurantStartTime: checkInvalidStringToDouble(
          //     appData: restaurantServiceTimeStartController.text,
          //     serverData: restaurantsUserIdData?.restaurantStartTime!),
          // restaurantEndingTime: checkInvalidStringToDouble(
          //     appData: restaurantServiceTimeEndController.text,
          //     serverData: restaurantsUserIdData?.restaurantEndingTime!),
          // restaurantMealPreparation: checkInvalidStringToDouble(
          //     appData: restaurantTimeMealPreparationController.text,
          //     serverData:
          //         restaurantsUserIdData?.restaurantMealPreparation!),
          // restaurantComment: 0,
          // restaurantRating: 0,
          // ship: isShip.value,
          // booking: isBooking.value,
          // userId: user!.userId,
          // );
        },
        buttonHeight: getProportionateScreenHeight(38),
        buttonWidth: getProportionateScreenHeight(120),
        BorderRadiuscircular: 10,
        backgoundColor: null);
  }
}
