// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderModel _$$_OrderModelFromJson(Map<String, dynamic> json) =>
    _$_OrderModel(
      restaurantName: json['restaurantName'] as String,
      BuyingUserName: json['BuyingUserName'] as String,
      BuyingUserId: json['BuyingUserId'] as String,
      ProductId: json['ProductId'] as String,
      restaurantId: json['restaurantId'] as String,
      productdetailsIdList: (json['productdetailsIdList'] as List<dynamic>)
          .map((e) => ProductDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      toppingsList: (json['toppingsList'] as List<dynamic>)
          .map((e) => ToppingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusOrder: json['statusOrder'] as String,
      address: json['address'] as String,
      day: json['day'] as String,
      hour: json['hour'] as String,
      minute: json['minute'] as String,
      orderId: json['orderId'] as String,
      restaurantOnwnerId: json['restaurantOnwnerId'] as String,
    );

Map<String, dynamic> _$$_OrderModelToJson(_$_OrderModel instance) =>
    <String, dynamic>{
      'restaurantName': instance.restaurantName,
      'BuyingUserName': instance.BuyingUserName,
      'BuyingUserId': instance.BuyingUserId,
      'ProductId': instance.ProductId,
      'restaurantId': instance.restaurantId,
      'productdetailsIdList': instance.productdetailsIdList,
      'toppingsList': instance.toppingsList,
      'statusOrder': instance.statusOrder,
      'address': instance.address,
      'day': instance.day,
      'hour': instance.hour,
      'minute': instance.minute,
      'orderId': instance.orderId,
      'restaurantOnwnerId': instance.restaurantOnwnerId,
    };
