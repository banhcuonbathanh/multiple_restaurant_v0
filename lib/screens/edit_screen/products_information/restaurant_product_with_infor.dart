import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/model/product_model.dart';

import 'package:untitled1/size_config.dart';

import '../../../constants.dart';

import '../picture_frame.dart';

import '../product_detail_modal_sheet.dart/product_detail_edit_list/product_detail_list_edit.dart';

import 'cap_nhat_san_pham_button.dart';
import 'row_gia_san_pham_with_infor.dart';
import 'row_product_name_with_infor.dart';
import 'xoa_san_pham_button.dart';

class RestaurantProductsWithInfor extends HookConsumerWidget {
  // final String? serverProductId;
  final int index;
  final String? serverRestaurantId;
  final ProductModel productModel;
  const RestaurantProductsWithInfor({
    required this.productModel,
    required this.index,
    // required this.serverProductId,

    required this.serverRestaurantId,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantProductImageLink = useState<File?>(null);
    final tenSanPhamController = useTextEditingController();
    final giaThapNhatController = useTextEditingController();
    final giaCaoNhatController = useTextEditingController();

    final currentUser = ref.watch(AppStateProvider.userNotifier);
    final restaurantData = ref.watch(AppStateProvider.restaurantEditNotifier);

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Stack(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    PictureFrame(
                      borderCircular: 20,
                      frameHeight: getProportionateScreenHeight(80),
                      frameWith: getProportionateScreenWidth(75),
                      imageFile: restaurantProductImageLink,
                      imageServer: productModel.productImage,
                      onPress: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        if (image != null) {
                          restaurantProductImageLink.value = File(image.path);
                        }
                      },
                      textContent: 'Chọn Ảnh',
                      restaurantId: currentUser!.restaurantId!,
                    ),
                    SizedBox(width: getProportionateScreenWidth(10)),

                    // ten san pham -------------------------------------------------
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ten san pham
                        RowProductName(
                          ref: ref,
                          serverProductName: productModel.productName,
                          tenSanPhamController: tenSanPhamController,
                        ),

                        // gia san pham     -------------------------------------------------

                        GiaSanPham(
                          ref: ref,
                          giaCaoNhatController: giaCaoNhatController,
                          giaThapNhatController: giaThapNhatController,
                          giaCaoNhatServer: productModel.productPriceCaoNhat,
                          giaThapNhatServer: productModel.productPriceThapNhat,
                        ),
                        //
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        // rating -------------------------------------------------
                        RatingBar.builder(
                            minRating: 1,
                            itemSize: 17,
                            updateOnDrag: true,
                            itemBuilder: (context, index) {
                              return const Icon(
                                Icons.star,
                                color: Colors.yellowAccent,
                              );
                            },
                            onRatingUpdate: (rating) {}),
                      ],
                    ),
                    const Spacer(),
                    //  nut cong
                    CustomerButton(
                      backgoundColor: kPrimaryColor,
                      BorderRadiuscircular: 10,
                      buttonHeight: getProportionateScreenHeight(35),
                      buttonWidth: getProportionateScreenWidth(60),
                      press: () async {
                        // print(serverProductId);

                        await ref
                            .read(AppStateProvider
                                .productDetailEditState.notifier)
                            .getProductDetailproductId(
                                searchingKey: productModel.productId!);
                        if (productModel.toppingList != null) {
                          await ref
                              .read(AppStateProvider
                                  .toppingEditMapNotifier.notifier)
                              .searchingToppingWithProductId(
                                  productId: productModel.productId!);
                        }

                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return ProductDetailList_Edit1(
                                serverProductId: productModel.productId!,
                                isAccessFromMainScreen: false,
                                serverRestaurantId: serverRestaurantId!,
                                index: index,
                              );
                            });
                      },
                      text: "+",
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    XoaThongTinSanPham(
                      serverProductId: productModel.productId!,
                      serverRestaurantId: serverRestaurantId!,
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(10),
                    ),
                    CapNhatThongTinSanPham(
                      productModel: productModel,
                      productRating: '4',
                      productImage: restaurantProductImageLink,
                      productNameController: tenSanPhamController,
                      productPriceCaoNhatController: giaCaoNhatController,
                      productPriceThapNhatController: giaThapNhatController,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // modalbottom sheet -------------------------------------------------
      ],
    );
  }

  Widget buildTextFormFieldTenSanPham({
    required TextEditingController tenSanPhamController,
    required WidgetRef ref,
    required Function kiemtraFunction,
  }) {
    return TextFormField(
      style: TextStyle(fontSize: getProportionateScreenHeight(12)),
      controller: tenSanPhamController,
      keyboardType: TextInputType.name,
      onChanged: (value) {},
      onSaved: (value) {
        tenSanPhamController.text = value!;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
            vertical: getProportionateScreenHeight(10)),
        hintText: ' ten san pham',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập ten san pham';
        }

        return null;
      },
    );
  }

  Widget buildTextFormFieldGiaThapNhat({
    required TextEditingController giaThapNhat,
    required WidgetRef ref,
    required Function kiemtraFunction,
  }) {
    return TextFormField(
      style: TextStyle(fontSize: getProportionateScreenHeight(12)),
      controller: giaThapNhat,
      keyboardType: TextInputType.number,
      onChanged: (value) {},
      onSaved: (value) {
        giaThapNhat.text = value!;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
            vertical: getProportionateScreenHeight(10)),
        hintText: 'thap nhat',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập gia thap nhat';
        }

        return null;
      },
    );
  }

  Widget buildTextFormFieldGiaCaoNhat({
    required TextEditingController giaCaoNhat,
    required WidgetRef ref,
    required Function kiemtraFunction,
  }) {
    return TextFormField(
      style: TextStyle(fontSize: getProportionateScreenHeight(12)),
      controller: giaCaoNhat,
      keyboardType: TextInputType.name,
      onChanged: (value) {},
      onSaved: (value) {
        giaCaoNhat.text = value!;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
            vertical: getProportionateScreenHeight(10)),
        hintText: 'Cao Nhat',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập Cao Nhat';
        }

        return null;
      },
    );
  }
}

