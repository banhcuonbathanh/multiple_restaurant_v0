import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/size_config.dart';
import 'picture_frame_no_information.dart';
import 'row_category_no_information.dart';
import 'row_cua_hang_no_information.dart';
import 'row_dia_chi_cua_hang_no_infor.dart';
import 'row_ship_booking_no_infor.dart';
import 'row_thoi_gian_chuan_bi_mon_No_infor.dart';
import 'tao_nha_hang_button_no_inform.dart';
import 'thoi_gian_phuc_vu_no_infor.dart';

class RestaurantNoInformation extends HookConsumerWidget {
  const RestaurantNoInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final restaurantNameController = useTextEditingController();
    final restaurantAddressController = useTextEditingController();
    final restaurantServiceTimeStartController = useTextEditingController();
    final restaurantServiceTimeEndController = useTextEditingController();
    final restaurantTimeMealPreparationController = useTextEditingController();
    var restaurantImageLink = useState<File?>(null);
    final isShip = useState<bool>(false);
    final isBooking = useState<bool>(false);
    var categoryIndex = useState<String>('Đồ Ăn');
    final currentUser = ref.watch(AppStateProvider.userNotifier);
// ---------------------------------

// ------------------------
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            PictureFrameWithNoInfomation(
              onPressImageFile: () async {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);

                if (image != null) {
                  restaurantImageLink.value = File(image.path);
                }
              },
              imageFileRestaurant: restaurantImageLink,
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            RowCategoryNoInformation(
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
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            RowShipBookingNoInfor(
              isBooking: isBooking.value,
              isBookingFun: () {
                isBooking.value = !isBooking.value;
              },
              isShip: isShip.value,
              isShipFun: () {
                isShip.value = !isShip.value;
              },
            ),
            RowCuaHangNoInformation(
              restaurantController: restaurantNameController,
              restaurantName: null,
            ),
            RowDiaChiQuanNoInfor(
              restaurantAddressController: restaurantAddressController,
              restaurantAdrress: null,
            ),
            RowThoiGianPhucVuNoInfor(
              thoiGianBatDau: null,
              thoiGianKetThuc: null,
              ThoiGianPhucVuBatDauController:
                  restaurantServiceTimeStartController,
              ThoiGianPhucVuKetThucController:
                  restaurantServiceTimeEndController,
            ),
            RowThoiGianChuanBiMonAwnNoInfor(
              restaurantMealPreparation: null,
              restaurantTimeMealPreparationController:
                  restaurantTimeMealPreparationController,
            ),
            TaoNhaHangButtonNoInfor(
              categoryIndex: categoryIndex,
              isBooking: isBooking,
              isShip: isShip,
              restaurantAddressController: restaurantAddressController,
              restaurantCategory: categoryIndex.value,
              restaurantImageLink: restaurantImageLink,
              restaurantNameController: restaurantNameController,
              restaurantServiceTimeEndController:
                  restaurantServiceTimeEndController,
              restaurantServiceTimeStartController:
                  restaurantServiceTimeStartController,
              restaurantsUserIdData: null,
              restaurantTimeMealPreparationController:
                  restaurantTimeMealPreparationController,
              user: currentUser,
              formKey: _formKey,
            ),
            // CapNhatButtonNoInfor1(
            //   categoryIndex: categoryIndex,
            //   isBooking: isBooking,
            //   isShip: isShip,
            //   restaurantAddressController: restaurantAddressController,
            //   restaurantCategory: categoryIndex.value,
            //   restaurantImageLink: restaurantImageLink,
            //   restaurantNameController: restaurantNameController,
            //   restaurantServiceTimeEndController:
            //       restaurantServiceTimeEndController,
            //   restaurantServiceTimeStartController:
            //       restaurantServiceTimeStartController,
            //   restaurantsUserIdData: null,
            //   restaurantTimeMealPreparationController:
            //       restaurantTimeMealPreparationController,
            //   user: currentUser,
            // ),
            // TaoNhaHangButton(
            //   categoryIndex: categoryIndex,
            //   isBooking: isBooking,
            //   isShip: isShip,
            //   restaurantAddressController: restaurantAddressController,
            //   restaurantCategory: categoryIndex.value,
            //   restaurantImageLink: restaurantImageLink,
            //   restaurantNameController: restaurantNameController,
            //   restaurantServiceTimeEndController:
            //       restaurantServiceTimeEndController,
            //   restaurantServiceTimeStartController:
            //       restaurantServiceTimeStartController,
            //   restaurantsUserIdData: null,
            //   restaurantTimeMealPreparationController:
            //       restaurantTimeMealPreparationController,
            //   user: currentUser,
            // ),
          ],
        ),
      ),
    );
  }
}
