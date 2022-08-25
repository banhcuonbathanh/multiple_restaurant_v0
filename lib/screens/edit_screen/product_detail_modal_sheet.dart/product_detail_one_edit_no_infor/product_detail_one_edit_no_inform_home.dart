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
import 'package:untitled1/size_config.dart';

import 'cap_nhat_button_modal_sheet_no_inform.dart';
import '../picture_frame/picture_frame_no_information.dart';

import 'row_product_detail_name_with_no_infor.dart';
import 'row_product_detail_price_with_no_infor.dart';
import 'row_product_detail_promotion_with_no_infor.dart';
import 'row_product_detail_thanh_phan_with_no_infor.dart';

class ProductDetailOne_EditNoInform_Home extends HookConsumerWidget {
  ProductDetailOne_EditNoInform_Home({
    required this.serverProductId,
    Key? key,
  }) : super(key: key);

  final String serverProductId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var productDetailImageLink = useState<File?>(null);
    final giaSanPhamController = useTextEditingController();
    final tenSanPhamController = useTextEditingController();
    final promotionController = useTextEditingController();
    final productDetailDescription = useTextEditingController();

    // final currentProductRestaurantwithUserId = ref.watch();
    final restaurantData = ref.watch(AppStateProvider.restaurantEditNotifier);
    final productData = ref
        .watch(AppStateProvider.productEditNotifier)
        .firstWhere((element) => element.productId == serverProductId);

    final productDetailData =
        ref.watch(AppStateProvider.productDetailEditState);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    // print('ProductDetailData');
    // print(ProductDetailData);
    return Padding(
      padding: EdgeInsets.only(bottom: getProportionateScreenHeight(20)),
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PictureFrameProductDetailWithNoInfomation(
              onPressImageFile: () async {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);

                if (image != null) {
                  productDetailImageLink.value = File(image.path);
                }
              },
              imageFileRestaurant: productDetailImageLink,
            ),
            SizedBox(
              width: getProportionateScreenWidth(5),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowProductDetailNameNoInform(
                      ref: ref,
                      serverProductName: null,
                      tenSanPhamController: tenSanPhamController,
                    ),
                    RowProductDetailThanhPhanNoInform(
                      ref: ref,
                      serverThanhPhan: null,
                      thanhPhanController: productDetailDescription,
                    ),
                    ProductDetailPromotionNoInform(
                      promotionController: promotionController,
                      giaThapNhatServer: null,
                      ref: ref,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),
                    FavoriteButton(
                      iconColor: Colors.blue,

                      iconSize: 13,
                      // iconDisabledColor: Colors.white,
                      valueChanged: (_isFavorite) {},
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: getProportionateScreenWidth(100),
              child: Column(
                children: [
                  ProductDetailPriceNoInform(
                    giaThapNhatController: giaSanPhamController,
                    giaThapNhatServer: null,
                    ref: ref,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: getProportionateScreenWidth(42),
                      ),
                      Text('0'),
                      SizedBox(
                        width: getProportionateScreenWidth(10),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Row(
                    children: [
                      AddButton(),
                      SizedBox(
                        width: getProportionateScreenWidth(10),
                      ),
                      Text('0'),
                      SizedBox(
                        width: getProportionateScreenWidth(10),
                      ),
                      RemoveButton(),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CapNhatButtonModalSheetNoInfor(
                    productDetailName: tenSanPhamController,
                    productdetaiPrice: giaSanPhamController,
                    productRestaurantImageLink: productDetailImageLink,
                    productData: productData,
                    restaurantsUserIdData: restaurantData,
                    productDetailDescription: productDetailDescription,
                    formKey: _formKey,
                    promotion: promotionController,
                  ),
                ],
              ),
            ),
          ],
        ),
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
      width: getProportionateScreenWidth(110),
      height: getProportionateScreenHeight(110),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomerButton(
      backgoundColor: kPrimaryColor,
      BorderRadiuscircular: 8,
      buttonHeight: getProportionateScreenHeight(20),
      buttonWidth: getProportionateScreenWidth(30),
      press: () async {},
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomerButton(
      backgoundColor: kPrimaryColor,
      BorderRadiuscircular: 8,
      buttonHeight: getProportionateScreenHeight(20),
      buttonWidth: getProportionateScreenWidth(30),
      press: () {},
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
