import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/screens/edit_screen/restaurant_with_infomration/button_restuarant_with_infor/upate_button.dart';
import 'package:untitled1/size_config.dart';

import 'picture_frame_with_information.dart';
import 'row_restaurant/row_category_with_information.dart';
import 'row_restaurant/row_cua_hang_with_information.dart';
import 'row_restaurant/row_dia_chi_cua_hang_with_infor.dart';
import 'row_restaurant/row_ship_booking_with_infor.dart';
import 'row_restaurant/row_thoi_gian_chuan_bi_mon_No_infor.dart';
import 'row_restaurant/row_thoi_gian_phuc_vu_with_infor.dart';
import 'button_restuarant_with_infor/xoa_button.dart';
import 'row_restaurant/row_thoi_gian_phuc_vu_with_infor.dart';

class RestaurantWithInformation extends HookConsumerWidget {
  static String routeName = "/RestaurantWithInformation";
  const RestaurantWithInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      print(' build RestaurantWithInformation');
      return () {
        print(' dispose RestaurantWithInformation');
      };
    });
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final restaurantNameController = useTextEditingController();
    final restaurantAddressController = useTextEditingController();
    final restaurantServiceTimeStartController = useTextEditingController();
    final restaurantServiceTimeEndController = useTextEditingController();
    final restaurantTimeMealPreparationController = useTextEditingController();
    var restaurantImageLink = useState<File?>(null);
    final isShip = useState<bool>(false);
    final isBooking = useState<bool>(false);
    var categoryIndex = useState<String>('');
    final currentUser = ref.watch(AppStateProvider.userNotifier);

    // print('restaurantAddressController.text trong RestaurantWithInformation');
    // print(restaurantAddressController.text);
    // Restaurant? restaurantData;
    // if (currentUser!.restaurantId != '') {
    //   restaurantData = ref.watch(restaurantUserIdDataProvider);
    // }

    // final restaurantData = ref.watch(restaurantUserIdDataProvider);

    final restaurantData = ref.watch(AppStateProvider.restaurantEditNotifier);
    if (restaurantData?.restaurantCategory != null &&
        categoryIndex.value == '') {
      categoryIndex.value = restaurantData!.restaurantCategory!;
    }

// ---------------------------------

// ------------------------
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PictureFrameWithInfomation(
              onPressImageFile: () async {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);

                if (image != null) {
                  restaurantImageLink.value = File(image.path);
                }
              },
              imageFileRestaurant: restaurantImageLink,
              imageServer: restaurantData!.restaurantImage!,
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            RowCategoryWithInformation(
              doAnFunc: () {
                categoryIndex.value = 'Đồ Ăn';
              },
              doUongFunc: () {
                categoryIndex.value = 'Đồ Uống';
              },
              thucPhamFunc: () {
                categoryIndex.value = 'Thực Phẩm';
              },
              categoryIndex: categoryIndex,
              restaurantCategoryServer: restaurantData.restaurantCategory!,
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            RowShipBookingWithInfor(
              isBookingFun: () {
                isBooking.value = !isBooking.value;
              },
              isBooking: isBooking.value,
              isShipFun: () {
                isShip.value = !isShip.value;
              },
              isShip: isShip.value,
              isBookingServer: restaurantData.booking!,
              isShipServer: restaurantData.ship!,
            ),
            RowCuaHangWithInformation(
              ref: ref,
              restaurantController: restaurantNameController,
              restaurantName: restaurantData.restaurantName,
            ),
            RowDiaChiQuanWithInfor(
              ref: ref,
              restaurantAddressController: restaurantAddressController,
              restaurantAdrress: restaurantData.restaurantAdrress,
            ),
            RowThoiGianPhucVuwithInfor(
              ref: ref,
              restaurantStartTime: restaurantData.restaurantStartTime!,
              restaurantEndingTime: restaurantData.restaurantEndingTime!,
              ThoiGianPhucVuBatDauController:
                  restaurantServiceTimeStartController,
              ThoiGianPhucVuKetThucController:
                  restaurantServiceTimeEndController,
            ),
            RowThoiGianChuanBiMonAwnNoInfor(
              ref: ref,
              restaurantMealPreparation:
                  restaurantData.restaurantMealPreparation!,
              restaurantTimeMealPreparationController:
                  restaurantTimeMealPreparationController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (currentUser!.restaurantId != '')
                  XoaButton(
                    restaurantData: restaurantData,
                  ),
                SizedBox(
                  width: getProportionateScreenWidth(20),
                ),
                UpdateRestaurantInform(
                  restaurantTimeMealPreparationController:
                      restaurantTimeMealPreparationController,
                  restaurantServiceTimeStartController:
                      restaurantServiceTimeStartController,
                  categoryIndex: categoryIndex,
                  isBooking: isBooking,
                  isShip: isShip,
                  restaurantAddressController: restaurantAddressController,
                  restaurantCategory: categoryIndex.value,
                  restaurantImageLink: restaurantImageLink,
                  restaurantNameController: restaurantNameController,
                  restaurantServiceTimeEndController:
                      restaurantServiceTimeEndController,
                  restaurantsUserIdData: restaurantData,
                  user: currentUser,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
