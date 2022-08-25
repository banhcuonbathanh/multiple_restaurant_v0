// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topping_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ToppingModel _$$_ToppingModelFromJson(Map<String, dynamic> json) =>
    _$_ToppingModel(
      toppingName: json['toppingName'] as String?,
      toppingQuantity: json['toppingQuantity'] as String?,
      productId: json['productId'] as String?,
      productDetailId: json['productDetailId'] as String?,
      restaurantId: json['restaurantId'] as String?,
      userId: json['userId'] as String?,
      toppingId: json['toppingId'] as String?,
    );

Map<String, dynamic> _$$_ToppingModelToJson(_$_ToppingModel instance) =>
    <String, dynamic>{
      'toppingName': instance.toppingName,
      'toppingQuantity': instance.toppingQuantity,
      'productId': instance.productId,
      'productDetailId': instance.productDetailId,
      'restaurantId': instance.restaurantId,
      'userId': instance.userId,
      'toppingId': instance.toppingId,
    };
