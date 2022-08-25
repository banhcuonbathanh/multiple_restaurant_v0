// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productdetail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductDetailModel _$$_ProductDetailModelFromJson(
        Map<String, dynamic> json) =>
    _$_ProductDetailModel(
      productdetaitName: json['productdetaitName'] as String?,
      productdetaiDescription: json['productdetaiDescription'] as String?,
      productdetaiImage: json['productdetaiImage'] as String?,
      productdetailFolder: json['productdetailFolder'] as String?,
      productdetaiId: json['productdetaiId'] as String?,
      productdetaiPrice: (json['productdetaiPrice'] as num?)?.toDouble(),
      productdetaiRating: (json['productdetaiRating'] as num?)?.toDouble(),
      productdetailQuantity:
          (json['productdetailQuantity'] as num?)?.toDouble(),
      productdetailBill: (json['productdetailBill'] as num?)?.toDouble(),
      productdetaiIsFavourite: json['productdetaiIsFavourite'] as bool?,
      productdetaiIsPopular: json['productdetaiIsPopular'] as bool?,
      restaurantName: json['restaurantName'] as String?,
      restaurantId: json['restaurantId'] as String?,
      productName: json['productName'] as String?,
      productId: json['productId'] as String?,
      userId: json['userId'] as String?,
      toppingList: (json['toppingList'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      productdetailIdList: (json['productdetailIdList'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      promotion: json['promotion'] as int?,
    );

Map<String, dynamic> _$$_ProductDetailModelToJson(
        _$_ProductDetailModel instance) =>
    <String, dynamic>{
      'productdetaitName': instance.productdetaitName,
      'productdetaiDescription': instance.productdetaiDescription,
      'productdetaiImage': instance.productdetaiImage,
      'productdetailFolder': instance.productdetailFolder,
      'productdetaiId': instance.productdetaiId,
      'productdetaiPrice': instance.productdetaiPrice,
      'productdetaiRating': instance.productdetaiRating,
      'productdetailQuantity': instance.productdetailQuantity,
      'productdetailBill': instance.productdetailBill,
      'productdetaiIsFavourite': instance.productdetaiIsFavourite,
      'productdetaiIsPopular': instance.productdetaiIsPopular,
      'restaurantName': instance.restaurantName,
      'restaurantId': instance.restaurantId,
      'productName': instance.productName,
      'productId': instance.productId,
      'userId': instance.userId,
      'toppingList': instance.toppingList,
      'productdetailIdList': instance.productdetailIdList,
      'promotion': instance.promotion,
    };
