import 'package:freezed_annotation/freezed_annotation.dart';

part 'productdetail_model.freezed.dart';
part 'productdetail_model.g.dart';

@freezed
abstract class ProductDetailModel with _$ProductDetailModel {
  factory ProductDetailModel({
    required String? productdetaitName,
    required String? productdetaiDescription,
    required String? productdetaiImage,
    required String? productdetailFolder,
    required String? productdetaiId,
    required double? productdetaiPrice,
    required double? productdetaiRating,
    required double? productdetailQuantity,
    required double? productdetailBill,
    required bool? productdetaiIsFavourite,
    required bool? productdetaiIsPopular,
    required String? restaurantName,
    required String? restaurantId,
    required String? productName,
    required String? productId,
    required String? userId,
    required List<String?>? toppingList,
    required List<String?>? productdetailIdList,
    required int? promotion,
  }) = _ProductDetailModel;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);
}

List<ProductDetailModel> productDetailFromJson(dynamic str) =>
    List<ProductDetailModel>.from(
        (str).map((e) => ProductDetailModel.fromJson(e)));
