import 'package:dio/dio.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:untitled1/model/topping_model.dart';

import '../helper/dio_inteceptor.dart';

class APITopping {
  final Dio dio = Dio();
  final Reader read;

  APITopping(this.read) {
    dio.interceptors.add(DioInterceptor(read));
    print('trong APIUser check DioInterceptor');
  }
  // --------------------------------------------------------------------------
  // Future<String> createFolderProductImage({
  //   // required String category,
  //   required String restaurantName,
  //   required String productName,
  // }) async {
  //   // var formdata = FormData.fromMap(
  //   //   {
  //   //     // 'category': category,
  //   //     'restaurantName': restaurantName,
  //   //     'productName': productName,
  //   //   },
  //   // );
  //   try {
  //     final response = await dio
  //         .post('http://127.0.0.1:3000/folder/createProductImage/', data: {
  //       // 'category': category,
  //       'restaurantName': restaurantName,
  //       'productName': productName,
  //     });

  //     Map<String, dynamic> imageFolderlinkinMap =
  //         jsonDecode(response.toString());
  //     String imageFolderlinkinString = imageFolderlinkinMap['link'];

  //     return imageFolderlinkinString.substring(1);
  //   } on DioError catch (e) {
  //     throw Exception(' failed to create restaurant');
  //   }
  // }

  // --------------------------------------------------------------------------
  // Future<String> uploadProductImage({
  //   required ValueNotifier<File?> imageLink,
  //   required String restaurantName,
  //   required String? productName,
  //   required String imageFoldeStore,
  // }) async {
  //   var formdata = FormData.fromMap(
  //     {
  //       'restaurantName': restaurantName,
  //       'productName': productName,
  //       'imageFoldeStore': imageFoldeStore,
  //       "image": await MultipartFile.fromFile(
  //         imageLink.value!.path,
  //       ),
  //     },
  //   );
  //   var response =
  //       await dio.post("http://127.0.0.1:3000/upload/", data: formdata);

  //   var test = jsonDecode(response.toString());

  //   var location = test['imagelink'].lastIndexOf('uploads');
  //   String image =
  //       ('http://127.0.0.1:3000/' + test['imagelink'].substring(location));
  //   // print(image);
  //   return image;
  // }

  // --------------------------------------------------------------------------
  Future<ToppingModel> createTopping({
    required ToppingModel toppingModel,
  }) async {
    // print('toppingModel');
    // print(toppingModel);
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

    try {
      final response = await dio.post(
          'http://127.0.0.1:3000/topping/createToppingProductDetail/',
          data: {
            // toppingModel.toJson()
            'productId': toppingModel.productId,
            // 'productDescription': productDescription,
            'toppingName': toppingModel.toppingName,
            'toppingQuantity': toppingModel.toppingQuantity,
            'restaurantId': toppingModel.restaurantId,
            'userId': toppingModel.userId,
            'productDetailId': toppingModel.productDetailId
          });

      return ToppingModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to create product');
    }
  }

  // --------------------------------------------------------------------------

  Future<List<ToppingModel>> getAllTopping() async {
    try {
      final response =
          await dio.get("http://127.0.0.1:3000/topping/getAllTopping/");

      final List<ToppingModel> listTopping = toppingsFromJson(response.data);

      return listTopping;
    } on DioError catch (e) {
      throw Exception(' failed to get category');
    }
  }

  // --------------------------------------------------------------------------
  Future<ToppingModel> getOneTopping({
    required String toppingId,
  }) async {
    try {
      final response =
          await dio.post('http://127.0.0.1:3000/topping/getaTopping/', data: {
        'toppingId': toppingId,
      });

      return ToppingModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

  // --------------------------------------------------------------------------
  Future<ToppingModel> getoneandupdate({
    required ToppingModel toppingModel,
  }) async {
    try {
      final response = await dio.post(
          'http://127.0.0.1:3000/topping/updateTopping/',
          data: {toppingModel.toJson()});

      return ToppingModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to get one and update');
    }
  }

  // --------------------------------------------------------------------------
  Future<List<ToppingModel>> searchingToppingWithProductId({
    required String productId,
  }) async {
    try {
      final response = await dio.post(
          'http://127.0.0.1:3000/topping/searchingToppingWithProductId/',
          data: {
            'productId': productId,
          });

      return toppingsFromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to searchingProducts');
    }
  }

  // --------------------------------------------------------------------------
  Future<List<ToppingModel>> searchingToppingWithProductDetailId({
    required String productDetailId,
  }) async {
    try {
      final response = await dio.post(
          'http://127.0.0.1:3000/topping/searchingToppingWithProductDetailId/',
          data: {
            'productDetailId': productDetailId,
          });
      // print('response');
      // print(response);
      return toppingsFromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to searchingProducts');
    }
  }

  // --------------------------------------------------------------------------
  Future<void> getOneandDelete({required String toppingId}) async {
    // var formData = FormData.fromMap({
    //   'productId': productId,
    //   'restaurantId': restaurantId,
    // });
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/topping/getOneandDelete/', data: {
        'toppingId': toppingId,
      });
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

  Future<void> deleteAllTopping({
    required String restaurantId,
  }) async {
    // var formData = FormData.fromMap({
    //   'restaurantId': restaurantId,
    // });
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/topping/deleteAllTopping/', data: {
        'restaurantId': restaurantId,
      });
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }
}
