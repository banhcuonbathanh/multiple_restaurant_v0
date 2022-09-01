import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';

import 'package:untitled1/exception/repository_exception.dart';
import 'package:untitled1/model/restaurant_model.dart';
import 'package:untitled1/utils.dart';

import '../app_provider/api_provider.dart';

// List<Category>
class RestaurantStateMap extends StateNotifier<Map<String, RestaurantModel>> {
  RestaurantStateMap(this.read, Map<String, RestaurantModel>? state)
      : super(state ?? const {});
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
  Future<List<RestaurantModel>> searchingRestaurantswithCategory_Page(
      {required String categoryName,
      required int page,
      required int numberOfRestaurant}) async {
    // print('ProductDetailMapState addItem');
    Map<String, RestaurantModel>? dataLocal = state;
    if (dataLocal.length < 1) {
      // print('state.value == null');
      try {
        final restaurantsServer = await read(API.restaurant)
            .searchingRestaurantswithCategory_Page(
                categoryName: categoryName,
                page: page,
                numberOfRestaurant: numberOfRestaurant);
        Map<String, RestaurantModel> temporary = {};
        restaurantsServer.forEach((element) {
          temporary['${element.restaurantId}'] = element;
        });
        state = temporary;
        return restaurantsServer;
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    } else {
      // print('state.value !!!!!= null');

      try {
        final restaurantsServer = await read(API.restaurant)
            .searchingRestaurantswithCategory_Page(
                categoryName: categoryName,
                page: page,
                numberOfRestaurant: numberOfRestaurant);
        for (final restaurant in restaurantsServer) {
          dataLocal.putIfAbsent(restaurant.restaurantId!, () => restaurant);
        }

        state = dataLocal;
        return restaurantsServer;
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    }
  }
// ---------------------------------------------------------

  Future<List<RestaurantModel>> controllGetLoadingData(
      {required String categoryName,
      required int page,
      required int numberOfRestaurant}) async {
    Map<String, RestaurantModel>? dataLocal = state;
    try {
      final restaurantsServer = await searchingRestaurantswithCategory_Page(
          categoryName: categoryName,
          page: page,
          numberOfRestaurant: numberOfRestaurant);
      // print('controllGetLoadingData');
      // print(test);
      if (restaurantsServer.length < 1) {
        return [];
      } else {
        for (final restaurant in restaurantsServer) {
          dataLocal.putIfAbsent(restaurant.restaurantId!, () => restaurant);

          // print('restaurant.restaurantId');
          // print(restaurant.restaurantId);

          await read(AppStateProvider.productMapNotifier.notifier)
              .searchingProductsOfRestaurantUserId(
                  searchingKey: restaurant.restaurantId!);
        }
        state = dataLocal;
        return restaurantsServer;
      }
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
    ;
  }

// ---------------------------------------------------------
  Future<List<RestaurantModel>> getAllRestaurant() async {
    Map<String, RestaurantModel>? dataLocal = state;
    if (dataLocal.length < 1) {
      // print('state.value == null');
      try {
        final restaurantsServer = await read(API.restaurant).getAllRestaurant();
        Map<String, RestaurantModel> temporary = {};
        restaurantsServer.forEach((element) {
          temporary['${element.restaurantId}'] = element;
        });
        state = temporary;
        return restaurantsServer;
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    } else {
      // print('state.value !!!!!= null');

      try {
        final restaurantsServer = await read(API.restaurant).getAllRestaurant();
        for (final restaurant in restaurantsServer) {
          dataLocal.putIfAbsent(restaurant.restaurantId!, () => restaurant);
        }
        return restaurantsServer;
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    }
  }

// ---------------------------------------------------------
  Future<List<RestaurantModel>> searchingRestaurantPromotion(
      {required int page, required int numberOfRestaurant}) async {
    Map<String, RestaurantModel>? dataLocal = state;
    if (dataLocal.length < 1) {
      // print('state.value == null');
      try {
        final restaurantsServer = await read(API.restaurant)
            .searchingRestaurantPromotion(
                numberOfRestaurant: numberOfRestaurant, page: page);
        Map<String, RestaurantModel> temporary = {};
        restaurantsServer.forEach((element) {
          temporary['${element.restaurantId}'] = element;
        });
        state = temporary;
        return restaurantsServer;
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    } else {
      // print('state.value !!!!!= null');

      try {
        final restaurantsServer = await read(API.restaurant)
            .searchingRestaurantPromotion(
                numberOfRestaurant: numberOfRestaurant, page: page);
        for (final restaurant in restaurantsServer) {
          dataLocal.putIfAbsent(restaurant.restaurantId!, () => restaurant);
        }
        return restaurantsServer;
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    }
  }
// -----------------------------

  Future<RestaurantModel?> searchRestaurantID(
      {required String? restaurantId}) async {
    Map<String, RestaurantModel>? dataLocal = state;
    try {
      final restaurantsServer =
          await read(API.restaurant).getOne(restaurantId: restaurantId!);

      dataLocal.putIfAbsent(
          restaurantsServer.restaurantId!, () => restaurantsServer);
      state = dataLocal;
      return restaurantsServer;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

// --------------------------------

// ---------------------------------------------------------
  Future<List<RestaurantModel>> searchingRestaurantWithNameLetter({
    required String nameLetters,
  }) async {
    Map<String, RestaurantModel>? dataLocal = state;
    if (dataLocal.length < 1) {
      // print('state.value == null');
      try {
        final restaurantsServer = await read(API.restaurant)
            .searchingRestaurantWithNameLetter(nameLetters: '');
        Map<String, RestaurantModel> temporary = {};
        restaurantsServer.forEach((element) {
          temporary['${element.restaurantId}'] = element;
        });
        state = temporary;
        return restaurantsServer;
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    } else {
      // print('state.value !!!!!= null');

      try {
        final restaurantsServer = await read(API.restaurant)
            .searchingRestaurantWithNameLetter(nameLetters: '');
        for (final restaurant in restaurantsServer) {
          dataLocal.putIfAbsent(restaurant.restaurantId!, () => restaurant);
        }
        return restaurantsServer;
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    }
  }
// testtesttesttesttesttesttesttesttesttesttesttest

  // Future<List<RestaurantModel>> getAllRestaurant_test() async {
  //   List<RestaurantModel> restaurantsData = [];
  //   print('getAllRestaurant_test restaurant state');
  //   try {
  //     restaurantsData = await read(API.restaurant).getAllRestaurant();
  //     state = restaurantsData;
  //   } on Exception catch (e, st) {
  //     logger.severe('Repository Exception', e, st);
  //     throw RepositoryException(
  //         message: 'Repository Exception', exception: e, stackTrace: st);
  //   }

  //   return restaurantsData;
  // }

  /// testtesttesttesttesttesttesttesttesttesttesttest
  // Future<List<RestaurantModel>?> searchRestaurants(
  //     {required String? searchingKey}) async {
  //   try {
  //     final restaurants = await read(API.restaurant).getAllRestaurant();
  //     return restaurants;
  //   } on DioError catch (e) {
  //     logger.warning(e.message, e);
  //     throw RepositoryException(message: e.message);
  //   } on Exception catch (e, st) {
  //     logger.severe('Repository Exception', e, st);
  //     throw RepositoryException(
  //         message: 'Repository Exception', exception: e, stackTrace: st);
  //   }
  // }

// ---------------------------------------------------------
  // Future<RestaurantModel?> searchRestaurantsUserId(
  //     {required String? RestaurantsUserId}) async {
  //   try {
  //     final restaurant = await read(API.restaurant)
  //         .searchingRestaurantUserId(searchingkey: RestaurantsUserId);

  //     return restaurant;
  //   } on DioError catch (e) {
  //     logger.warning(e.message, e);
  //     throw RepositoryException(message: e.message);
  //   } on Exception catch (e, st) {
  //     logger.severe('Repository Exception', e, st);
  //     throw RepositoryException(
  //         message: 'Repository Exception', exception: e, stackTrace: st);
  //   }
  // }

// ---------------------------------------------------------
  // Future<RestaurantModel?> searchRestaurantID(
  //     {required String? restaurantId}) async {
  //   List<RestaurantModel>? check =
  //       state.where((element) => element.restaurantId == restaurantId).toList();
  //   if (check.length < 1) {
  //     try {
  //       final restaurant =
  //           await read(API.restaurant).getOne(restaurantId: restaurantId!);
  //       state.add(restaurant);
  //       return restaurant;
  //     } on DioError catch (e) {
  //       logger.warning(e.message, e);
  //       throw RepositoryException(message: e.message);
  //     } on Exception catch (e, st) {
  //       logger.severe('Repository Exception', e, st);
  //       throw RepositoryException(
  //           message: 'Repository Exception', exception: e, stackTrace: st);
  //     }
  //   }
  // }

// ---------------------------------------------------------
  // Future<void> retryLoadingProduct() async {
  //   try {
  //     final restaurants = await read(API.restaurant).getAllRestaurant();
  //     state = restaurants;
  //   } on DioError catch (e) {
  //     logger.warning(e.message, e);
  //     throw RepositoryException(message: e.message);
  //   } on Exception catch (e, st) {
  //     logger.severe('Repository Exception', e, st);
  //     throw RepositoryException(
  //         message: 'Repository Exception', exception: e, stackTrace: st);
  //   }
  // }

// ---------------------------------------------------------
  // Future<void> refresh() async {
  //   try {
  //     final restaurants = await read(API.restaurant).getAllRestaurant();
  //     state = restaurants;
  //   } on DioError catch (e) {
  //     logger.warning(e.message, e);
  //     throw RepositoryException(message: e.message);
  //   } on Exception catch (e, st) {
  //     logger.severe('Repository Exception', e, st);
  //     throw RepositoryException(
  //         message: 'Repository Exception', exception: e, stackTrace: st);
  //   }
  // }

// ---------------------------------------------------------
  // Future<void> editRestaurant({
  //   required String? userId,
  //   required String? restaurantCategory,
  //   required String? restaurantName,
  //   required String? restaurantImage,
  //   required String? restaurantId,
  //   required String? restaurantAdrress,
  //   required String? productId,
  //   required String? productName,
  //   required double? restaurantStartTime,
  //   required double? restaurantEndingTime,
  //   required double? restaurantMealPreparation,
  //   required double? restaurantComment,
  //   required double? restaurantRating,
  //   required bool? ship,
  //   required bool? booking,
  //   required List<String?>? listProductId,
  //   required String? restaurantImageStoreFolder,
  // }) async {
  //   _cacheState();

  //   // state = state.whenData((restaurants) {
  //   //   return [
  //   //     for (final restaurant in restaurants)
  //   //       if (restaurant.restaurantId == restaurantId)
  //   //         RestaurantModel(
  //   //           restaurantCategory: restaurantCategory,
  //   //           restaurantName: restaurantName,
  //   //           restaurantImage: restaurantImage,
  //   //           restaurantId: restaurantId,
  //   //           restaurantAdrress: restaurantAdrress,
  //   //           restaurantStartTime: restaurantStartTime,
  //   //           restaurantEndingTime: restaurantEndingTime,
  //   //           restaurantMealPreparation: restaurantMealPreparation,
  //   //           restaurantComment: restaurantComment,
  //   //           ship: ship,
  //   //           booking: booking,
  //   //           restaurantRating: restaurantRating,
  //   //           userId: userId,
  //   //           productId: productId,
  //   //           productName: productName,
  //   //           listProductId: listProductId,
  //   //         )
  //   //       else
  //   //         restaurant
  //   //   ];
  //   // });

  //   try {
  //     await read(API.restaurant).getoneandupdate(
  //         userId: userId,
  //         restaurantName: restaurantName,
  //         restaurantCategory: restaurantCategory,
  //         restaurantImage: restaurantImage,
  //         restaurantId: restaurantId,
  //         restaurantAdrress: restaurantAdrress,
  //         productId: productId,
  //         listProductId: listProductId,
  //         productName: productName,
  //         restaurantStartTime: restaurantStartTime,
  //         restaurantEndingTime: restaurantEndingTime,
  //         restaurantMealPreparation: restaurantMealPreparation,
  //         restaurantComment: restaurantComment,
  //         restaurantRating: restaurantRating,
  //         ship: ship,
  //         booking: booking,
  //         restaurantImageStoreFolder: restaurantImageStoreFolder);
  //   } on DioError catch (e) {
  //     logger.warning(e.message, e);
  //     throw RepositoryException(message: e.message);
  //   } on Exception catch (e, st) {
  //     logger.severe('Repository Exception', e, st);
  //     throw RepositoryException(
  //         message: 'Repository Exception', exception: e, stackTrace: st);
  //   }

  //   state = [
  //     for (final restaurant in state)
  //       if (restaurant.restaurantId == restaurantId)
  //         RestaurantModel(
  //             userId: userId,
  //             restaurantName: restaurantName,
  //             restaurantCategory: restaurantCategory,
  //             restaurantImage: restaurantImage,
  //             restaurantId: restaurantId,
  //             restaurantAdrress: restaurantAdrress,
  //             productId: productId,
  //             listProductId: listProductId,
  //             productName: productName,
  //             restaurantStartTime: restaurantStartTime,
  //             restaurantEndingTime: restaurantEndingTime,
  //             restaurantMealPreparation: restaurantMealPreparation,
  //             restaurantComment: restaurantComment,
  //             restaurantRating: restaurantRating,
  //             ship: ship,
  //             booking: booking,
  //             restaurantImageStoreFolder: restaurantImageStoreFolder)
  //       else
  //         restaurant
  //   ];
  // }

// ---------------------------------------------------------
  // Future<void> deleteRestaurant(
  //     {required String restaurantId,
  //     required String restaurantImageStoreFolder}) async {
  //   _cacheState();
  //   state.where((element) => element.restaurantId != restaurantId).toList();

  //   try {
  //     await read(API.restaurant).getOneandDelete(
  //         restaurantId: restaurantId,
  //         restaurantImageStoreFolder: restaurantImageStoreFolder);
  //   } catch (e, st) {}
  // }

// ---------------------------------------------------------
  // void _cacheState() {
  //   previousState = state;
  // }

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
