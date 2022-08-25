import 'package:freezed_annotation/freezed_annotation.dart';

part 'topping_model.freezed.dart';
part 'topping_model.g.dart';

List<ToppingModel> toppingsFromJson(dynamic str) =>
    List<ToppingModel>.from((str).map((e) => ToppingModel.fromJson(e)));

@freezed
abstract class ToppingModel with _$ToppingModel {
  factory ToppingModel({
    // required ValueNotifier<File?> restaurantImage1,

    required String? toppingName,
    required String? toppingQuantity,
    required String? productId,
    required String? productDetailId,
    required String? restaurantId,
    required String? userId,
    required String? toppingId,
  }) = _ToppingModel;

  factory ToppingModel.fromJson(Map<String, dynamic> json) =>
      _$ToppingModelFromJson(json);
}
