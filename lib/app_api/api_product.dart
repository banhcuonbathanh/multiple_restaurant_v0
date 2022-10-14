import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:untitled1/model/product_model.dart';

import '../helper/dio_inteceptor.dart';

class APIProduct {
  final Dio dio = Dio();
  final Reader read;
  APIProduct(this.read) {
    dio.interceptors.add(DioInterceptor(read));
    print('trong APIUser check DioInterceptor');
  }
  // --------------------------------------------------------------------------
  Future<String> createFolderProductImage({
    // required String category,
    required String restaurantName,
    required String productName,
  }) async {
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/folder/createProductImage/', data: {
        // 'category': category,
        'restaurantName': restaurantName,
        'productName': productName,
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
  Future<String> uploadProductImage({
    required ValueNotifier<File?> imageLink,
    required String restaurantName,
    required String? productName,
    required String imageFoldeStore,
  }) async {
    print('uploadProductImage');
    print('imageLink.value');
    print(imageLink.value);
    print('imageFoldeStore');
    print(imageFoldeStore);
    var formdata = FormData.fromMap(
      {
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
  Future<ProductModel> createProduct({
    required String? productName,
    required String? restaurantId,
    // required String? productDescription,
    required String? productImage,
    // required String? productId,
    required double? productPriceThapNhat,
    required double? productPriceCaoNhat,
    required double? productRating,
    required bool? isFavourite,
    required bool? isPopular,
    // required bool ship,
    // required bool booking,
    required String restaurantName,
    required String folderProductImage,
  }) async {
    // var formData = FormData.fromMap({
    //   'productName': productName,
    //   // 'productDescription': productDescription,
    //   'productImage': productImage,
    //   'productId': null,
    //   'productPriceThapNhat': productPriceThapNhat,
    //   'productPriceCaoNhat': productPriceCaoNhat,
    //   'productRating': productRating,
    //   'isFavourite': isFavourite,
    //   'isPopular': isPopular,
    //   // 'ship': ship,
    //   // 'booking': booking,
    //   'restaurantName': restaurantName,
    //   'restaurantId': restaurantId,
    // });
    // print('create product api');
    // print('folderProductImage');
    // print(folderProductImage);
    try {
      final response =
          await dio.post('http://127.0.0.1:3000/product/createProduct/', data: {
        'productName': productName,
        // 'productDescription': productDescription,
        'productImage': productImage,
        'productId': null,
        'productPriceThapNhat': productPriceThapNhat,
        'productPriceCaoNhat': productPriceCaoNhat,
        'productRating': productRating,
        'isFavourite': isFavourite,
        'isPopular': isPopular,
        'restaurantId': restaurantId,
        // 'ship': ship,
        // 'booking': booking,
        'restaurantName': restaurantName,
        'folderProductImage': folderProductImage,
      });

      return ProductModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to create product');
    }
  }

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
  }

// -----------------------------------------------
  Future<List<ProductModel>> getAllProduct() async {
    try {
      final response =
          await dio.get("http://127.0.0.1:3000/product/getAllProduct/");
      // print(response);
      final List<ProductModel> listProduct = productFromJson(response.data);

      return listProduct;
    } on DioError catch (e) {
      throw Exception(' failed to get category');
    }
  }

// -----------------
  Future<void> deleteProductImage({
    required String productImage,
    required String newProductImage,
    required String productId,
  }) async {
    // var formdata = FormData.fromMap(
    //   {
    //     'restaurantImage': restaurantImage,
    //   },
    // );
    try {
      await dio.post('http://127.0.0.1:3000/folder/deleteProductImage/', data: {
        'productImage': productImage,
        'newProductImage': newProductImage,
        'productId': productId,
      });
    } on DioError catch (e) {
      throw Exception(' failed to create restaurant');
    }
  }

  // --------------------------------------------------------------------------
  Future<ProductModel> getOne({
    required String productId,
  }) async {
    // var formData = FormData.fromMap({
    //   'productId': productId,
    // });
    try {
      final response =
          await dio.post('http://127.0.0.1:3000/product/getone/', data: {
        'productId': productId,
      });

      return ProductModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

  // --------------------------------------------------------------------------
  Future<ProductModel> getoneandupdate({
    required String? productName,
    required String? restaurantId,
    // required String? productDescription,
    required String? productImage,
    required String? productId,
    required double? productPriceThapNhat,
    required double? productPriceCaoNhat,
    required double? productRating,
    required bool? isFavourite,
    required bool? isPopular,
    // required bool ship,
    // required bool booking,
    required String restaurantName,
    required String folderProductImage,
  }) async {
    // var formData = FormData.fromMap({
    //   'productName': productName,
    //   // 'productDescription': productDescription,
    //   'productImage': productImage,
    //   'productId': productId,
    //   'productPriceThapNhat': productPriceThapNhat,
    //   'productPriceCaoNhat': productPriceCaoNhat,
    //   'productRating': productRating,
    //   'isFavourite': isFavourite,
    //   'isPopular': isPopular,
    //   // 'ship': ship,
    //   // 'booking': booking,
    //   'restaurantName': restaurantName,
    // });
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/product/getoneandupdate/', data: {
        'productName': productName,
        // 'productDescription': productDescription,
        'productImage': productImage,
        'productId': productId,
        'productPriceThapNhat': productPriceThapNhat,
        'productPriceCaoNhat': productPriceCaoNhat,
        'productRating': productRating,
        'isFavourite': isFavourite,
        'isPopular': isPopular,
        // 'ship': ship,
        // 'booking': booking,
        'restaurantName': restaurantName,
        'folderProductImage': folderProductImage,
      });

      return ProductModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to get one and update');
    }
  }

  // --------------------------------------------------------------------------
  Future<List<ProductModel>> searchingProductsByRestaurantId({
    required String searchingkey,
  }) async {
    // var formData = FormData.fromMap({
    //   'searchingkey': searchingkey,
    // });
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/product/searchingProducts/', data: {
        'searchingkey': searchingkey,
      });
      // print('searchingProductsByRestaurantId');
      // print(searchingkey);
      // print(response.data);
      return productFromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to searchingProducts');
    }
  }

  // --------------------------------------------------------------------------
  Future<void> getOneandDelete(
      {required String productId, required String restaurantId}) async {
    // var formData = FormData.fromMap({
    //   'productId': productId,
    //   'restaurantId': restaurantId,
    // });
    try {
      await dio.post('http://127.0.0.1:3000/product/getOneandDelete/', data: {
        'productId': productId,
        'restaurantId': restaurantId,
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
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

  // --------------------------------------

  Future<ProductModel> getoneandupdatetopping({
    required String? productId,
    required String toppingName,
    required String toppingQuantity,
  }) async {
    try {
      final response = await dio.post(
          'http://127.0.0.1:3000/product/getProductUpdatetopping/',
          data: {
            'productId': productId,
            'toppingName': toppingName,
            'toppingQuantity': toppingQuantity,
          });

      // print('response');
      // print(response.data);
      return ProductModel.fromJson(response.data);
      // return ProductModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to get one and update');
    }
  }

// -----------------------------------------------
  Future<List<ProductModel>> searchingProductsWithNameLetter({
    required String nameLetters,
  }) async {
    try {
      final response = await dio.post(
          "http://127.0.0.1:3000/product/searchingProductsWithNameLetter/",
          data: {
            'nameLetters': nameLetters,
          });
      // print(response);
      final List<ProductModel> listProduct = productFromJson(response.data);

      return listProduct;
    } on DioError catch (e) {
      throw Exception(' failed to get category');
    }
  }
}
