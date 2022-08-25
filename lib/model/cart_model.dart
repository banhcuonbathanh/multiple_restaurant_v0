import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
abstract class CartModel with _$CartModel {
  factory CartModel({
    required String? cartitemName,
    required String? cartitemDescription,
    required String? cartitemImage,
    required String? cartitemiId,
    required double? cartdetaiPrice,
    required double? cartdetaiRating,
    required double? cartdetailQuantity,
    required double? cartdetailBill,
    required bool? cartdetaiIsFavourite,
    required bool? cartdetaiIsPopular,
    required String? restaurantName,
    required String? restaurantId,
    required String? productName,
    required String? productId,
    required String? productdetailId,
    required List<String?>? productdetailIdList,
  }) = _CartModel;

  // factory ProductDetail.create(
  //     {required double productQuantity, required double productBill}) {
  //   return ProductDetail(
  //     productBill: productBill, productdetaiDescription: '',
  //   );
  // }

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
}
