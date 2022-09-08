import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_state/categories_state.dart';
import 'package:untitled1/app_state/order_state.dart';
import 'package:untitled1/app_state/order_test_state.dart';

import 'package:untitled1/app_state/productdetail_edit_state.dart';

import 'package:untitled1/app_state/productdetail_state_Map.dart';
import 'package:untitled1/app_state/products_edit_state.dart';
import 'package:untitled1/app_state/restaurant_edit_state.dart';
import 'package:untitled1/app_state/restaurant_state1.dart';
import 'package:untitled1/app_state/restaurant_state_map.dart';
import 'package:untitled1/app_state/topping_edit_state%20Map.dart';

import 'package:untitled1/app_state/user_state.dart';
import 'package:untitled1/model/category_model.dart';
import 'package:untitled1/model/order_model.dart';

import 'package:untitled1/model/product_model.dart';
import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/model/restaurant_model.dart';
import 'package:untitled1/model/topping_model.dart';
import 'package:untitled1/model/user_model.dart';

import '../app_state/order_analytic_state.dart';
import '../app_state/product_state_Map.dart';

abstract class AppStateProvider {
  static StateNotifierProvider<UserState, UserModel?> get userNotifier =>
      _userNotifier;
  static StateNotifierProvider<RestaurantState1, List<RestaurantModel>?>
      get restaurantNotifier123 => _restaurantNotifier;
  // static StateNotifierProvider<ProductState, List<ProductModel>?>
  //     get productNotifier1 => _productNotifier;

  get productdetailNotifier1 => productdetailNotifier1;

  static StateNotifierProvider<ProductDetailMapState,
          Map<String, ProductDetailModel>?>
      get productdetailMapNotifier => _productdetailMapNotifier;
  static StateNotifierProvider<RestaurantEditState, RestaurantModel?>
      get restaurantEditNotifier => _restaurantEditNotifier;
  static StateNotifierProvider<ProductsEditState, List<ProductModel>>
      get productEditNotifier => _productEditNotifier;

  static StateNotifierProvider<ProductDetailEditState, List<ProductDetailModel>>
      get productDetailEditState => _productDetailEditState;

  static StateNotifierProvider<ToppingEditStateMap, Map<String, ToppingModel>>
      get toppingEditMapNotifier => _ToppingEditMapNotifier;

  static StateNotifierProvider<OrderState, Map<String, OrderModel>>
      get orderNotifier => _orderNotifier;

  static StateNotifierProvider<CategoryState, List<CategoryModel>>
      get categoriesNotifier => _categoriesNotifier;
  static StateNotifierProvider<RestaurantStateMap, Map<String, RestaurantModel>>
      get restaurantStateMap => _restaurantStateMap;

  static StateNotifierProvider<ProductStateMap, Map<String, ProductModel>?>
      get productMapNotifier => _productMapNotifier;

  static StateNotifierProvider<OrderTestState, Map<String, OrderModel>>
      get orderTestNotifier => orderTestNotifier1;
  static StateNotifierProvider<OrderAnalyticState, Map<String, OrderModel>>
      get orderAnalytic => _orderAnalytic;
}

final _userNotifier = StateNotifierProvider<UserState, UserModel?>((ref) {
  return UserState(ref.read);
});

final _restaurantNotifier =
    StateNotifierProvider<RestaurantState1, List<RestaurantModel>?>((ref) {
  return RestaurantState1(ref.read);
});

// final _productNotifier =
//     StateNotifierProvider<ProductState, List<ProductModel>?>((ref) {
//   return ProductState(ref.read);
// });

final _productdetailMapNotifier = StateNotifierProvider<ProductDetailMapState,
    Map<String, ProductDetailModel>?>((ref) {
  return ProductDetailMapState(ref.read, {});
});

final _restaurantEditNotifier =
    StateNotifierProvider<RestaurantEditState, RestaurantModel?>((ref) {
  return RestaurantEditState(
    ref.read,
  );
});

final _productEditNotifier =
    StateNotifierProvider<ProductsEditState, List<ProductModel>>((ref) {
  return ProductsEditState(
    ref.read,
  );
});

final _ToppingEditMapNotifier =
    StateNotifierProvider<ToppingEditStateMap, Map<String, ToppingModel>>(
        (ref) {
  return ToppingEditStateMap(
    ref.read,
  );
});

final _orderNotifier =
    StateNotifierProvider<OrderState, Map<String, OrderModel>>((ref) {
  return OrderState(
    ref.read,
  );
});

final _productDetailEditState =
    StateNotifierProvider<ProductDetailEditState, List<ProductDetailModel>>(
        (ref) {
  return ProductDetailEditState(
    ref.read,
  );
});

final _categoriesNotifier =
    StateNotifierProvider<CategoryState, List<CategoryModel>>((ref) {
  return CategoryState(
    ref.read,
  );
});

final _restaurantStateMap =
    StateNotifierProvider<RestaurantStateMap, Map<String, RestaurantModel>>(
        (ref) {
  return RestaurantStateMap(ref.read, {});
});

final _productMapNotifier =
    StateNotifierProvider<ProductStateMap, Map<String, ProductModel>?>((ref) {
  return ProductStateMap(ref.read, {});
});
final orderTestNotifier1 =
    StateNotifierProvider<OrderTestState, Map<String, OrderModel>>((ref) {
  return OrderTestState(
    ref.read,
  );
});
final _orderAnalytic =
    StateNotifierProvider<OrderAnalyticState, Map<String, OrderModel>>((ref) {
  return OrderAnalyticState(
    ref.read,
  );
});
