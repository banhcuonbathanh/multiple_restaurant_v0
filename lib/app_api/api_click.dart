import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:untitled1/model/click_model.dart';

import '../helper/dio_inteceptor.dart';

class APIClick {
  final Dio dio = Dio();
  final Reader read;

  APIClick(this.read) {
    dio.interceptors.add(DioInterceptor(read));
    print('trong APIUser check DioInterceptor');
  }
  Future<void> createClick({
    required String clickName,
    required String clickingTiming,
    required String monitoringDay,
    required String productId,
    required String productName,
    required String restaurantId,
    required String restaurantName,
  }) async {
    try {
      final response =
          await dio.post('http://127.0.0.1:3000/click/createClick/', data: {
        'clickName': clickName,
        'clickingTiming': clickingTiming,
        'monitoringDay': monitoringDay,
        'productId': productId,
        'productName': productName,
        'restaurantId': restaurantId,
        'restaurantName': restaurantName,
      });
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

  Future<ClickModel> addTimeClick({
    required String clickName,
    required String clickingTiming,
  }) async {
    try {
      final response =
          await dio.post('http://127.0.0.1:3000/click/addTimeClick/', data: {
        'clickName': clickName,
        'clickingTiming': clickingTiming,
      });
      return ClickModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

  // ----------------------------

  Future<void> checkAvailableClick({
    required String clickName,
    required String clickingTiming,
    required String monitoringDay,
    required String productId,
    required String productName,
    required String restaurantId,
    required String restaurantName,
  }) async {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>');
    try {
      await dio.post('http://127.0.0.1:3000/click/checkAvailableClick/', data: {
        'clickName': clickName,
        'clickingTiming': clickingTiming,
        'monitoringDay': monitoringDay,
        'productId': productId,
        'productName': productName,
        'restaurantId': restaurantId,
        'restaurantName': restaurantName,
      });
      print('<<<<<<<<<<<<<<<<<<<<<<<');
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }
}


//  Future<CategoryModel> createCategory(
//       {required String categoryImage,
//       required String categoryName,
//       required String categoryId,
//       required bool ship,
//       required bool booking}) async {

//     try {
//       final response = await dio
//           .post('http://127.0.0.1:3000/category/createCategory', data: {
//         'categoryImage': categoryImage,
//         'categoryName': categoryName,
//         'categoryId': categoryId,
//         'ship': ship,
//         'booking': booking,
//       });

//       return CategoryModel.fromJson(response.data);
//     } on DioError catch (e) {
//       throw Exception(' failed to create post');
//     }
//   }