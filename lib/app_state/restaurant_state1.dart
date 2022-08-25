import 'package:dio/dio.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:untitled1/exception/repository_exception.dart';
import 'package:untitled1/model/restaurant_model.dart';
import 'package:untitled1/utils.dart';

import '../app_provider/api_provider.dart';

// List<Category>
class RestaurantState1 extends StateNotifier<List<RestaurantModel>> {
  RestaurantState1(this.read, [List<RestaurantModel>? state])
      : super(state ?? []);
  final Reader read;
  List<RestaurantModel>? previousState;
  // void addCategoryList(List<Category> newCategory) {
  //   state = [...state, ...newCategory];
  // }

  // ---------------------------------------------------------qq
  // Future<void> createRestaurant({
  //   required String? userId,
  //   required String? restaurantCategory,
  //   required String? restaurantName,
  //   required String? restaurantImage,
  //   required String? restaurantId,
  //   required String? restaurantAdrress,
  //   required String? productId,
  //   required String? productName,
  //   required List<String?>? listProductId,
  //   required double? restaurantStartTime,
  //   required double? restaurantEndingTime,
  //   required double? restaurantMealPreparation,
  //   required double? restaurantComment,
  //   required double? restaurantRating,
  //   required bool? ship,
  //   required bool? booking,
  //   required String category,
  //   required ValueNotifier<File?> imageLink,
  // }) async {
  //   getAllRestaurant();
  //   state = state.whenData((restaurants) => [
  //         ...restaurants,
  //         Restaurant(
  //           restaurantCategory: restaurantCategory,
  //           restaurantName: restaurantName,
  //           restaurantImage: restaurantImage,
  //           restaurantId: restaurantId,
  //           restaurantAdrress: restaurantAdrress,
  //           restaurantStartTime: restaurantStartTime,
  //           restaurantEndingTime: restaurantEndingTime,
  //           restaurantMealPreparation: restaurantMealPreparation,
  //           restaurantComment: restaurantComment,
  //           ship: ship,
  //           booking: booking,
  //           restaurantRating: restaurantRating,
  //           userId: userId,
  //           productId: productId,
  //           productName: productName,
  //           listProductId: listProductId,
  //         )
  //       ]);

