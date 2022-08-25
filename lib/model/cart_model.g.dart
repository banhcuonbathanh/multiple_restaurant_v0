// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CartModel _$$_CartModelFromJson(Map<String, dynamic> json) => _$_CartModel(
      cartitemName: json['cartitemName'] as String?,
      cartitemDescription: json['cartitemDescription'] as String?,
      cartitemImage: json['cartitemImage'] as String?,
      cartitemiId: json['cartitemiId'] as String?,
      cartdetaiPrice: (json['cartdetaiPrice'] as num?)?.toDouble(),
      cartdetaiRating: (json['cartdetaiRating'] as num?)?.toDouble(),
      cartdetailQuantity: (json['cartdetailQuantity'] as num?)?.toDouble(),
      cartdetailBill: (json['cartdetailBill'] as num?)?.toDouble(),
      cartdetaiIsFavourite: json['cartdetaiIsFavourite'] as bool?,
      cartdetaiIsPopular: json['cartdetaiIsPopular'] as bool?,
      restaurantName: json['restaurantName'] as String?,
      restaurantId: json['restaurantId'] as String?,
      productName: json['productName'] as String?,
      productId: json['productId'] as String?,
      productdetailId: json['productdetailId'] as String?,
      productdetailIdList: (json['productdetailIdList'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
    );

Map<String, dynamic> _$$_CartModelToJson(_$_CartModel instance) =>
    <String, dynamic>{
      'cartitemName': instance.cartitemName,
      'cartitemDescription': instance.cartitemDescription,
      'cartitemImage': instance.cartitemImage,
      'cartitemiId': instance.cartitemiId,
      'cartdetaiPrice': instance.cartdetaiPrice,
      'cartdetaiRating': instance.cartdetaiRating,
      'cartdetailQuantity': instance.cartdetailQuantity,
      'cartdetailBill': instance.cartdetailBill,
      'cartdetaiIsFavourite': instance.cartdetaiIsFavourite,
      'cartdetaiIsPopular': instance.cartdetaiIsPopular,
      'restaurantName': instance.restaurantName,
      'restaurantId': instance.restaurantId,
      'productName': instance.productName,
      'productId': instance.productId,
      'productdetailId': instance.productdetailId,
      'productdetailIdList': instance.productdetailIdList,
    };
