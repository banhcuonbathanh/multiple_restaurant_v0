import 'package:freezed_annotation/freezed_annotation.dart';

part 'click_model.freezed.dart';
part 'click_model.g.dart';

@freezed
abstract class ClickModel with _$ClickModel {
  factory ClickModel({
    required String clickName,
    required String restaurantName,
    required String restaurantId,
    required String productName,
    required String productId,
    required List<String> clickingTiming,
    required String monitoringDay,
    required String clickId,
  }) = _ClickModel;

  factory ClickModel.fromJson(Map<String, dynamic> json) =>
      _$ClickModelFromJson(json);
}

List<ClickModel> clickFromJson(dynamic str) =>
    List<ClickModel>.from((str).map((e) => ClickModel.fromJson(e)));
