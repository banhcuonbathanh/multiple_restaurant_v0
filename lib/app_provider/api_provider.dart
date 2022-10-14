import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_api/api_categories.dart';
import 'package:untitled1/app_api/api_click.dart';
import 'package:untitled1/app_api/api_order.dart';
import 'package:untitled1/app_api/api_product.dart';
import 'package:untitled1/app_api/api_productdetail.dart';
import 'package:untitled1/app_api/api_restaurant.dart';
import 'package:untitled1/app_api/api_topping.dart';
import 'package:untitled1/app_api/api_user.dart';

import '../app_api/api_order_test.dart';
import '../app_api/api_socket.dart';

abstract class API {
  static Provider<APIUser> get user => _user;
  static Provider<APIRestaurant> get restaurant => _restaurant;
  static Provider<APIProduct> get product => _product;
  static Provider<APIProductDetail> get productdetail => _productdetail;
  static Provider<APITopping> get topping => _topping;
  static Provider<APIOrder> get order => _order;
  static Provider<APISocket> get socket => _socket;
  static Provider<APICategory> get category => _category;
  static Provider<APIOrderTest> get orderTest => _orderTest;
  static Provider<APIClick> get click => _click;
}

final _user = Provider<APIUser>((ref) {
  return APIUser(ref.read);
});

final _restaurant = Provider<APIRestaurant>((ref) {
  return APIRestaurant(ref.read);
});

final _product = Provider<APIProduct>((ref) {
  return APIProduct(ref.read);
});

final _productdetail = Provider<APIProductDetail>((ref) {
  return APIProductDetail(ref.read);
});
final _topping = Provider<APITopping>((ref) {
  return APITopping(ref.read);
});
final _order = Provider<APIOrder>((ref) {
  return APIOrder(ref.read);
});

final _socket = Provider<APISocket>((ref) {
  return APISocket(read: ref.read);
});
final _category = Provider<APICategory>((ref) {
  return APICategory(ref.read);
});
final _orderTest = Provider<APIOrderTest>((ref) {
  return APIOrderTest(ref.read);
});
final _click = Provider<APIClick>((ref) {
  return APIClick(ref.read);
});
