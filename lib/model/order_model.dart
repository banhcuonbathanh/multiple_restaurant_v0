import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:untitled1/model/product_model.dart';
import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/model/topping_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
abstract class OrderModel with _$OrderModel {
  factory OrderModel({
    required String restaurantName,
    required String BuyingUserName,
    required String BuyingUserId,
    required String ProductId,
    required String restaurantId,
    required List<ProductDetailModel> productdetailsIdList,
    required List<ToppingModel> toppingsList,
    required String statusOrder,
    required String address,
    required String day,
    required String hour,
    required String minute,
    required String orderId,
    required String restaurantOnwnerId,
    required String createAt,

    // required List<ToppingModel>? toppingList,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}

List<OrderModel> productFromJson(dynamic str) =>
    List<OrderModel>.from((str).map((e) => OrderModel.fromJson(e)));
