import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/api_provider.dart';
import 'package:untitled1/exception/repository_exception.dart';

import 'package:untitled1/model/topping_model.dart';
import 'package:untitled1/utils.dart';

class ToppingEditStateMap extends StateNotifier<Map<String, ToppingModel>> {
  ToppingEditStateMap(this.read,
      // this.productId,
      [Map<String, ToppingModel>? state])
      : super({}) {
    // getProductDetailproductId();
    // getProductDetailproductId(searchingKey: productId);
    // state = AsyncValue.data([]);

    // searchingProductDetailOfRestaurantUserId(searchingKey: searchingKey);
  }
  final Reader read;
  // final String productId;
  // late List<ToppingModel> previousState;

  Future<ToppingModel?> createTopping({
    required ToppingModel toppingModel,
  }) async {
    // getAllProduct();
    Map<String, ToppingModel>? dataLocal = state;
    if (dataLocal.length < 1) {
      try {
        final toppingBackEnd =
            await read(API.topping).createTopping(toppingModel: toppingModel);

        state['${toppingBackEnd.toppingId}'] = toppingBackEnd;

        return toppingBackEnd;
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    } else {
      try {
        final toppingBackEnd =
            await read(API.topping).createTopping(toppingModel: toppingModel);

        state.putIfAbsent(toppingBackEnd.toppingId!, () => toppingBackEnd);

        return toppingBackEnd;
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    }
    // check empty state
  }

// ---------------------------------------
  Future<ToppingModel> getOneTopping({
    required String toppingId,
  }) async {
    try {
      final topping =
          await read(API.topping).getOneTopping(toppingId: toppingId);
      return topping;
      // state = products;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }
// ----testtesttesttesttesttesttesttesttesttesttesttest

// ----testtesttesttesttesttesttesttesttesttesttesttest
  Future<void> getAllTopping() async {
    try {
      await read(API.topping).getAllTopping();
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

// ----------------

  Future<void> searchingToppingWithProductId({
    required String productId,
  }) async {
    // print('searchingToppingWithProductId');

    Map<String, ToppingModel>? dataLocal = state;
    if (dataLocal.length < 1) {
      try {
        final toppings = await read(API.topping)
            .searchingToppingWithProductId(productId: productId);

        // print('toppings');
        // print(toppings);
        Map<String, ToppingModel> temporary = {};
        toppings.forEach((element) {
          temporary['${element.toppingId}'] = element;
        });
        state = temporary;
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    } else {
      try {
        final toppings = await read(API.topping)
            .searchingToppingWithProductId(productId: productId);

        for (final topping in toppings) {
          if (dataLocal.containsKey(topping.toppingId) == false) {
            dataLocal.putIfAbsent(topping.toppingId!, () => topping);
          }
        }
        state = dataLocal;
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    }
  }

  // ----------------

  Future<void> searchingToppingWithProductDetailId({
    required String productDetailId,
  }) async {
    // print('searchingToppingWithProductId');

    Map<String, ToppingModel>? dataLocal = state;
    if (dataLocal.length < 1) {
      try {
        final toppings = await read(API.topping)
            .searchingToppingWithProductDetailId(
                productDetailId: productDetailId);

        // print('toppings');
        // print(toppings);
        Map<String, ToppingModel> temporary = {};
        toppings.forEach((element) {
          temporary['${element.toppingId}'] = element;
        });
        state = temporary;
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    } else {
      try {
        final toppings = await read(API.topping)
            .searchingToppingWithProductDetailId(
                productDetailId: productDetailId);

        for (final topping in toppings) {
          if (dataLocal.containsKey(topping.toppingId) == false) {
            dataLocal.putIfAbsent(topping.toppingId!, () => topping);
          }
        }
        state = dataLocal;
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    }
  }
// ----------------
  // Future<void> searchingToppingWithProductId(
  //     {required String productId}) async {
  //   final Map<String, Map<String, ToppingModel>> dataLocal = state;

  //   try {
  //     final toppings = await read(API.topping)
  //         .searchingToppingWithProductId(productId: productId);
  //     // print('toppings');
  //     // print(toppings.length);
  //     final Map<String, ToppingModel> temporaryMapToppingModel = {};
  //     dataLocal['${productId}'] = temporaryMapToppingModel;
  //     for (final toppingServer in toppings) {
  //       if (temporaryMapToppingModel.containsKey(toppingServer.toppingName) ==
  //           false) {
  //         temporaryMapToppingModel.putIfAbsent(
  //             toppingServer.toppingName!, () => toppingServer);
  //       }
  //     }

  //     dataLocal.update(productId, (value) => temporaryMapToppingModel);
  //     state = dataLocal;
  //   } on Exception catch (e, st) {
  //     logger.severe('Repository Exception', e, st);
  //     throw RepositoryException(
  //         message: 'Repository Exception', exception: e, stackTrace: st);
  //   }
  // }
  // Future<void> retryLoadingProduct() async {
  //   state = const AsyncValue.loading();
  //   try {
  //     final products =
  //         await read(APIServiceProductDetailProvider).getAllProduct();
  //     state = AsyncValue.data(products);
  //   } on CategoryException catch (e, st) {
  //     state = AsyncValue.error(e, stackTrace: st);
  //   }
  // }

  // Future<void> refresh() async {
  //   try {
  //     final products =
  //         await read(APIServiceProductDetailProvider).getAllProduct();
  //     state = AsyncValue.data(products);
  //   } catch (e, st) {
  //     state = AsyncValue.error(e, stackTrace: st);
  //   }
  // }

  Future<void> getoneandupdate({
    required ToppingModel toppingModel,
  }) async {
    Map<String, ToppingModel>? dataLocal = state;
    dataLocal.update(
        toppingModel.toppingId!,
        (value) => value.copyWith(
            toppingName: toppingModel.toppingName,
            toppingQuantity: toppingModel.toppingQuantity));
    try {
      await read(API.topping).getoneandupdate(toppingModel: toppingModel);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }
  // Future<void> editProductDetailAdd({
  //   required String? productdetaiId,
  //   // required String? productId,
  //   required double? productdetaiPrice,
  //   required double? productdetailQuantity,
  //   // required double? productDetailBill,
  // }) async {
  //   state = [
  //     for (final productdetail in state)
  //       if (productdetail.productdetaiId == productdetaiId)
  //         productdetail.copyWith(
  //             productdetailQuantity: productdetail.productdetailQuantity! + 1,
  //             productdetailBill: (productdetail.productdetailQuantity! + 1) *
  //                 productdetaiPrice!)
  //       else
  //         productdetail
  //   ];
  // }

  // Future<void> editProductDetailRemove({
  //   required String? productdetaiId,
  //   // required String? productId,
  //   required double? productdetaiPrice,
  //   required double? productdetailQuantity,
  //   // required double? productDetailBill,

  //   // required String? category,
  // }) async {
  //   state = [
  //     for (final productdetail in state)
  //       if (productdetail.productdetaiId == productdetaiId)
  //         productdetail.copyWith(
  //             productdetailQuantity:
  //                 productdetailQuantity! > 0 ? productdetailQuantity - 1 : 0,
  //             productdetailBill:
  //                 (productdetailQuantity > 0 ? productdetailQuantity - 1 : 0) *
  //                     productdetaiPrice!)
  //       else
  //         productdetail
  //   ];
  // }

  Future<void> deleteToppingWithId({
    required String toppingId,
  }) async {
    // _cacheState();
    state.removeWhere((key, value) => key == toppingId);
    try {
      await read(API.topping).getOneandDelete(
        toppingId: toppingId,
      );
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  Future<void> deleteAllTopping({required String restaurantId}) async {
    // _cacheState();

    try {
      await read(API.topping).deleteAllTopping(restaurantId: restaurantId);

      state = {};
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  // void _cacheState() {
  //   previousState = state;
  // }

  // void _resetState() {
  //   if (previousState != null) {
  //     state = previousState;
  //     previousState = null;
  //   }
  // }

  // void _handleException(CategoryException e) {
  //   _resetState();
  //   read(categoryExceptionProvider.notifier).state = e;
  // }
}
