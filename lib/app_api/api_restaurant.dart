import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/model/restaurant_model.dart';

class APIRestaurant {
  final Dio dio = Dio();

  Future<String> uploadImage(
      {required ValueNotifier<File?> imageLink,
      required String category,
      required String restaurantName,
      required String imageFoldeStore}) async {
    var formdata = FormData.fromMap(
      {
        'category': category,
        'restaurantName': restaurantName,
        'imageFoldeStore': imageFoldeStore,
        "image": await MultipartFile.fromFile(
          imageLink.value!.path,
        ),
      },
    );
    var response =
        await dio.post("http://127.0.0.1:3000/upload/", data: formdata);

    var test = jsonDecode(response.toString());

    // print(test['imagelink']);
    var location = test['imagelink'].lastIndexOf('uploads');
    String image =
        ('http://127.0.0.1:3000/' + test['imagelink'].substring(location));
    return image;
  }

  Future<String> createFolderRestaurantImage({
    required String category,
    required String restaurantName,
  }) async {
    // var formdata = FormData.fromMap(
    //   {
    //     'category': category,
    //     'restaurantName': restaurantName,
    //   },
    // );
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/folder/createRestaurantImage/', data: {
        'category': category,
        'restaurantName': restaurantName,
      });

      Map<String, dynamic> imageFolderlinkinMap =
          jsonDecode(response.toString());
      String imageFolderlinkinString = imageFolderlinkinMap['link'];

      return imageFolderlinkinString.substring(1);
    } on DioError catch (e) {
      throw Exception(' failed to create restaurant');
    }
  }

// --------------------------------------------------------------------------
  Future<RestaurantModel> createRestaurant({
    required String? userId,
    required String? restaurantCategory,
    required String? restaurantName,
    required String? restaurantImage,
    required String? restaurantId,
    required String? restaurantAdrress,
    required double? restaurantStartTime,
    required double? restaurantEndingTime,
    required double? restaurantMealPreparation,
    required double? restaurantComment,
    required double? restaurantRating,
    required bool? ship,
    required bool? booking,
    required String? restaurantImageStoreFolder,
  }) async {
    // var formData = FormData.fromMap({
    //   'userId': userId,
    //   'restaurantCategory': restaurantCategory,
    //   'restaurantName': restaurantName,
    //   'restaurantImage': restaurantImage,
    //   'restaurantId': restaurantId,
    //   'restaurantAdrress': restaurantAdrress,
    //   'restaurantStartTime': restaurantStartTime,
    //   'restaurantEndingTime': restaurantEndingTime,
    //   'restaurantMealPreparation': restaurantMealPreparation,
    //   'restaurantComment': restaurantComment,
    //   'ship': ship,
    //   'booking': booking,
    //   'restaurantRating': restaurantRating,
    //   //  "image": await MultipartFile.fromFile(
    //   //     restaurantImage.value!.path,
    //   //   ),
    // });

    try {
      final response = await dio
          .post('http://127.0.0.1:3000/restaurant/createRestaurant/', data: {
        'userId': userId,
        'restaurantCategory': restaurantCategory,
        'restaurantName': restaurantName,
        'restaurantImage': restaurantImage,
        'restaurantId': restaurantId,
        'restaurantAdrress': restaurantAdrress,
        'restaurantStartTime': restaurantStartTime,
        'restaurantEndingTime': restaurantEndingTime,
        'restaurantMealPreparation': restaurantMealPreparation,
        'restaurantComment': restaurantComment,
        'ship': ship,
        'booking': booking,
        'restaurantRating': restaurantRating,
        'restaurantImageStoreFolder': restaurantImageStoreFolder!.substring(1),
      });

      return RestaurantModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to create restaurant');
    }
  }

// --------------------------------------------------------------------------
  Future<List<RestaurantModel>> getAllRestaurant() async {
    try {
      final response =
          await dio.get("http://127.0.0.1:3000/restaurant/getAllRestaurant/");

      final List<RestaurantModel> listRestaurant =
          restaurantsFromJson(response.data);

      return listRestaurant;
    } on DioError catch (e) {
      throw Exception(' failed to get category');
    }
  }

