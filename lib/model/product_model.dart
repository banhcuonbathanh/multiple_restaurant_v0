import 'package:freezed_annotation/freezed_annotation.dart';

import 'topping_model.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  factory ProductModel({
    required String? productName,
    required String? productImage,
    required String? productId,
    required double? productPriceThapNhat,
    required double? productPriceCaoNhat,
    required double? productRating,
    required bool? isFavourite,
    required bool? isPopular,
    required String? restaurantName,
    required String? restaurantId,
    required List<String?>? productdetailIdList,
    required List<String?>? toppingList,
    required String? folderProductImage,
    required List<int?>? promotionList,

    // required List<ToppingModel>? toppingList,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

List<ProductModel> productFromJson(dynamic str) =>
    List<ProductModel>.from((str).map((e) => ProductModel.fromJson(e)));


      // required bool ship,
    // required bool booking,
     // required String? productDescription,
  // factory Product.create(String restaurantName, String productName) {
  //   return Product(
  //     productId:
  //   );
  // }