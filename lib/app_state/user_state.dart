import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/api_provider.dart';
import 'package:untitled1/app_provider/state_provider.dart';

import 'package:untitled1/exception/repository_exception.dart';
import 'package:untitled1/model/restaurant_model.dart';
import 'package:untitled1/model/user_model.dart';

import 'package:untitled1/utils.dart';

class UserState extends StateNotifier<UserModel> {
  UserState(this.read, [UserModel? state])
      : super(UserModel(
          userId: '',
          userName: ' trong super',
          userEmail: '',
          userPassword: '',
          userAdrress: '',
          userPhone: '',
          userAdmin: '',
          restaurantId: null,
          favouriteProductDetails: [],
          userStatus: null,
        ));
  final Reader read;
  UserModel? previousState;

  UserModel? user;
  Future<UserModel?> createUser({
    required String? userEmail,
    required String? userPassword,
  }) async {
    // getAllUser();
    _cacheState();

    try {
      // UserModel userFromBackend = await read(APIUserServiceProvider).createUser(
      //   userId: userId,
      //   userName: userName,
      //   userEmail: userEmail,
      //   userPassword: userPassword,
      //   userAdrress: userAdrress,
      //   userPhone: userPhone,
      //   userAdmin: userAdmin,
      //   restaurantId: restaurantId,
      // );

      UserModel userFromBackend = await read(API.user).createUser(
        userEmail: userEmail,
        userPassword: userPassword,
      );

      // user = userFromBackend;
      state = userFromBackend;

      final restaurantsData =
          await read(AppStateProvider.restaurantStateMap.notifier)
              .getAllRestaurant();
      for (final restaurant in restaurantsData) {
        final product = await read(AppStateProvider.productMapNotifier.notifier)
            .searchingProductsOfRestaurantUserId(
                searchingKey: restaurant.restaurantId!);
      }

      return userFromBackend;
    } on Exception catch (e, st) {
      logger.severe(' UserNotifier createUser', e, st);
      throw RepositoryException(
          message: ' UserNotifier createUser', exception: e, stackTrace: st);
    }
  }

  // Future<void> getAllUser() async {
  //   try {
  //     final users = await read(APIUserServiceProvider).getAllUser();
  //     state = AsyncValue.data(users);
  //   } on CategoryException catch (e, st) {
  //     state = AsyncValue.error(e, stackTrace: st);
  //   }
  // }

  // Future<List<UserModel>?> getAllUsers_return() async {
  //   try {
  //     final users = await read(APIUserServiceProvider).getAllUser();
  //     return users;
  //   } on CategoryException catch (e, st) {
  //     state = AsyncValue.error(e, stackTrace: st);
  //   }
  // }

