import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/api_provider.dart';
import 'package:untitled1/exception/repository_exception.dart';
import 'package:untitled1/model/restaurant_model.dart';
import 'package:untitled1/utils.dart';

// List<Category>
class RestaurantEditState extends StateNotifier<RestaurantModel?> {
  RestaurantEditState(this.read, [RestaurantModel? state]) : super(null) {
    // searchRestaurantsUserId();
    // getAllRestaurant();
  }
  final Reader read;
  RestaurantModel? previousState;
  // void addCategoryList(List<Category> newCategory) {
  //   state = [...state, ...newCategory];
  // }

  // ---------------------------------------------------------
  Future<void> createRestaurant({
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
    // getAllRestaurant();
    // state = state.whenData((restaurants) => [
    //       ...restaurants,
    //       Restaurant(
    //         restaurantCategory: restaurantCategory,
    //         restaurantName: restaurantName,
    //         restaurantImage: restaurantImage,
    //         restaurantId: restaurantId,
    //         restaurantAdrress: restaurantAdrress,
    //         restaurantStartTime: restaurantStartTime,
    //         restaurantEndingTime: restaurantEndingTime,
    //         restaurantMealPreparation: restaurantMealPreparation,
    //         restaurantComment: restaurantComment,
    //         ship: ship,
    //         booking: booking,
    //         restaurantRating: restaurantRating,
    //         userId: userId,
    //       )
    //     ]);

    try {
      final restaurantData = await read(API.restaurant).createRestaurant(
        restaurantCategory: restaurantCategory,
        restaurantName: restaurantName,
        restaurantImage: restaurantImage,
        restaurantId: restaurantId,
        restaurantAdrress: restaurantAdrress,
        restaurantStartTime: restaurantStartTime,
        restaurantEndingTime: restaurantEndingTime,
        restaurantMealPreparation: restaurantMealPreparation,
        restaurantComment: restaurantComment,
        ship: ship,
        booking: booking,
        restaurantRating: restaurantRating,
        userId: userId,
        restaurantImageStoreFolder: restaurantImageStoreFolder,
      );
      state = restaurantData;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

// ---------------------------------------------------------
  // Future<void> getAllRestaurant() async {
  //   try {
  //     final restaurants =
  //         await read(APIServiceRestaurantProvider).getAllRestaurant();
  //     state = AsyncValue.data(restaurants);
  //   } on CategoryException catch (e, st) {
  //     state = AsyncValue.error(e, stackTrace: st);
  //   }
  // }

// ---------------------------------------------------------
  // Future<List<Restaurant>?> searchRestaurants(
  //     {required String? searchingKey}) async {
  //   try {
  //     final restaurants =
  //         await read(APIServiceRestaurantProvider).getAllRestaurant();
  //     return restaurants;
  //   } on CategoryException catch (e, st) {
  //     state = AsyncValue.error(e, stackTrace: st);
  //   }
  // }

// ---------------------------------------------------------
  Future<RestaurantModel?> searchRestaurantsUserId(
      {required String restaurantId}) async {
    try {
      // final user = read(UserProvider);
      // print('user!.restaurantId');
      // print(user!.restaurantId);
      final restaurant = await read(API.restaurant)
          .searchingRestaurantUserId(restaurantId: restaurantId);
      state = restaurant;

      return restaurant;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

//----------------------------------------------------
  Future<RestaurantModel> searchRestaurantsRestaurantId(
      {required String restaurantId}) async {
    try {
      // final user = read(UserProvider);
      // print('user!.restaurantId');
      // print(user!.restaurantId);
      final restaurant = await read(API.restaurant)
          .searchingRestaurantUserId(restaurantId: restaurantId);

      return restaurant;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

// ---------------------------------------------------------
  Future<void> retryLoadingProduct({required String? restaurantsUserId}) async {
    try {
      final restaurant = await read(API.restaurant)
          .searchingRestaurantUserId(restaurantId: restaurantsUserId);
      state = restaurant;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

// ---------------------------------------------------------
  Future<void> refresh({required String? restaurantsUserId}) async {
    try {
      final restaurant = await read(API.restaurant)
          .searchingRestaurantUserId(restaurantId: restaurantsUserId);
      state = restaurant;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

// ---------------------------------------------------------
  Future<void> getoneandupdate({
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
    required List<String?>? listProductId,
    required String? productId,
    required String? productName,
  }) async {
    // _cacheState();
    // state = state.whenData((restaurants) {
    //   return [
    //     for (final restaurant in restaurants)
    //       if (restaurant.restaurantId == restaurantId)
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
    //         )
    //       else
    //         restaurant
    //   ];
    // });

    try {
      await read(API.restaurant).getoneandupdate(
        restaurantCategory: restaurantCategory,
        restaurantName: restaurantName,
        restaurantImage: restaurantImage,
        restaurantId: restaurantId,
        restaurantAdrress: restaurantAdrress,
        restaurantStartTime: restaurantStartTime,
        restaurantEndingTime: restaurantEndingTime,
        restaurantMealPreparation: restaurantMealPreparation,
        restaurantComment: restaurantComment,
        ship: ship,
        booking: booking,
        restaurantRating: restaurantRating,
        restaurantImageStoreFolder: restaurantImageStoreFolder,
        listProductId: listProductId,
        productId: productId,
        productName: productName,
        userId: userId,
      );
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

// ---------------------------------------------------------
  Future<void> deleteRestaurant(
      {required String restaurantId,
      required String restaurantImageStoreFolder}) async {
    // _cacheState();

    try {
      await read(API.restaurant).getOneandDelete(
          restaurantId: restaurantId,
          restaurantImageStoreFolder: restaurantImageStoreFolder);
      state = null;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

//-----------------------------------------------------------

  Future<void> deleteRestaurantImage(
      {required String restaurantImage,
      required String newRestaurantImage,
      required String restaurantId}) async {
    try {
      await read(API.restaurant).deleteRestaurantImage(
          restaurantImage: restaurantImage,
          newRestaurantImage: newRestaurantImage,
          restaurantId: restaurantId);
      state = state!.copyWith(restaurantImage: newRestaurantImage);

      // print('state');
      // print(state!.restaurantImage!);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }
// ---------------------------------------------------------
  // void _cacheState() {
  //   previousState = state as AsyncValue<Restaurant>?;
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
