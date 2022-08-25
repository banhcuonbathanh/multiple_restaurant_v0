// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RestaurantModel _$$_RestaurantModelFromJson(Map<String, dynamic> json) =>
    _$_RestaurantModel(
      userId: json['userId'] as String?,
      restaurantName: json['restaurantName'] as String?,
      restaurantCategory: json['restaurantCategory'] as String?,
      restaurantImage: json['restaurantImage'] as String?,
      restaurantImageStoreFolder: json['restaurantImageStoreFolder'] as String?,
      restaurantId: json['restaurantId'] as String?,
      restaurantAdrress: json['restaurantAdrress'] as String?,
      productId: json['productId'] as String?,
      listProductId: (json['listProductId'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      productName: json['productName'] as String?,
      restaurantStartTime: (json['restaurantStartTime'] as num?)?.toDouble(),
      restaurantEndingTime: (json['restaurantEndingTime'] as num?)?.toDouble(),
      restaurantMealPreparation:
          (json['restaurantMealPreparation'] as num?)?.toDouble(),
      restaurantComment: (json['restaurantComment'] as num?)?.toDouble(),
      restaurantRating: (json['restaurantRating'] as num?)?.toDouble(),
      ship: json['ship'] as bool?,
      booking: json['booking'] as bool?,
      promotionList: (json['promotionList'] as List<dynamic>?)
          ?.map((e) => e as int?)
          .toList(),
    );

Map<String, dynamic> _$$_RestaurantModelToJson(_$_RestaurantModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'restaurantName': instance.restaurantName,
      'restaurantCategory': instance.restaurantCategory,
      'restaurantImage': instance.restaurantImage,
      'restaurantImageStoreFolder': instance.restaurantImageStoreFolder,
      'restaurantId': instance.restaurantId,
      'restaurantAdrress': instance.restaurantAdrress,
      'productId': instance.productId,
      'listProductId': instance.listProductId,
      'productName': instance.productName,
      'restaurantStartTime': instance.restaurantStartTime,
      'restaurantEndingTime': instance.restaurantEndingTime,
      'restaurantMealPreparation': instance.restaurantMealPreparation,
      'restaurantComment': instance.restaurantComment,
      'restaurantRating': instance.restaurantRating,
      'ship': instance.ship,
      'booking': instance.booking,
      'promotionList': instance.promotionList,
    };
