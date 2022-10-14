import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/helper/dio_inteceptor.dart';
import 'package:untitled1/model/category_model.dart';

class APICategory {
  final Reader read;
  final Dio dio = Dio();
  APICategory(this.read) {
    dio.interceptors.add(DioInterceptor(read));
  }
  Future<CategoryModel> createCategory(
      {required String categoryImage,
      required String categoryName,
      required String categoryId,
      required bool ship,
      required bool booking}) async {
    // var formData = FormData.fromMap({
    //   'categoryImage': categoryImage,
    //   'categoryName': categoryName,
    //   'categoryId': categoryId,
    //   'ship': ship,
    //   'booking': booking,
    // });
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/category/createCategory', data: {
        'categoryImage': categoryImage,
        'categoryName': categoryName,
        'categoryId': categoryId,
        'ship': ship,
        'booking': booking,
      });

      return CategoryModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

  Future<void> upload({
    required ValueNotifier<File?> imageLink,
    required String category,
  }) async {
    // var formdata = FormData.fromMap(
    //   {
    //     category: category,
    //     "image": await MultipartFile.fromFile(
    //       imageLink.value!.path,
    //     ),
    //   },
    // );
    // var response =
    //     await dio.post("http://127.0.0.1:3000/upload/", data: formdata);

    // print(jsonDecode(response.toString()));
  }

  Future<List<CategoryModel>> getAllCategory() async {
    try {
      final response =
          await dio.get("http://127.0.0.1:3000/category/getAllCategory/");

      final List<CategoryModel> listcategory =
          categoriesFromJson(response.data);

      return listcategory;
    } on DioError catch (e) {
      throw Exception(' failed to get category');
    }
  }

  Future<CategoryModel> getOne({
    required String categoryId,
  }) async {
    // var formData = FormData.fromMap({
    //   'categoryId': categoryId,
    // });
    try {
      final response =
          await dio.post('http://127.0.0.1:3000/category/getone/', data: {
        'categoryId': categoryId,
      });

      return CategoryModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }

  Future<CategoryModel> getoneandupdate(
      {required String categoryImage,
      required String categoryName,
      required String categoryId,
      required bool ship,
      required bool booking}) async {
    // var formData = FormData.fromMap({
    //   'categoryImage': categoryImage,
    //   'categoryName': categoryName,
    //   'categoryId': categoryId,
    //   'ship': ship,
    //   'booking': booking,
    // });
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/category/getoneandupdate/', data: {
        'categoryImage': categoryImage,
        'categoryName': categoryName,
        'categoryId': categoryId,
        'ship': ship,
        'booking': booking,
      });

      return CategoryModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to get one and update');
    }
  }

  Future<CategoryModel> getOneandDelete({
    required String categoryId,
  }) async {
    // var formData = FormData.fromMap({
    //   'categoryId': categoryId,
    // });
    try {
      final response = await dio
          .post('http://127.0.0.1:3000/category/getOneandDelete/', data: {
        'categoryId': categoryId,
      });

      return CategoryModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(' failed to create post');
    }
  }
}
