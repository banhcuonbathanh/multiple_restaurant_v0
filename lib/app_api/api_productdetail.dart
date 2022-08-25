import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/exception/repository_exception.dart';
import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/utils.dart';

class APIProductDetail {
  final Reader read;
  final Dio dio = Dio();

  APIProductDetail(this.read);

  // --------------------------------------------------------------------------
  Future<String> createFolderProductDetailImage({
    required String category,
    required String restaurantName,
    required String productName,
    required String productDetailName,
  }) async {
    // var formdata = FormData.fromMap(
    //   {
    //     'category': category,
    //     'restaurantName': restaurantName,
    //     'productName': productName,
    //     'productDetailName': productDetailName,
    //   },
    // );

    try {
      final response = await dio.post(
          'http://127.0.0.1:3000/folder/createProductDetailImage/',
          data: {
            'category': category,
            'restaurantName': restaurantName,
            'productName': productName,
            'productDetailName': productDetailName,
          });

      Map<String, dynamic> imageFolderlinkinMap =
          jsonDecode(response.toString());
      String imageFolderlinkinString = imageFolderlinkinMap['link'];

      return imageFolderlinkinString.substring(1);
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
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
  Future<ProductDetailModel> getoneandupdate({
    required String? productdetaitName,
    required String? productdetaiDescription,
    required String? productdetaiImage,
    required String? productdetaiId,
    // required String? productId,
    required double? productdetaiPrice,
    required double? productdetaiRating,
    required bool? productdetaiIsFavourite,
    required bool? productdetaiIsPopular,
    required String? productName,
    required String? productId,
    required double? productdetailQuantity,
    // required double? productDetailBill,

    required String? restaurantName,
    required String? restaurantId,
    required double? productdetailBill,
    required String? userId,

    // required String? category,
  }) async {
    // var formData = FormData.fromMap({
    //   'productdetaiId': productdetaiId,
    //   'productdetailQuantity': productdetailQuantity,
    //   'productdetailBill': productdetailBill,
    // });
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/productDetail/getoneandupdate/', data: {
        'productdetaiId': productdetaiId,
        'productdetailQuantity': productdetailQuantity,
        'productdetailBill': productdetailBill,

        'productdetaiPrice': productdetaiPrice,
        'productdetaitName': productdetaitName,

        'productdetaiDescription': productdetaiDescription,
        'productdetaiImage': productdetaiImage,
        'productId': productId,
        'productdetaiRating': productdetaiRating,
        'productdetaiIsFavourite': productdetaiIsFavourite,
        'productdetaiIsPopular': productdetaiIsPopular,
        'productName': productName,

        // 'ship': ship,
        // 'booking': booking,
        'restaurantName': restaurantName,
        'restaurantId': restaurantId,
        'userId': userId,
        // 'category': category,
      });

      // print(
      //     'getoneandupdategetoneandupdate  APIProductDetailServiceAPIProductDetailService');
      // print(productdetailQuantity);
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