// --------------------------------------------------------------------------
  Future<RestaurantModel> searchingRestaurant({
    required String? searchingKey,
  }) async {
    try {
      try {
        final response = await dio.post(
            'http://127.0.0.1:3000/restaurant/searchingRestaurant/',
            data: {
              'searchingKey': searchingKey,
            });
        // print('response.toString() searchingRestaurant ');
        // print(response.toString());
        return RestaurantModel.fromJson(response.data);
      } on DioError catch (e) {
        throw Exception(' failed to create restaurant');
      }
    } on DioError catch (e) {
      throw Exception(' failed to get category');
    }
  }

// --------------------------------------------------------------------------
  Future<List<RestaurantModel>> searchingRestaurantswithCategory_Page(
      {required String categoryName,
      required int page,
      required int numberOfRestaurant}) async {
    try {
      final response = await dio.post(
          'http://127.0.0.1:3000/restaurant/searchingRestaurantswithCategory_Page/',
          data: {
            'categoryName': categoryName,
            'page': page,
            'numberOfRestaurant': numberOfRestaurant,
          });
      // print('<<<<<<<<<<<<<<<<<<<<<<<');
      // print('response.data.runtimeType');
      // print(response.data.runtimeType == String);
      if (response.data.runtimeType == String) {
        return [];
      } else {
        // print('falsssssssssssss');
        final test = response.data as List;

        return restaurantsFromJson(test);
      }
    } on DioError catch (e) {
      throw Exception(' failed to create restaurant');
    }
  }
// --------------------------------------------------------------------------

  Future<RestaurantModel> searchingRestaurantUserId({
    required String? restaurantId,
  }) async {
    // print('searchingRestaurantUserId APIRestaurantService');

    try {
      final response = await dio.post(
          'http://127.0.0.1:3000/restaurant/searchingRestaurantId/',
          data: {
            'restaurantId': restaurantId,
          });

      // print(jsonDecode(response.toString()));
      // print(response.toString());
      return RestaurantModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to create restaurant');
    }
  }
// --------------------------------------------------------------------------

  Future<List<RestaurantModel>> searchingRestaurantPromotion(
      {required int page, required int numberOfRestaurant}) async {
    // print('searchingRestaurantUserId APIRestaurantService');

    try {
      final response = await dio.post(
          'http://127.0.0.1:3000/restaurant/searchingRestaurantPromotion/',
          data: {
            'page': page,
            'numberOfRestaurant': numberOfRestaurant,
          });

      if (response.data.runtimeType == String) {
        return [];
      } else {
        final List<RestaurantModel> listRestaurant =
            restaurantsFromJson(response.data);
        // print(jsonDecode(response.toString()));
        // print(response.toString());
        return listRestaurant;
      }
    } on DioError catch (e) {
      throw Exception(' failed to create restaurant');
    }
  }