// restaurantProductImageLink.value != null
//     ?
//     // product image -------------------------------------------------
//     Column(
//         children: [
//           // ClipRRect(
//           //   borderRadius: BorderRadius.circular(20),
//           //   child: SizedBox(
//           //     height: getProportionateScreenHeight(80),
//           //     width: getProportionateScreenWidth(75),
//           //     child: Image.file(
//           //       restaurantProductImageLink.value!,
//           //       fit: BoxFit.fill,
//           //     ),
//           //   ),
//           // ),
//           // if (isShowTextFormFielCapNhat.value)
//             // TextButton(
//             //     onPressed: () async {
//             //       final image = await ImagePicker()
//             //           .pickImage(
//             //               source: ImageSource.gallery);

//             //       if (image != null) {
//             //         restaurantProductImageLink.value =
//             //             File(image.path);
//             //       }
//             //     },
//             //     child: Text(
//             //       'Chon Anh',
//             //       style: TextStyle(
//             //           fontSize:
//             //               getProportionateScreenWidth(11)),
//             //     ))
//         ],
//       )
//     : GestureDetector(
//         // onTap: () async {
//         //   final image = await ImagePicker()
//         //       .pickImage(source: ImageSource.gallery);

//         //   if (image != null) {
//         //     restaurantProductImageLink.value =
//         //         File(image.path);
//         //   }
//         // },
//         child: Column(
//           children: [
//             // Container(
//             //   height: getProportionateScreenHeight(70),
//             //   width: getProportionateScreenWidth(70),
//             //   decoration: BoxDecoration(
//             //       border: Border.all(),
//             //       borderRadius: BorderRadius.circular(10)),
//             //   child: ClipRRect(
//             //     borderRadius: BorderRadius.circular(20),
//             //     child: Center(
//             //       child: Text(' Chọn Ảnh mon an'),
//             //     ),
//             //   ),
//             // ),
//             // if (isShowTextFormFielCapNhat.value)
//               // TextButton(
//               //     onPressed: () async {
//               //       final image = await ImagePicker()
//               //           .pickImage(
//               //               source: ImageSource.gallery);

//               //       if (image != null) {
//               //         restaurantProductImageLink.value =
//               //             File(image.path);
//               //       }
//               //     },
//               //     child: Text(
//               //       'Chon Anh',
//               //       style: TextStyle(
//               //           fontSize:
//               //               getProportionateScreenWidth(
//               //                   11)),
//               //     ))
//           ],
//         ),
//       ),

// Container(
//   height: getProportionateScreenHeight(35),
//   width: getProportionateScreenWidth(270),
//   child: Row(
//     children: [
//       isShowTextFormFielTenSanPham.value
//           ? Expanded(
//               child: SizedBox(
//                 width: getProportionateScreenWidth(80),
//                 child: buildTextFormFieldTenSanPham(
//                   ref: ref,
//                   kiemtraFunction: () {
//                     isShowTextFormFielTenSanPham.value =
//                         !isShowTextFormFielTenSanPham
//                             .value;
//                   },
//                   tenSanPhamController:
//                       tenSanPhamController,
//                 ),
//               ),
//             )
//           : Expanded(
//               child: Text(tenSanPhamController.text),
//             ),
//       if (isShowTextFormFielCapNhat.value)
//         TextButton(
//             onPressed: () {
//               isShowTextFormFielTenSanPham.value =
//                   !isShowTextFormFielTenSanPham.value;
//             },
//             child: isShowTextFormFielTenSanPham.value
//                 ? Text(" kiem tra")
//                 : Text(" nhap lai"))
//     ],
//   ),
// ),

// Container(
//   height: getProportionateScreenHeight(35),
//   width: getProportionateScreenWidth(270),
//   child: Row(
//     children: [
//       isShowGiaSanPham.value
//           ? Expanded(
//               child: Row(
//                 children: [
//                   Expanded(
//                     child:
//                         buildTextFormFieldGiaThapNhat(
//                       ref: ref,
//                       kiemtraFunction: () {
//                         isShowGiaSanPham.value =
//                             !isShowGiaSanPham.value;
//                       },
//                       giaThapNhat:
//                           giaThapNhatController,
//                     ),
//                   ),
//                   Expanded(
//                     child: buildTextFormFieldGiaCaoNhat(
//                       ref: ref,
//                       kiemtraFunction: () {
//                         isShowGiaSanPham.value =
//                             !isShowGiaSanPham.value;
//                       },
//                       giaCaoNhat: giaCaoNhatController,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : Expanded(
//               child: Row(
//                 children: [
//                   Text(giaThapNhatController.text),
//                   SizedBox(
//                     width:
//                         getProportionateScreenWidth(10),
//                   ),
//                   Text('-'),
//                   SizedBox(
//                     width:
//                         getProportionateScreenWidth(10),
//                   ),
//                   Text(giaCaoNhatController.text),
//                 ],
//               ),
//             ),
//       if (isShowTextFormFielCapNhat.value)
//         TextButton(
//             onPressed: () {
//               isShowGiaSanPham.value =
//                   !isShowGiaSanPham.value;
//             },
//             child: isShowGiaSanPham.value
//                 ? Text(" kiem tra")
//                 : Text(" nhap lai"))
//     ],
//   ),
// ),
