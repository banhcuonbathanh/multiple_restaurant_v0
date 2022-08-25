import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:untitled1/exception/repository_exception.dart';
import 'package:untitled1/helper/dio_inteceptor.dart';
import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/model/user_model.dart';
import 'package:untitled1/utils.dart';

class APIUser {
  final Reader read;
  final Dio dio = Dio();

  APIUser(this.read) {
    dio.interceptors.add(DioInterceptor(read));
  }
  // APIUser() {
  // dio.interceptors.add(DioInterceptor());
  // }
// --------------------------------------------
  // APIUser({required this.context1}) {
  //   dio.interceptors.add(DioInterceptor(context: null));
  // }

//  dio.interceptors.add(DioInterceptor());
// -----------------------------------------
  Future<UserModel> signInUsertest({
    required UserModel user,
  }) async {
    try {
      final response = await dio.post('http://127.0.0.1:3000/user/signIn',
          data: user.toJson());

      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

// --------------------------------------------
  Future<UserModel> signIn({
    required String? userEmail,
    required String? userPassword,
  }) async {
    try {
      final response =
          await dio.post('http://127.0.0.1:3000/user/signIn', data: {
        'userEmail': userEmail,
        'userPassword': userPassword,
      });

      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('API Create User', e, st);
      throw RepositoryException(
          message: 'API Create User', exception: e, stackTrace: st);
    }
  }

  Future<UserModel> createUser({
    required String? userEmail,
    required String? userPassword,
  }) async {
    // var formData = FormData.fromMap({
    //   'userName': userName,
    //   'userEmail': userEmail,
    //   'userPassword': userPassword,
    //   'userAdrress': userAdrress,
    //   'userPhone': userPhone,
    //   'userAdmin': userAdmin,
    //   'restaurantId': restaurantId,
    // });
    try {
      final response =
          await dio.post('http://127.0.0.1:3000/user/createUser', data: {
        'userEmail': userEmail,
        'userPassword': userPassword,
      });
      // print('sign up');
      // final test = jsonDecode(response.toString());
      // print(test);
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('API Create User', e, st);
      throw RepositoryException(
          message: 'API Create User', exception: e, stackTrace: st);
    }
  }

  Future<void> upload({
    required ValueNotifier<File?> imageLink,
    required String category,
  }) async {
    var formdata = FormData.fromMap(
      {
        category: category,
        "image": await MultipartFile.fromFile(
          imageLink.value!.path,
        ),
      },
    );
    var response =
        await dio.post("http://127.0.0.1:3000/upload/", data: formdata);
  }

  Future<List<UserModel>> getAllUser() async {
    try {
      final response =
          await dio.get("http://127.0.0.1:3000/category/getAllCategory/");

      final List<UserModel> listUser = UsersFromJson(response.data);

      return listUser;
    } on DioError catch (e) {
      throw Exception(' failed to get category');
    }
  }

  Future<UserModel> getOneId({
    required String userId,
  }) async {
    // var formData = FormData.fromMap({
    //   'userId': userId,
    // });
    try {
      final response =
          await dio.post('http://127.0.0.1:3000/user/getone/', data: {
        'userId': userId,
      });
      // print('getOneId');
      final test = jsonDecode(response.toString());
      // print(test);
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

  Future<UserModel> addOrderingInformation({
    required String userId,
    required String userName,
    required String userPhone,
    required String userAdrress,
  }) async {
    // var formData = FormData.fromMap({
    //   'userId': userId,
    // });
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/user/addOrderingInformation/', data: {
        'userName': userName,
        'userPhone': userPhone,
        'userAdrress': userAdrress,
        'userId': userId,
      });
      // print('getOneId');
      final test = jsonDecode(response.toString());
      // print(test);
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

  Future<UserModel> getoneandupdate({
    required String? userName,
    required String? userEmail,
    required String? userPassword,
    required String? userAdrress,
    required String? userPhone,
    required String? userId,
    required String? userAdmin,
    required String? restaurantId,
  }) async {
    // var formData = FormData.fromMap({
    //   'userName': userName,
    //   'userEmail': userEmail,
    //   'userPassword': userPassword,
    //   'userAdrress': userAdrress,
    //   'userPhone': userPhone,
    //   'userAdmin': userAdmin,
    //   'restaurantId': restaurantId,
    // });
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/category/getoneandupdate/', data: {
        'userName': userName,
        'userEmail': userEmail,
        'userPassword': userPassword,
        'userAdrress': userAdrress,
        'userPhone': userPhone,
        'userAdmin': userAdmin,
        'restaurantId': restaurantId,
      });
      // print('response');
      // print(response);
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to get one and update');
    }
  }

  Future<UserModel> getOneandDelete({
    required String userId,
  }) async {
    // var formData = FormData.fromMap({
    //   'userId': userId,
    // });
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/category/getOneandDelete/', data: {
        'userId': userId,
      });

      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

// -------------------------------------------------------------

  Future<void> addFavouriteProductDetails({
    required String userId,
    required String productDetailId,
  }) async {
    // print('addFavouriteProductDetails user api service');
    // var formData = FormData.fromMap({
    //   'userId': userId,
    // });
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/user/addFavouriteProductDetail/', data: {
        'userId': userId,
        'productDetailId': productDetailId,
      });
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('API addFavouriteProductDetails', e, st);
      throw RepositoryException(
          message: 'API addFavouriteProductDetails',
          exception: e,
          stackTrace: st);
    }
  }

// -------------------------------------------------------------

  Future<void> removeFavouriteProductDetails({
    required String userId,
    required String productDetailId,
  }) async {
    // print('removeFavouriteProductDetails user api service');
    // var formData = FormData.fromMap({
    //   'userId': userId,
    // });
    try {
      final response = await dio.post(
          'http://127.0.0.1:3000/user/removeFavouriteProductDetail/',
          data: {
            'userId': userId,
            'productDetailId': productDetailId,
          });
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

  // -------------------------------------------------------------
// List<ProductDetailModel>
  Future<List<ProductDetailModel>> getFavouriteProductDetails({
    required String userId,
  }) async {
    // print('getFavouriteProductDetails');
    try {
      final responses = await dio
          .post('http://127.0.0.1:3000/user/getFavouriteProductDetail/', data: {
        'userId': userId,
      });

      final value = responses.data['favouriteProductDetails'];

      final List<ProductDetailModel> listProduct = productDetailFromJson(value);
      // print('listProduct');
      // print(listProduct);
      return listProduct;
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('API getFavouriteProductDetails', e, st);
      throw RepositoryException(
          message: 'API getFavouriteProductDetails',
          exception: e,
          stackTrace: st);
    }
  }
}

//  var formdata = FormData.fromMap(
//                   {
//                     "productName": "productName2342134",
//                     "image": await MultipartFile.fromFile(
//                       imageLink.value!.path,
//                     ),
//                   },
//                 );

//                 var dioClien = Dio();
//                 print('22');
//                 var response = await dioClien
//                     .post("http://127.0.0.1:3000/upload/", data: formdata);

//                 print(jsonDecode(response.toString()));

// required String categoryName,
//     required String categoryImage,
//     required String categoryId,
//     required bool ship,
//     required bool booking,
