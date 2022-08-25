// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      userEmail: json['userEmail'] as String?,
      userPassword: json['userPassword'] as String?,
      userAdrress: json['userAdrress'] as String?,
      userPhone: json['userPhone'] as String?,
      userAdmin: json['userAdmin'] as String?,
      restaurantId: json['restaurantId'] as String?,
      favouriteProductDetails:
          (json['favouriteProductDetails'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      userStatus: json['userStatus'] as bool?,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'userPassword': instance.userPassword,
      'userAdrress': instance.userAdrress,
      'userPhone': instance.userPhone,
      'userAdmin': instance.userAdmin,
      'restaurantId': instance.restaurantId,
      'favouriteProductDetails': instance.favouriteProductDetails,
      'userStatus': instance.userStatus,
    };
