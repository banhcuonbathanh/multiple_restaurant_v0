import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/exception/repository_exception.dart';
import 'package:untitled1/model/order_model.dart';
import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/model/topping_model.dart';
import 'package:untitled1/utils.dart';

import '../helper/dio_inteceptor.dart';

class APIOrderTest {
  final Reader read;
  final Dio dio = Dio();

  APIOrderTest(this.read) {
    dio.interceptors.add(DioInterceptor(read));
  }

  // --------------------------------------------------------------------------
  Future<OrderModel> createOrderTest({
    required String restaurantName,
    required String BuyingUserName,
    required String BuyingUserId,
    required String ProductId,
    required String address,
    required String restaurantId,
    required String day,
    required String hour,
    required String minute,
    required String restaurantOnwnerId,
    required List<ProductDetailModel> productdetailsList,
    required List<ToppingModel> toppingsList,
  }) async {
    final productdetail =
        read(AppStateProvider.productdetailMapNotifier)!.values.toList();
    final toppings =
        read(AppStateProvider.toppingEditMapNotifier).values.toList();
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/ordertest/createOrderTestModel/', data: {
        'BuyingUserName': BuyingUserName,
        'BuyingUserId': BuyingUserId,
        'ProductId': ProductId,
        'address': address,
        'restaurantId': restaurantId,
        'day': day,
        'hour': hour,
        'minute': minute,
        'statusOrder': 'dat hang',
        'restaurantOnwnerId': restaurantOnwnerId,
        'productdetailsList': productdetailsList,
        'toppingsList': toppingsList,
        'restaurantName': restaurantName,
      });
      final productdetaullist =
          productDetailFromJson(response.data['productdetailsList']);

      final toppinglist = toppingsFromJson(response.data['toppingsList']);

      OrderModel test1 = OrderModel(
        address: response.data['address'],
        day: response.data['day'],
        BuyingUserId: response.data['BuyingUserId'],
        hour: response.data['hour'],
        minute: response.data['minute'],
        orderId: response.data['orderTestId'],
        productdetailsIdList: productdetaullist,
        ProductId: response.data['ProductId'],
        restaurantId: response.data['restaurantId'],
        restaurantOnwnerId: response.data['restaurantOnwnerId'],
        statusOrder: response.data['statusOrder'],
        toppingsList: toppinglist,
        BuyingUserName: response.data['BuyingUserName'],
        restaurantName: response.data['restaurantName'],
        createAt: response.data['createAt'],
      );

      return test1;
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }
// ---------------------------

  Future<List<OrderModel>> searchingorderByBuyingUserId({
    required String BuyingUserId,
    required String statusOrder,
    required int page,
    required int numberOfOrder,
  }) async {
    try {
      final responses = await dio.post(
          'http://127.0.0.1:3000/ordertest/searchingorderByBuyingUserId/',
          data: {
            'BuyingUserId': BuyingUserId,
            'statusOrder': statusOrder,
            'page': page,
            'numberOfOrder': numberOfOrder,
          });

      if (responses.data.runtimeType == String) {
        return [];
      } else {
        final test = List<OrderModel>.from((responses.data).map((response) {
          final productdetaullist =
              productDetailFromJson(response['productdetailsList']);

          final toppinglist = toppingsFromJson(response['toppingsList']);

          OrderModel test1 = OrderModel(
            address: response['address'],
            day: response['day'],
            BuyingUserId: response['BuyingUserId'],
            hour: response['hour'],
            minute: response['minute'],
            orderId: response['orderTestId'],
            productdetailsIdList: productdetaullist,
            ProductId: response['ProductId'],
            restaurantId: response['restaurantId'],
            restaurantOnwnerId: response['restaurantOnwnerId'],
            statusOrder: response['statusOrder'],
            toppingsList: toppinglist,
            BuyingUserName: response['BuyingUserName'],
            restaurantName: response['restaurantName'],
            createAt: response['createAt'],
          );

          return test1;
        }));

        return test;
      }
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

// ---------------------------

// ---------------------------

  Future<List<OrderModel>> searchingorderByRangeOfDate(
      {required String fromDate,
      required String toDate,
      required String restaurantOnwnerId}) async {
    try {
      final responses = await dio.post(
          'http://127.0.0.1:3000/ordertest/searchingorderByRangeOfDate/',
          data: {
            'fromDate': fromDate,
            'toDate': toDate,
            'restaurantOnwnerId': restaurantOnwnerId,
          });

      if (responses.data.runtimeType == String) {
        return [];
      } else {
        final test = List<OrderModel>.from((responses.data).map((response) {
          final productdetaullist =
              productDetailFromJson(response['productdetailsList']);

          final toppinglist = toppingsFromJson(response['toppingsList']);

          OrderModel test1 = OrderModel(
              address: response['address'],
              day: response['day'],
              BuyingUserId: response['BuyingUserId'],
              hour: response['hour'],
              minute: response['minute'],
              orderId: response['orderTestId'],
              productdetailsIdList: productdetaullist,
              ProductId: response['ProductId'],
              restaurantId: response['restaurantId'],
              restaurantOnwnerId: response['restaurantOnwnerId'],
              statusOrder: response['statusOrder'],
              toppingsList: toppinglist,
              BuyingUserName: response['BuyingUserName'],
              restaurantName: response['restaurantName'],
              createAt: response['createAt']);

          return test1;
        }));

        return test;
      }
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }
// ----- testtesttesttesttesttesttesttesttesttesttesttesttesttesttest

  // Future<String> createFolderProductDetailImage_test({
  //   required String category,
  //   required String restaurantName,
  //   required String productName,
  //   required String productDetailName,
  // }) async {
  //   var formdata = FormData.fromMap(
  //     {
  //       'category': category,
  //       'restaurantName': restaurantName,
  //       'productName': productName,
  //       'productDetailName': productDetailName,
  //     },
  //   );

  // final test = await exceptionHandler1(
  //   computation: dio.post(
  //       'http://127.0.0.1:3000/folder/createProductDetailImage/',
  //       data: {
  //         'category': category,
  //         'restaurantName': restaurantName,
  //         'productName': productName,
  //         'productDetailName': productDetailName,
  //       }),
  //   read: read,
  // );

  // Map<String, dynamic> imageFolderlinkinMap = jsonDecode(test.toString());
  // String imageFolderlinkinString = imageFolderlinkinMap['link'];

  // return imageFolderlinkinString.substring(1);
  // try {
  //   final response = await dio.post(
  //       'http://127.0.0.1:3000/folder/createProductDetailImage/',
  //       data: {
  //         'category': category,
  //         'restaurantName': restaurantName,
  //         'productName': productName,
  //         'productDetailName': productDetailName,
  //       });

  //   Map<String, dynamic> imageFolderlinkinMap =
  //       jsonDecode(response.toString());
  //   String imageFolderlinkinString = imageFolderlinkinMap['link'];

  //   return imageFolderlinkinString.substring(1);
  // } on DioError catch (e) {
  //   print('DioError, createFolderProductDetailImage APIProductDetailService');
  //   throw Exception(' failed to create restaurant');
  // }
  // }
// ----- testtesttesttesttesttesttesttesttesttesttesttesttesttesttest

  // --------------------------------------------------------------------------
  Future<String> uploadProductDetailImage({
    required ValueNotifier<File?> imageLink,
    required String restaurantName,
    required String? productName,
    required String? productDetailName,
    required String imageFoldeStore,
  }) async {
    var formdata = FormData.fromMap(
      {
        'productDetailName': productDetailName,
        'restaurantName': restaurantName,
        'productName': productName,
        'imageFoldeStore': imageFoldeStore,
        "image": await MultipartFile.fromFile(
          imageLink.value!.path,
        ),
      },
    );
    var response =
        await dio.post("http://127.0.0.1:3000/upload/", data: formdata);

    var test = jsonDecode(response.toString());

    var location = test['imagelink'].lastIndexOf('uploads');
    String image =
        ('http://127.0.0.1:3000/' + test['imagelink'].substring(location));
    // print(image);
    return image;
  }

  // --------------------------------------------------------------------------
  Future<ProductDetailModel> createProductDetail(
      {required ProductDetailModel productdetail}) async {
    try {
      final response = await dio.post(
          'http://127.0.0.1:3000/productDetail/createProductDetail/',
          data: productdetail.toJson());

      return ProductDetailModel.fromJson(response.data);
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }
// vvvv----------------------------------------

  // Future<ProductDetail> createProductDetail_Test1(
  //     {required ProductDetail productdetail}) async {
  //   final test = await exceptionHandler(dio.post(
  //       'http://127.0.0.1:3000/productDetail/createProductDetail/',
  //       data: productdetail.toJson()));
  //   return ProductDetail.fromJson(test.data);
  // }

// aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
  // --------------------------------------------------------------------------
  Future<void> uploadProduct({
    required ValueNotifier<File?> imageLink,
    required String category,
  }) async {
    var formdata = FormData.fromMap(
      {
        category: category,
        "product": await MultipartFile.fromFile(
          imageLink.value!.path,
        ),
      },
    );

    await dio.post("http://127.0.0.1:3000/upload/product", data: formdata);

    // print(jsonDecode(response.toString()));
  }

  Future<List<ProductDetailModel>> getAllProduct() async {
    try {
      final response = await dio
          .get("http://127.0.0.1:3000/productDetail/getAllProductDetail/");

      final List<ProductDetailModel> listProduct =
          productDetailFromJson(response.data);

      return listProduct;
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  // --------------------------------------------------------------------------
  Future<ProductDetailModel> getOne({
    required String productDetailId,
  }) async {
    // var formData = FormData.fromMap({
    //   'productDetailId': productDetailId,
    // });
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/productDetail/getProductDetail/', data: {
        'productDetailId': productDetailId,
      });

      return ProductDetailModel.fromJson(response.data);
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  // --------------------------------------------------------------------------
  Future<OrderModel> getoneandupdate({
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

    // required String? category,
  }) async {
    // var formData = FormData.fromMap({
    //   'productdetaiId': productdetaiId,
    //   'productdetailQuantity': productdetailQuantity,
    //   'productdetailBill': productdetailBill,
    // });
    try {
      final response =
          await dio.post('http://127.0.0.1:3000/ordertest/updateOrder/', data: {
        'BuyingUserId': BuyingUserId,
        'ProductId': ProductId,
        'address': address,
        'restaurantId': restaurantId,
        'day': day,
        'hour': hour,
        'minute': minute,
        'restaurantOnwnerId': restaurantOnwnerId,
        'productdetailsIdList': productdetailsIdList,
        'toppingsList': toppingsList,
        'BuyingUserName': BuyingUserName,
        'restaurantName': restaurantName, 'orderTestId': orderId,
        'statusOrder': statusOrder,
        // 'category': category,
      });

      final productdetaullist =
          productDetailFromJson(response.data['productdetailsList']);

      final toppinglist = toppingsFromJson(response.data['toppingsList']);

      OrderModel test1 = OrderModel(
          address: response.data['address'],
          day: response.data['day'],
          BuyingUserId: response.data['BuyingUserId'],
          hour: response.data['hour'],
          minute: response.data['minute'],
          orderId: response.data['orderTestId'],
          productdetailsIdList: productdetaullist,
          ProductId: response.data['ProductId'],
          restaurantId: response.data['restaurantId'],
          restaurantOnwnerId: response.data['restaurantOnwnerId'],
          statusOrder: response.data['statusOrder'],
          toppingsList: toppinglist,
          BuyingUserName: response.data['BuyingUserName'],
          restaurantName: response.data['restaurantName'],
          createAt: response.data['createAt']);
      return test1;
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  // --------------------------------------------------------------------------
  Future<List<ProductDetailModel>> searchingProductDetailproductId({
    required String searchingkey,
  }) async {
    // var formData = FormData.fromMap({
    //   'searchingkey': searchingkey,
    // });
    try {
      final response = await dio.post(
          'http://127.0.0.1:3000/productDetail/searchingProductdetailRestaurantId/',
          data: {
            'searchingkey': searchingkey,
          });
      // print('searchingProductDetailproductId api productdetail');
      // print(response);
      return productDetailFromJson(response.data);
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  // --------------------------------------------------------------------------
  Future<void> getOneandDelete(
      {required String productdetaiId, required String productId}) async {
    // var formData = FormData.fromMap({
    //   'productdetaiId': productdetaiId,
    //   'productId': productId,
    // });
    try {
      await dio
          .post('http://127.0.0.1:3000/productdetail/getOneandDelete/', data: {
        'productdetaiId': productdetaiId,
        'productId': productId,
      });

      // return ProductDetail.fromJson(response.data);
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  Future<void> deleteAllProductDetailOfRestaurant({
    required String restaurantId,
  }) async {
    // var formData = FormData.fromMap({
    //   'restaurantId': restaurantId,
    // });
    try {
      final response = await dio.post(
          'http://127.0.0.1:3000/productDetail/deleteAllProductDetailOfRestaurant/',
          data: {
            'restaurantId': restaurantId,
          });
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  Future<void> deleteProductDetailImage({
    required String productdetailImage,
    required String newProductDetailImage,
    required String productdetailId,
  }) async {
    // var formdata = FormData.fromMap(
    //   {
    //     'restaurantImage': restaurantImage,
    //   },
    // );
    try {
      await dio.post('http://127.0.0.1:3000/folder/deleteProductDetailImage/',
          data: {
            'productdetailImage': productdetailImage,
            'newProductDetailImage': newProductDetailImage,
            'productdetailId': productdetailId,
          });
    } on DioError catch (e) {
      throw Exception(' failed to create restaurant');
    }
  }
}