// --------------------------------------------------------------------------
  Future<RestaurantModel> getOne({
    required String restaurantId,
  }) async {
    // var formData = FormData.fromMap({
    //   'restaurantId': restaurantId,
    // });
    try {
      final response = await dio.post(
          'http://127.0.0.1:3000/restaurant/searchingRestaurantId/',
          data: {
            'restaurantId': restaurantId,
          });

      return RestaurantModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

// --------------------------------------------------------------------------
  Future<RestaurantModel> getoneandupdate({
    required String? userId,
    required String? restaurantCategory,
    required String? restaurantName,
    required String? restaurantImage,
    required String? restaurantId,
    required String? restaurantAdrress,
    required String? productId,
    required String? productName,
    required double? restaurantStartTime,
    required double? restaurantEndingTime,
    required double? restaurantMealPreparation,
    required double? restaurantComment,
    required double? restaurantRating,
    required bool? ship,
    required bool? booking,
    required List<String?>? listProductId,
    required String? restaurantImageStoreFolder,
  }) async {
    // print('restaurantAdrress getoneandupdate API');
    // print(restaurantAdrress);
    // var formData = FormData.fromMap({
    //   'restaurantCategory': restaurantCategory,
    //   'restaurantName': restaurantName,
    //   'restaurantImage': restaurantImage,
    //   'restaurantId': restaurantId,
    //   'restaurantAdrress': restaurantAdrress,
    //   'restaurantStartTime': restaurantStartTime,
    //   'restaurantEndingTime': restaurantEndingTime,
    //   'restaurantMealPreparation': restaurantMealPreparation,
    //   'restaurantComment': restaurantComment,
    //   'ship': ship,
    //   'booking': booking,
    //   'restaurantRating': restaurantRating,
    // });

    try {
      final response = await dio
          .post('http://127.0.0.1:3000/restaurant/getoneandupdate/', data: {
        'userId': userId,
        'restaurantName': restaurantName,
        'restaurantCategory': restaurantCategory,
        'restaurantImage': restaurantImage,
        'restaurantId': restaurantId,
        'restaurantAdrress': restaurantAdrress,
        'productId': productId,
        'listProductId': listProductId,
        'productName': productName,
        'restaurantStartTime': restaurantStartTime,
        'restaurantEndingTime': restaurantEndingTime,
        'restaurantMealPreparation': restaurantMealPreparation,
        'restaurantComment': restaurantComment,
        'ship': ship,
        'booking': booking,
        'restaurantRating': restaurantRating,
        'restaurantImageStoreFolder': restaurantImageStoreFolder,
      });

      return RestaurantModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to get one and update');
    }
  }

// --------------------------------------------------------------------------
  Future<void> getOneandDelete({
    required String restaurantId,
    required String restaurantImageStoreFolder,
  }) async {
    // var formData = FormData.fromMap({
    //   'restaurantId': restaurantId,
    // });
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/restaurant/getOneandDelete/', data: {
        'restaurantId': restaurantId,
        'restaurantImageStoreFolder': restaurantImageStoreFolder,
      });
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

// --------------------------------------------------------------------------
  Future<void> uploadtest({
    required ValueNotifier<File?> imageLink,
    required String category,
  }) async {
    // print('day la imageLink');
    // print(imageLink.value);
    var formdata = FormData.fromMap(
      {
        'category': 'category',
        "image": await MultipartFile.fromFile(
          imageLink.value!.path,
        ),
      },
    );
    var response = await dio.post(
        "http://127.0.0.1:3000/restaurant/createRestaurant/",
        data: formdata);

    // print(jsonDecode(response.toString()));
  }

  // ------------------------------------------------------------------------------

  Future<void> deleteRestaurantImage(
      {required String restaurantImage,
      required String newRestaurantImage,
      required String restaurantId}) async {
    // var formdata = FormData.fromMap(
    //   {
    //     'restaurantImage': restaurantImage,
    //   },
    // );
    try {
      await dio
          .post('http://127.0.0.1:3000/folder/deleteRestaurantImage/', data: {
        'restaurantImage': restaurantImage,
        'newRestaurantImage': newRestaurantImage,
        'restaurantId': restaurantId,
      });
    } on DioError catch (e) {
      throw Exception(' failed to create restaurant');
    }
  }

  // --------------------------------------------------------------------------
  Future<void> deleteProductImage(
      {required String productImage,
      required String newProductImage,
      required String productId}) async {
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/folder/deleteProductImage/', data: {
        'productImage': productImage,
        'newProductImage': newProductImage,
        'productId': productId,
      });
    } on DioError catch (e) {
      throw Exception(' failed to create restaurant');
    }
  }
  // -----------------------------------------------------

  Future<void> deleteProductDetailImage(
      {required String productdetailImage,
      required String newProductDetailImage,
      required String productdetaiId}) async {
    try {
      final response = await dio.post(
          'http://127.0.0.1:3000/folder/deleteProductDetailImage/',
          data: {
            'productdetailImage': productdetailImage,
            'newProductDetailImage': newProductDetailImage,
            'productdetaiId': productdetaiId,
          });
    } on DioError catch (e) {
      throw Exception(' failed to create restaurant');
    }
  }
}
