// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductModel _$$_ProductModelFromJson(Map<String, dynamic> json) =>
    _$_ProductModel(
      productName: json['productName'] as String?,
      productImage: json['productImage'] as String?,
      productId: json['productId'] as String?,
      productPriceThapNhat: (json['productPriceThapNhat'] as num?)?.toDouble(),
      productPriceCaoNhat: (json['productPriceCaoNhat'] as num?)?.toDouble(),
      productRating: (json['productRating'] as num?)?.toDouble(),
      isFavourite: json['isFavourite'] as bool?,
      isPopular: json['isPopular'] as bool?,
      restaurantName: json['restaurantName'] as String?,
      restaurantId: json['restaurantId'] as String?,
      productdetailIdList: (json['productdetailIdList'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      toppingList: (json['toppingList'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      folderProductImage: json['folderProductImage'] as String?,
      promotionList: (json['promotionList'] as List<dynamic>?)
          ?.map((e) => e as int?)
          .toList(),
    );

Map<String, dynamic> _$$_ProductModelToJson(_$_ProductModel instance) =>
    <String, dynamic>{
      'productName': instance.productName,
      'productImage': instance.productImage,
      'productId': instance.productId,
      'productPriceThapNhat': instance.productPriceThapNhat,
      'productPriceCaoNhat': instance.productPriceCaoNhat,
      'productRating': instance.productRating,
      'isFavourite': instance.isFavourite,
      'isPopular': instance.isPopular,
      'restaurantName': instance.restaurantName,
      'restaurantId': instance.restaurantId,
      'productdetailIdList': instance.productdetailIdList,
      'toppingList': instance.toppingList,
      'folderProductImage': instance.folderProductImage,
      'promotionList': instance.promotionList,
    };
