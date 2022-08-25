import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_model.freezed.dart';
part 'restaurant_model.g.dart';

List<RestaurantModel> restaurantsFromJson(dynamic str) =>
    List<RestaurantModel>.from((str).map((e) => RestaurantModel.fromJson(e)));

@freezed
abstract class RestaurantModel with _$RestaurantModel {
  factory RestaurantModel({
    // required ValueNotifier<File?> restaurantImage1,
    required String? userId,
    required String? restaurantName,
    required String? restaurantCategory,
    required String? restaurantImage,
    required String? restaurantImageStoreFolder,
    required String? restaurantId,
    required String? restaurantAdrress,
    required String? productId,
    required List<String?>? listProductId,
    required String? productName,
    required double? restaurantStartTime,
    required double? restaurantEndingTime,
    required double? restaurantMealPreparation,
    required double? restaurantComment,
    required double? restaurantRating,
    required bool? ship,
    required bool? booking,
    required List<int?>? promotionList,
  }) = _RestaurantModel;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);
}
