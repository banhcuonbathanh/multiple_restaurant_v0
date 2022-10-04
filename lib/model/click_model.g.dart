// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'click_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClickModel _$$_ClickModelFromJson(Map<String, dynamic> json) =>
    _$_ClickModel(
      clickName: json['clickName'] as String,
      restaurantName: json['restaurantName'] as String,
      restaurantId: json['restaurantId'] as String,
      productName: json['productName'] as String,
      productId: json['productId'] as String,
      clickingTiming: (json['clickingTiming'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      monitoringDay: json['monitoringDay'] as String,
      clickId: json['clickId'] as String,
    );

Map<String, dynamic> _$$_ClickModelToJson(_$_ClickModel instance) =>
    <String, dynamic>{
      'clickName': instance.clickName,
      'restaurantName': instance.restaurantName,
      'restaurantId': instance.restaurantId,
      'productName': instance.productName,
      'productId': instance.productId,
      'clickingTiming': instance.clickingTiming,
      'monitoringDay': instance.monitoringDay,
      'clickId': instance.clickId,
    };
