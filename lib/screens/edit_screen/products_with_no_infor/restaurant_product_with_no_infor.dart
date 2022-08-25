import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled1/app_provider/api_provider.dart';
import 'package:untitled1/app_provider/state_provider.dart';

import 'package:untitled1/components/snackbarcontent.dart';
import 'package:untitled1/model/restaurant_model.dart';
import 'package:untitled1/size_config.dart';

import '../picture_frame.dart';

import '../products_information/row_product_name_with_infor.dart';
import 'row_gia_san_pham_with_no_infor.dart';
import 'row_product_name_with_no_infor.dart';

class ProductsWithNoInfor extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantProductImageLink = useState<File?>(null);
    final tenSanPhamController = useTextEditingController();
    final giaThapNhatController = useTextEditingController();
    final giaCaoNhatController = useTextEditingController();
    final isShowTextFormFielTenSanPham = useState<bool>(true);
    final isShowGiaSanPham = useState<bool>(true);
    final isShowTextFormFielCapNhat = useState<bool>(true);
    final rating = useState(0);

    final currentUser = ref.watch(AppStateProvider.userNotifier);
    String? checkNullStringToString({required String? serverData}) {
      String? response = '';
      if (serverData == null) {
        response = '';
      } else {
        response = serverData;
      }
      return response;
    }

    RestaurantModel? restaurantData;
    if (currentUser!.restaurantId != '') {
      restaurantData = ref.watch(AppStateProvider.restaurantEditNotifier);
    }

    // final searchingProductsOfRestaurantUserId =
    //     ref.watch(searchingProductsOfRestaurantUserIdDataProvider);

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                PictureFrame(
                  borderCircular: 20,
                  frameHeight: getProportionateScreenHeight(80),
                  frameWith: getProportionateScreenWidth(75),
                  imageFile: restaurantProductImageLink,
                  imageServer: null,
                  onPress: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      restaurantProductImageLink.value = File(image.path);
                    }
                  },
                  textContent: 'Chọn Ảnh',
                  restaurantId: currentUser.restaurantId!,
                ),
                SizedBox(width: getProportionateScreenWidth(10)),

                // ten san pham -------------------------------------------------
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ten san pham
                    RowProductNameNoInform(
                      ref: ref,
                      serverProductName: null,
                      tenSanPhamController: tenSanPhamController,
                    ),

                    // gia san pham     -------------------------------------------------

                    GiaSanPham(
                      giaCaoNhatController: giaCaoNhatController,
                      giaThapNhatController: giaThapNhatController,
                      giaCaoNhatServer: null,
                      giaThapNhatServer: null,
                      ref: ref,
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
                          return Icon(
                            Icons.star,
                            color: Colors.yellowAccent,
                          );
                        },
                        onRatingUpdate: (rating) {}),
                  ],
                ),
                Spacer(),

                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await ref
                            .read(API.restaurant)
                            .searchingRestaurantUserId(
                                restaurantId: currentUser.restaurantId);
                        var imageFoldeStore = await ref
                            .read(API.product)
                            .createFolderProductImage(
                                // category: restaurantData!.restaurantCategory!,
                                restaurantName: checkNullStringToString(
                                    serverData:
                                        restaurantData?.restaurantName)!,
                                productName: tenSanPhamController.text);

                        String image = '';
                        if (restaurantProductImageLink.value == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: SnackbarContend(
                              contend: 'Chưa Chọn Ảnh Sản Phẩm',
                            ),
                            action: SnackBarAction(
                              label: 'close',
                              textColor: Colors.red,
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ));
                          return;
                        } else {
                          image = await ref
                              .read(API.product)
                              .uploadProductImage(
                                  imageLink: restaurantProductImageLink,
                                  // category: 'doan',
                                  restaurantName: checkNullStringToString(
                                      serverData:
                                          restaurantData?.restaurantName)!,
                                  productName: tenSanPhamController.text,
                                  imageFoldeStore: imageFoldeStore);
                        }

                        await ref
                            .read(AppStateProvider.productEditNotifier.notifier)
                            .createProduct(
                                productName: tenSanPhamController.text,
                                productImage: image,
                                productId: '',
                                productPriceThapNhat:
                                    double.parse(giaThapNhatController.text),
                                productPriceCaoNhat:
                                    double.parse(giaCaoNhatController.text),
                                productRating: 0,
                                isFavourite: false,
                                isPopular: false,
                                ship: false,
                                booking: false,
                                restaurantName: checkNullStringToString(
                                    serverData:
                                        restaurantData?.restaurantName)!,
                                restaurantId: checkNullStringToString(
                                    serverData: restaurantData?.restaurantId)!,
                                productdetailIdList: [],
                                folderProductImage: imageFoldeStore);
                        if (restaurantData != null) {
                          await ref
                              .read(
                                  AppStateProvider.productEditNotifier.notifier)
                              .searchingProductsOfRestaurantUserId(
                                  searchingKey: restaurantData.restaurantId!);
                        }
                        restaurantProductImageLink.value = null;
                        tenSanPhamController.text = '';
                        giaThapNhatController.text = '';
                        giaCaoNhatController.text = '';
                      }
                    },
                    child: Text('+')),
                //  nut cong
                // CustomerButton(
                //   backgoundColor: kPrimaryColor,
                //   BorderRadiuscircular: 10,
                //   buttonHeight: getProportionateScreenHeight(35),
                //   buttonWidth: getProportionateScreenWidth(60),
                //   press: () {
                //     showModalBottomSheet(
                //         backgroundColor: Colors.transparent,
                //         isScrollControlled: true,
                //         context: context,
                //         builder: (context) {
                //           return ModalSheetProduct(
                //             serverProductId: null,
                //             isAccessFromMainScreen: false,
                //           );
                //         });
                //   },
                //   text: "+",
                //   child: Icon(
                //     Icons.add,
                //     color: Colors.white,
                //   ),
                // ),
              ],
            ),
            // SizedBox(height: getProportionateScreenHeight(10)),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     if (restaurantData == null)
            //       Opacity(
            //         opacity: 0.2,
            //         child: ElevatedButton(
            //             onPressed: () {},
            //             child: Text('Cập Nhật Thông Tin Quán')),
            //       ),
            //     if (restaurantData != null)
            //       ElevatedButton(
            //           onPressed: () async {
            //             print(
            //                 '--------------------------------------------------');
            //             await ref
            //                 .read(API.restaurant)
            //                 .searchingRestaurantUserId(
            //                     searchingkey: currentUser.restaurantId);
            //             var imageFoldeStore = await ref
            //                 .read(API.product)
            //                 .createFolderProductImage(
            //                     // category: restaurantData!.restaurantCategory!,
            //                     restaurantName: checkNullStringToString(
            //                         serverData:
            //                             restaurantData?.restaurantName)!,
            //                     productName: tenSanPhamController.text);

            //             var image = await ref
            //                 .read(API.product)
            //                 .uploadProductImage(
            //                     imageLink: restaurantProductImageLink,
            //                     // category: 'doan',
            //                     restaurantName: checkNullStringToString(
            //                         serverData:
            //                             restaurantData?.restaurantName)!,
            //                     productName: tenSanPhamController.text,
            //                     imageFoldeStore: imageFoldeStore);
            //             await ref
            //                 .read(AppStateProvider.productEditNotifier.notifier)
            //                 .createProduct(
            //                     productName: tenSanPhamController.text,
            //                     productImage: image,
            //                     productId: '',
            //                     productPriceThapNhat:
            //                         double.parse(giaThapNhatController.text),
            //                     productPriceCaoNhat:
            //                         double.parse(giaCaoNhatController.text),
            //                     productRating: 0,
            //                     isFavourite: false,
            //                     isPopular: false,
            //                     ship: false,
            //                     booking: false,
            //                     restaurantName: checkNullStringToString(
            //                         serverData:
            //                             restaurantData?.restaurantName)!,
            //                     restaurantId: checkNullStringToString(
            //                         serverData: restaurantData?.restaurantId)!,
            //                     productdetailIdList: []);
            //             if (restaurantData != null) {
            //               await ref
            //                   .read(
            //                       AppStateProvider.productEditNotifier.notifier)
            //                   .searchingProductsOfRestaurantUserId(
            //                       searchingKey: restaurantData.restaurantId!);
            //             }

            //             restaurantProductImageLink.value = null;
            //             tenSanPhamController.text = '';
            //             giaThapNhatController.text = '';
            //             giaCaoNhatController.text = '';
            //           },
            //           child: Text('Cập Nhật Thông Tin san pham')),

            //     // ElevatedButton(
            //     //     onPressed: () {
            //     //       if (_formKey.currentState!.validate()) {
            //     //         // isShowTextFormFielCuaHang.value = false;
            //     //         // isShowTextFormFielDiaChiCuaHang.value = false;

            //     //         // isShowTextFormFielThoiGianPhucVu.value = false;

            //     //         // isShowTextFormFielThoiGianChuanBiMonAn.value = false;

            //     //         // // if all are valid then go to success screen
            //     //         // // KeyboardUtil.hideKeyboard(context);

            //     //         if (_formKey.currentState!.validate()) {
            //     //           _formKey.currentState!.save();

            //     //           // tat nut kiem tra
            //     //           isShowTextFormFielTenSanPham.value = false;
            //     //           isShowGiaSanPham.value = false;
            //     //           isShowTextFormFielCapNhat.value =
            //     //               !isShowTextFormFielCapNhat.value;
            //     //         }
            //     //       }
            //     //     },
            //     //     child: Text('kiem tra')),
            //   ],
            // ),

            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
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
