import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/api_provider.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/components/snackbarcontent.dart';
import 'package:untitled1/model/restaurant_model.dart';
import 'package:untitled1/model/user_model.dart';
import 'package:untitled1/size_config.dart';

class TaoNhaHangButtonNoInfor extends HookConsumerWidget {
  const TaoNhaHangButtonNoInfor({
    required this.formKey,
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
  final RestaurantModel? restaurantsUserIdData;
  final TextEditingController restaurantAddressController;
  final TextEditingController restaurantServiceTimeStartController;
  final TextEditingController restaurantServiceTimeEndController;
  final TextEditingController restaurantTimeMealPreparationController;
  final ValueNotifier<bool> isShip;
  final ValueNotifier<bool> isBooking;
  final UserModel? user;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build TaoNhaHangButtonNoInfor');
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

    final currentUser = ref.watch(AppStateProvider.userNotifier);

    // Restaurant? currentUserRestaurantData;
    // if (currentUser!.restaurantId! != '') {
    //   currentUserRestaurantData = ref.watch(restaurantUserIdDataProvider);
    // }
    return CustomerButton(
        text: "Tao NHa Hang",
        press: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            String image = '';
            var imageFoldeStore = await ref
                .read(API.restaurant)
                .createFolderRestaurantImage(
                    category: restaurantCategory,
                    restaurantName: restaurantNameController.text);
            if (restaurantImageLink.value == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: SnackbarContend(
                  contend: 'CHưa Chọn Ảnh Nhà Hàng',
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
              image = await ref.read(API.restaurant).uploadImage(
                  imageLink: restaurantImageLink,
                  category: checkInvalidStringToString(
                      appData: categoryIndex.value,
                      serverData: restaurantsUserIdData?.restaurantCategory)!,
                  restaurantName: checkInvalidStringToString(
                      appData: restaurantNameController.text,
                      serverData: restaurantsUserIdData?.restaurantName)!,
                  imageFoldeStore: imageFoldeStore);
            }
            await ref
                .read(AppStateProvider.restaurantEditNotifier.notifier)
                .createRestaurant(
                  restaurantCategory: checkInvalidStringToString(
                      appData: categoryIndex.value,
                      serverData: restaurantsUserIdData?.restaurantCategory)!,
                  restaurantName: checkInvalidStringToString(
                      appData: restaurantNameController.text,
                      serverData: restaurantsUserIdData?.restaurantName)!,
                  restaurantImage: checkInvalidStringToString(
                      appData: image,
                      serverData: restaurantsUserIdData?.restaurantImage!),
                  restaurantId: null,
                  restaurantAdrress: checkInvalidStringToString(
                      appData: restaurantAddressController.text,
                      serverData: restaurantsUserIdData?.restaurantAdrress)!,
                  restaurantStartTime: checkInvalidStringToDouble(
                      appData: restaurantServiceTimeStartController.text,
                      serverData: restaurantsUserIdData?.restaurantStartTime!),
                  restaurantEndingTime: checkInvalidStringToDouble(
                      appData: restaurantServiceTimeEndController.text,
                      serverData: restaurantsUserIdData?.restaurantEndingTime!),
                  restaurantMealPreparation: checkInvalidStringToDouble(
                      appData: restaurantTimeMealPreparationController.text,
                      serverData:
                          restaurantsUserIdData?.restaurantMealPreparation!),
                  restaurantComment: 0,
                  restaurantRating: 0,
                  ship: isShip.value,
                  booking: isBooking.value,
                  userId: user!.userId,
                  restaurantImageStoreFolder: imageFoldeStore,
                );
            ref
                .read(AppStateProvider.userNotifier.notifier)
                .searchUserSId(userId: currentUser!.userId!);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cập Nhật Thành Công')));
// check and warning not selected image restaurant
          }
        },
        buttonHeight: getProportionateScreenHeight(40),
        buttonWidth: getProportionateScreenWidth(130),
        BorderRadiuscircular: 10,
        backgoundColor: null);
  }
}