  Future<UserModel?> searchUserSId({required String userId}) async {
    try {
      final user = await read(API.user).getOneId(userId: userId);
      state = user;

      return user;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  Future<UserModel?> addOrderingInformation({
    required String userName,
    required String userPhone,
    required String userAdrress,
  }) async {
    try {
      final user = await read(API.user).addOrderingInformation(
          userAdrress: userAdrress,
          userName: userName,
          userPhone: userPhone,
          userId: state.userId!);
      state = state.copyWith(
          userAdrress: user.userAdrress,
          userName: user.userName,
          userPhone: user.userPhone);

      return user;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  // Future<void> retryLoadingUsers({required String userId}) async {
  //   state = const AsyncValue.loading();
  //   try {
  //     final user = await read(APIUserServiceProvider).getOneId(userId: userId);
  //     state = AsyncValue.data(user);
  //   } on CategoryException catch (e, st) {
  //     state = AsyncValue.error(e, stackTrace: st);
  //   }
  // }

  // Future<void> refresh({required String userId}) async {
  //   try {
  //     final user = await read(APIUserServiceProvider).getOneId(userId: userId);
  //     state = AsyncValue.data(user);
  //   } catch (e, st) {
  //     state = AsyncValue.error(e, stackTrace: st);
  //   }
  // }

  // Future<void> editUser({
  //   required String? userName,
  //   required String? userEmail,
  //   required String? userPassword,
  //   required String? userAdrress,
  //   required String? userPhone,
  //   required String? userAdmin,
  //   required String? userId,
  //   required String? restaurantId,
  // }) async {
  //   _cacheState();
  // state = state.whenData((users) {
  //   return [
  //     for (final user in users)
  //       if (user.userId == userId)
  //         UserModel(
  //           userName: userName,
  //           userEmail: userEmail,
  //           userPassword: userPassword,
  //           userAdrress: userAdrress,
  //           userPhone: userPhone,
  //           userAdmin: userAdmin,
  //           userId: userId,
  //           restaurantId: restaurantId,
  //         )
  //       else
  //         user
  //   ];
  // });

  //   try {
  //     await read(APIUserServiceProvider).getoneandupdate(
  //       userName: userName,
  //       userEmail: userEmail,
  //       userPassword: userPassword,
  //       userAdrress: userAdrress,
  //       userPhone: userPhone,
  //       userAdmin: userAdmin,
  //       userId: userId,
  //       restaurantId: restaurantId,
  //     );
  //   } on CategoryException catch (e) {
  //     _handleException(e);
  //   }
  // }
  Future<void> removeFavouriteProductDetails({
    required String productDetailId,
  }) async {
    try {
      state.favouriteProductDetails!.remove(productDetailId);
      await read(API.user).removeFavouriteProductDetails(
        userId: state.userId!,
        productDetailId: productDetailId,
      );
    } on Exception catch (e, st) {
      logger.severe('user state singInUser_Controller', e, st);
      throw RepositoryException(
          message: 'user state singInUser_Controller',
          exception: e,
          stackTrace: st);
    }
  }

  Future<void> addFavouriteProductDetails({
    required String productDetailId,
  }) async {
    try {
      state.favouriteProductDetails!.add(productDetailId);
      await read(API.user).addFavouriteProductDetails(
        userId: state.userId!,
        productDetailId: productDetailId,
      );
    } on Exception catch (e, st) {
      logger.severe('user state singInUser_Controller', e, st);
      throw RepositoryException(
          message: 'user state singInUser_Controller',
          exception: e,
          stackTrace: st);
    }
  }

  Future<void> deleteRestaurant({required String userId}) async {
    // _cacheState();
    // state = state.whenData(
    //   (value) => value.where((element) => element.userId != userId).toList(),
    // );
    // try {
    //   await read(APIUserServiceProvider).getOneandDelete(userId: userId);
    // } catch (e, st) {
    //   state = AsyncValue.error(e, stackTrace: st);
    // }
  }

  Future<UserModel?> singIn_Controller({
    required String? userEmail,
    required String? userPassword,
  }) async {
    List<RestaurantModel> restaurantsData = [];
    List<RestaurantModel> restaurantsDataPromotion = [];

    try {
      // state = const AsyncValue.loading();
      final getallCategory =
          await read(AppStateProvider.categoriesNotifier.notifier)
              .getAllCategories();
      final userFromBackend = await read(API.user)
          .signIn(userEmail: userEmail, userPassword: userPassword);
      final orderTest = await read(AppStateProvider.orderTestNotifier.notifier)
          .searchingorderByBuyingUserId(
        BuyingUserId: userFromBackend.userId!,
        numberOfOrder: 0,
        page: 0,
        statusOrder: 'dat hang',
      );

      restaurantsData = await read(AppStateProvider.restaurantStateMap.notifier)
          .searchingRestaurantswithCategory_Page(
              categoryName: 'Đồ Ăn', page: 0, numberOfRestaurant: 0);
      // -------------------------
      // restaurantsData = await read(AppStateProvider.restaurantNotifier.notifier)
      //     .getAllRestaurant_test();
      // -------------------------
      for (final restaurant in restaurantsData) {
        await read(AppStateProvider.productMapNotifier.notifier)
            .searchingProductsOfRestaurantUserId(
                searchingKey: restaurant.restaurantId!);
      }
      // ---------------------

      restaurantsDataPromotion =
          await read(AppStateProvider.restaurantStateMap.notifier)
              .searchingRestaurantPromotion(numberOfRestaurant: 0, page: 0);

      for (final restaurant in restaurantsDataPromotion) {
        await read(AppStateProvider.productMapNotifier.notifier)
            .searchingProductsOfRestaurantUserId(
                searchingKey: restaurant.restaurantId!);
      }
      //----------------------

      state = userFromBackend;
      // read(Utility.isLoading.notifier).isLoading(isLoading: false);
      return userFromBackend;
    } on Exception catch (e, st) {
      logger.severe('user state singInUser_Controller', e, st);
      throw RepositoryException(
          message: 'user state singInUser_Controller',
          exception: e,
          stackTrace: st);
    }
  }

  void _cacheState() {
    previousState = state;
  }

  void _resetState() {
    if (previousState != null) {
      state = previousState!;
      previousState = null;
    }
  }

  // void _handleException(CategoryException e) {
  //   _resetState();
  //   read(categoryExceptionProvider.notifier).state = e;
  // }

// ------------------------------------------------------
  Future<UserModel?> singInUser({
    required String? userName,
    required String? userEmail,
    required String? userPassword,
    required String? userAdrress,
    required String? userPhone,
    required String? userAdmin,
    required String? userId,
    required String? restaurantId,
  }) async {
    // getAllUser();
    // state = state.whenData((users) => [
    //       ...users,
    //       UserModel(
    //         userName: userName,
    //         userEmail: userEmail,
    //         userPassword: userPassword,
    //         userAdrress: userAdrress,
    //         userPhone: userPhone,
    //         userAdmin: userAdmin,
    //         userId: userId,
    //       )
    //     ]);

    //   try {
    //     final userFromBackend = await read(APIUserServiceProvider).signInUser(
    //       userName: userName,
    //       userEmail: userEmail,
    //       userPassword: userPassword,
    //       userAdrress: userAdrress,
    //       userPhone: userPhone,
    //       userAdmin: userAdmin,
    //       restaurantId: restaurantId,
    //     );
    //     state = AsyncValue.data(userFromBackend);

    //     return userFromBackend;
    //   } on CategoryException catch (e) {
    //     _handleException(e);
    //   }
    // }

    // ------------------------------------------------------
  }
}
