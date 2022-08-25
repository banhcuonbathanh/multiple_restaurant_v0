// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CategoryModel _$$_CategoryModelFromJson(Map<String, dynamic> json) =>
    _$_CategoryModel(
      categoryName: json['categoryName'] as String?,
      categoryImage: json['categoryImage'] as String?,
      categoryId: json['categoryId'] as String?,
      ship: json['ship'] as bool?,
      booking: json['booking'] as bool?,
    );

Map<String, dynamic> _$$_CategoryModelToJson(_$_CategoryModel instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'categoryImage': instance.categoryImage,
      'categoryId': instance.categoryId,
      'ship': instance.ship,
      'booking': instance.booking,
    };