  //   try {
  //     await read(APIServiceRestaurantProvider).createRestaurant(
  //       restaurantCategory: restaurantCategory,
  //       restaurantName: restaurantName,
  //       restaurantImage: restaurantImage,
  //       restaurantId: restaurantId,
  //       restaurantAdrress: restaurantAdrress,
  //       restaurantStartTime: restaurantStartTime,
  //       restaurantEndingTime: restaurantEndingTime,
  //       restaurantMealPreparation: restaurantMealPreparation,
  //       restaurantComment: restaurantComment,
  //       ship: ship,
  //       booking: booking,
  //       restaurantRating: restaurantRating,
  //       userId: userId,
  //     );
  //   } on CategoryException catch (e) {
  //     _handleException(e);
  //   }
  // }

// ---------------------------------------------------------
  Future<void> getAllRestaurant() async {
    try {
      final restaurants = await read(API.restaurant).getAllRestaurant();
      state = restaurants;
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

// testtesttesttesttesttesttesttesttesttesttesttest

  Future<List<RestaurantModel>> getAllRestaurant_test() async {
    List<RestaurantModel> restaurantsData = [];

    try {
      restaurantsData = await read(API.restaurant).getAllRestaurant();
      state = restaurantsData;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }

    return restaurantsData;
  }

  /// testtesttesttesttesttesttesttesttesttesttesttest
  Future<List<RestaurantModel>?> searchRestaurants(
      {required String? searchingKey}) async {
    try {
      final restaurants = await read(API.restaurant).getAllRestaurant();
      return restaurants;
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

// ---------------------------------------------------------
  Future<RestaurantModel?> searchRestaurantsUserId(
      {required String? restaurantsUserId}) async {
    try {
      final restaurant = await read(API.restaurant)
          .searchingRestaurantUserId(restaurantId: restaurantsUserId);

      return restaurant;
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

// ---------------------------------------------------------
  Future<RestaurantModel?> searchRestaurantID(
      {required String? restaurantId}) async {
    List<RestaurantModel>? check =
        state.where((element) => element.restaurantId == restaurantId).toList();
    if (check.length < 1) {
      try {
        final restaurant =
            await read(API.restaurant).getOne(restaurantId: restaurantId!);
        state.add(restaurant);
        return restaurant;
      } on DioError catch (e) {
        logger.warning(e.message, e);
        throw RepositoryException(message: e.message);
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    }
  }

// ---------------------------------------------------------
  Future<void> retryLoadingProduct() async {
    try {
      final restaurants = await read(API.restaurant).getAllRestaurant();
      state = restaurants;
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

// ---------------------------------------------------------
  Future<void> refresh() async {
    try {
      final restaurants = await read(API.restaurant).getAllRestaurant();
      state = restaurants;
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

// ---------------------------------------------------------
  Future<void> editRestaurant({
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
    _cacheState();

    // state = state.whenData((restaurants) {
    //   return [
    //     for (final restaurant in restaurants)
    //       if (restaurant.restaurantId == restaurantId)
    //         RestaurantModel(
    //           restaurantCategory: restaurantCategory,
    //           restaurantName: restaurantName,
    //           restaurantImage: restaurantImage,
    //           restaurantId: restaurantId,
    //           restaurantAdrress: restaurantAdrress,
    //           restaurantStartTime: restaurantStartTime,
    //           restaurantEndingTime: restaurantEndingTime,
    //           restaurantMealPreparation: restaurantMealPreparation,
    //           restaurantComment: restaurantComment,
    //           ship: ship,
    //           booking: booking,
    //           restaurantRating: restaurantRating,
    //           userId: userId,
    //           productId: productId,
    //           productName: productName,
    //           listProductId: listProductId,
    //         )
    //       else
    //         restaurant
    //   ];
    // });

    try {
      await read(API.restaurant).getoneandupdate(
          userId: userId,
          restaurantName: restaurantName,
          restaurantCategory: restaurantCategory,
          restaurantImage: restaurantImage,
          restaurantId: restaurantId,
          restaurantAdrress: restaurantAdrress,
          productId: productId,
          listProductId: listProductId,
          productName: productName,
          restaurantStartTime: restaurantStartTime,
          restaurantEndingTime: restaurantEndingTime,
          restaurantMealPreparation: restaurantMealPreparation,
          restaurantComment: restaurantComment,
          restaurantRating: restaurantRating,
          ship: ship,
          booking: booking,
          restaurantImageStoreFolder: restaurantImageStoreFolder);
    } on DioError catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }

    state = [
      for (final restaurant in state)
        if (restaurant.restaurantId == restaurantId)
          RestaurantModel(
              userId: userId,
              restaurantName: restaurantName,
              restaurantCategory: restaurantCategory,
              restaurantImage: restaurantImage,
              restaurantId: restaurantId,
              restaurantAdrress: restaurantAdrress,
              productId: productId,
              listProductId: listProductId,
              productName: productName,
              restaurantStartTime: restaurantStartTime,
              restaurantEndingTime: restaurantEndingTime,
              restaurantMealPreparation: restaurantMealPreparation,
              restaurantComment: restaurantComment,
              restaurantRating: restaurantRating,
              ship: ship,
              booking: booking,
              restaurantImageStoreFolder: restaurantImageStoreFolder,
              promotionList: [])
        else
          restaurant
    ];
  }

// ---------------------------------------------------------
  Future<void> deleteRestaurant(
      {required String restaurantId,
      required String restaurantImageStoreFolder}) async {
    _cacheState();
    state.where((element) => element.restaurantId != restaurantId).toList();

    try {
      await read(API.restaurant).getOneandDelete(
          restaurantId: restaurantId,
          restaurantImageStoreFolder: restaurantImageStoreFolder);
    } catch (e, st) {}
  }

// ---------------------------------------------------------
  void _cacheState() {
    previousState = state;
  }

// ---------------------------------------------------------
  // void _resetState() {
  //   if (previousState != null) {
  //     state = previousState!;
  //     previousState = null;
  //   }
  // }

  // void _handleException(CategoryException e) {
  //   _resetState();
  //   read(categoryExceptionProvider.notifier).state = e;
  // }
}
