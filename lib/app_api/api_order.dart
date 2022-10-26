import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:untitled1/model/order_model.dart';

import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/model/topping_model.dart';

import '../helper/dio_inteceptor.dart';

class APIOrder {
  final Dio dio = Dio();
  final Reader read;
  APIOrder(this.read) {
    dio.interceptors.add(DioInterceptor(read));
    print('trong APIUser check DioInterceptor');
  }
// -------------------------------

  // APIOrder() {
  //   dio.interceptors.add(
  //     InterceptorsWrapper(
  //         onRequest: (options, handler) {},
  //         onResponse: (response, handler) {},
  //         onError: (error, handler) {}),
  //   );
  // }
  // --------------------------------------------------------------------------
  Future<OrderModel> createOrder({
    required List<ProductDetailModel> productdetailsList,
    required List<ToppingModel> toppingsList,
    required String BuyingUserId,
    required String ProductId,
    required String restaurantId,
    required String address,
    required String day,
    required String hour,
    required String minute,
    required String restaurantOnwnerId,
  }) async {
    // var formData = FormData.fromMap({
    //   'userId': userId,
    // });
    try {
      final response =
          await dio.post('http://127.0.0.1:3000/order/createOrder/', data: {
        'BuyingUserId': 'BuyingUserId',
        'ProductId': 'ProductId',
        'restaurantId': 'restaurantId',
        'productdetailsList': [],
        'toppingsList': [],
        'statusOrder': 'dat_hang',
        'address': 'address',
        'day': 'day',
        'hour': 'hour',
        'minute': 'minute',
        'restaurantOnwnerId': restaurantOnwnerId,
      });

      final productdetaullist =
          productDetailFromJson(response.data['productdetailsList']);

      final toppinglist = toppingsFromJson(response.data['toppingsList']);

      OrderModel test1 = OrderModel(
        BuyingUserId: response.data['BuyingUserId'],
        productdetailsIdList: productdetaullist,
        ProductId: response.data['ProductId'],
        restaurantId: response.data['restaurantId'],
        toppingsList: toppinglist,
        statusOrder: response.data['statusOrder'],
        address: response.data['address'],
        day: response.data['day'],
        hour: response.data['orderTiming'],
        minute: response.data['orderTiming'],
        orderId: response.data['orderId'],
        restaurantOnwnerId: response.data['restaurantOnwnerId'],
        BuyingUserName: '',
        restaurantName: '',
        createAt: response.data['createAt'],
      );

      return test1;
      // print('test1');
      // print(test1);
      // OrderModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

  // --------------------------------------------------------------------------

  // --------------------------------------------------------------------------

  // --------------------------------------------------------------------------
  Future<OrderModel> getOneOrderById({
    required String orderId,
  }) async {
    try {
      final response =
          await dio.post('http://127.0.0.1:3000/order/getOneOrderById/', data: {
        'orderId': orderId,
      });
  
      final productdetaullist =
          productDetailFromJson(response.data['productdetailsList']);

      final toppinglist = toppingsFromJson(response.data['toppingsList']);

      OrderModel test1 = OrderModel(
          BuyingUserId: response.data['BuyingUserId'],
          productdetailsIdList: productdetaullist,
          ProductId: response.data['ProductId'],
          restaurantId: response.data['restaurantId'],
          toppingsList: toppinglist,
          statusOrder: response.data['orderstatus'],
          address: response.data['address'],
          day: response.data['day'],
          hour: response.data['orderTiming'],
          minute: response.data['orderTiming'],
          orderId: response.data['orderId'],
          restaurantOnwnerId: response.data['restaurantOnwnerId'],
          BuyingUserName: '',
          restaurantName: '',
          createAt: response.data['createAt']);

      return test1;
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

  // --------------------------------------------------------------------------
  Future<List<OrderModel>> getOneOrderByBuyingUserId({
    required String BuyingUserId,
  }) async {
    try {
      final responses = await dio.post(
          'http://127.0.0.1:3000/ordertest/getOneOrderByBuyingUserId/',
          data: {
            'BuyingUserId': BuyingUserId,
          });

      final test = List<OrderModel>.from((responses.data).map((response) {
        final productdetaullist =
            productDetailFromJson(response['productdetailsList']);

        final toppinglist = toppingsFromJson(response['toppingsList']);

        OrderModel test1 = OrderModel(
            BuyingUserId: response['BuyingUserId'],
            productdetailsIdList: productdetaullist,
            ProductId: response['ProductId'],
            restaurantId: response['restaurantId'],
            toppingsList: toppinglist,
            statusOrder: response['statusOrder'],
            address: response['address'],
            day: response.data['day'],
            hour: response.data['orderTiming'],
            minute: response.data['orderTiming'],
            orderId: response['orderId'],
            restaurantOnwnerId: response['restaurantOnwnerId'],
            BuyingUserName: response['BuyingUserName'],
            restaurantName: response['restaurantName'],
            createAt: response['createAt']);

        return test1;
      }));

      return test;
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

  // --------------------------------------------------------------------------

  Future<List<OrderModel>> getAllOrder() async {
  
    try {
      final responses = await dio.post(
        'http://127.0.0.1:3000/order/getAllOrder/',
      );

      final test = List<OrderModel>.from((responses.data).map((response) {
        final productdetaullist =
            productDetailFromJson(response['productdetailsList']);

        final toppinglist = toppingsFromJson(response['toppingsList']);

        OrderModel test1 = OrderModel(
            BuyingUserId: response['BuyingUserId'],
            productdetailsIdList: productdetaullist,
            ProductId: response['ProductId'],
            restaurantId: response['restaurantId'],
            toppingsList: toppinglist,
            statusOrder: 'statusorder',
            address: response['address'],
            day: response.data['day'],
            hour: response.data['orderTiming'],
            minute: response.data['orderTiming'],
            orderId: response['orderId'],
            restaurantOnwnerId: response['restaurantOnwnerId'],
            BuyingUserName: response['BuyingUserName'],
            restaurantName: response['restaurantName'],
            createAt: response['createAt']);

        return test1;
      }));

      return test;
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

  // --------------------------------------------------------------------------
  Future<void> getOneandDeleteByOrderId({
    required String orderId,
  }) async {
    // var formData = FormData.fromMap({
    //   'productId': productId,
    //   'restaurantId': restaurantId,
    // });
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/order/getOneandDeleteByOrderId/', data: {
        'orderId': orderId,
      });
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

  Future<void> deleteAllProductOfRestaurant({
    required String restaurantId,
  }) async {
    // var formData = FormData.fromMap({
    //   'restaurantId': restaurantId,
    // });
    try {
     await dio.post(
          'http://127.0.0.1:3000/product/deleteAllProductOfRestaurant/',
          data: {
            'restaurantId': restaurantId,
          });
    } on DioError catch (_) {
      throw Exception(' failed to create post');
    }
  }

  // --------------------------------------

}
