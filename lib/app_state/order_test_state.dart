import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/exception/repository_exception.dart';
import 'package:untitled1/model/order_model.dart';

import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/model/topping_model.dart';
import 'package:untitled1/utils.dart';

import '../app_provider/api_provider.dart';

// List<Category>
class OrderTestState extends StateNotifier<Map<String, OrderModel>> {
  OrderTestState(this.read, [Map<String, OrderModel>? state])
      : super(state ?? const {}) {
    print(' super function trong ProductNotifier');
    // getAllProduct();
  }
  final Reader read;
  // List<OrderModel>? previousState;
  // void addCategoryList(List<Category> newCategory) {
  //   state = [...state, ...newCategory];
  // }
  Future<OrderModel> createOrderTest({
    required String restaurantName,
    required String BuyingUserName,
    required String address,
    required String BuyingUserId,
    required String ProductId,
    required String restaurantId,
    required List<ProductDetailModel> productdetailsList,
    required List<ToppingModel> toppingsList,
    required String day,
    required String hour,
    required String minute,
    required String restaurantOnwnerId,
  }) async {
    // getAllProduct();

    // OrderModel? serverproduct;
    Map<String, OrderModel> dataLocal = state;
    Map<String, OrderModel> tem = {};
    try {
      final response1 = await read(API.orderTest).createOrderTest(
        BuyingUserId: BuyingUserId,
        ProductId: ProductId,
        address: address,
        restaurantId: restaurantId,
        day: day,
        hour: hour,
        minute: minute,
        restaurantOnwnerId: restaurantOnwnerId,
        productdetailsList: productdetailsList,
        toppingsList: toppingsList,
        BuyingUserName: BuyingUserName,
        restaurantName: restaurantName,
      );

      if (dataLocal.length < 1) {
        tem['${response1.orderId}'] = response1;
        state = tem;
      } else {
        dataLocal.putIfAbsent(response1.orderId, () => response1);
        state = dataLocal;
        print(state);
      }
      // print('state');
      // print(state);
      return response1;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  // -----------------------------------------------------------
  Future<OrderModel> getOneOrderById({
    required String orderId,
  }) async {
    Map<String, OrderModel> dataLocal = state;
    try {
      final serverOrder =
          await read(API.order).getOneOrderById(orderId: orderId);
      if (dataLocal.length <= 1) {
        state = dataLocal;
      } else {
        dataLocal.putIfAbsent(serverOrder.orderId, () => serverOrder);
      }

      state = dataLocal;
      return serverOrder;
      // print('state order state');
      // print(state);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  // -----------------------------------------------------------
  Future<List<OrderModel>> searchingorderByBuyingUserId({
    required String BuyingUserId,
    required String statusOrder,
    required int page,
    required int numberOfOrder,
  }) async {
    Map<String, OrderModel> dataLocal = state;
    try {
      final serverOrders = await read(API.orderTest)
          .searchingorderByBuyingUserId(
              BuyingUserId: BuyingUserId,
              numberOfOrder: numberOfOrder,
              page: page,
              statusOrder: statusOrder);

      if (dataLocal.length < 1) {
        Map<String, OrderModel> temporary = {};
        serverOrders.forEach((element) {
          temporary['${element.orderId}'] = element;
        });
        state = temporary;
      } else {
        for (final serverOrder in serverOrders) {
          dataLocal.putIfAbsent(serverOrder.orderId, () => serverOrder);
          state = dataLocal;
        }
      }

      return serverOrders;
      // print('state order state');
      // print(state);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  // -----------------------------------------------------------
  Future<List<OrderModel>> searchingorderByRangeOfDate(
      {required String fromDate,
      required String toDate,
      required String restaurantOnwnerId}) async {
    Map<String, OrderModel> dataLocal = state;
    try {
      final serverOrders =
          await read(API.orderTest).searchingorderByRangeOfDate(
        fromDate: fromDate,
        toDate: toDate,
        restaurantOnwnerId: restaurantOnwnerId,
      );

      if (dataLocal.length < 1) {
        Map<String, OrderModel> temporary = {};
        serverOrders.forEach((element) {
          temporary['${element.orderId}'] = element;
        });
        state = temporary;
      } else {
        for (final serverOrder in serverOrders) {
          dataLocal.putIfAbsent(serverOrder.orderId, () => serverOrder);
          state = dataLocal;
        }
      }

      return serverOrders;
      // print('state order state');
      // print(state);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  // -----------------------------------------------------------
  Future<List<OrderModel>> getAllProduct() async {
    // print('getAllProduct');
    Map<String, OrderModel> dataLocal = state;
    Map<String, OrderModel> tem = {};
    try {
      final serverOrders = await read(API.order).getAllOrder();

      if (dataLocal.length <= 1) {
        for (final serverOrder in serverOrders) {
          tem['${serverOrder.orderId}'] = serverOrder;

          // dataLocal.putIfAbsent(serverOrder.orderId, () => serverOrder);
        }
        state = tem;
      } else {
        for (final serverOrder in serverOrders) {
          dataLocal.putIfAbsent(serverOrder.orderId, () => serverOrder);
        }
        state = dataLocal;
      }

      // print('statestatestatestatestatestate');
      // print(state);
      return serverOrders;
      // state = products;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  // -----------------------------------------------------------
  Future<void> getOneandDeleteByOrderId({
    required String orderId,
  }) async {
    try {
      await read(API.order).getOneandDeleteByOrderId(orderId: orderId);

      // state = products;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }
  // -----------------------------------------------------------

  // Future<void> refresh() async {
  //   try {
  //     final products = await read(API.product).getAllProduct();
  //     state = AsyncValue.data(products);
  //   } catch (e, st) {
  //     state = AsyncValue.error(e, stackTrace: st);
  //   }
  // }

  // Future<void> editProduct({
  //   required String productName,
  //   required String productImage,
  //   // required String productDescription,

  //   required String productId,
  //   required double productPriceThapNhat,
  //   required double productPriceCaoNhat,
  //   required double productRating,
  //   required bool isFavourite,
  //   required bool isPopular,
  //   required bool ship,
  //   required bool booking,
  //   required String restaurantName,
  //   required String restaurantId,
  //   required List<String> productdetailIdList,
  //   required String folderProductImage,
  // }) async {
  // _cacheState();

  // state = [
  //   for (final product in state)
  //     if (product.productId == productId)
  //       ProductModel(
  //         productName: productName,
  //         productImage: productImage,
  //         productId: productId,
  //         productPriceThapNhat: productPriceThapNhat,
  //         productPriceCaoNhat: productPriceCaoNhat,
  //         productRating: productRating,
  //         isFavourite: isFavourite,
  //         isPopular: isPopular,
  //         restaurantName: restaurantName,
  //         restaurantId: restaurantId,
  //         productdetailIdList: productdetailIdList,
  //         toppingList: [],
  //         folderProductImage: folderProductImage,
  //       )
  //     else
  //       product
  // ];
  // state = state.whenData((products) {
  //   return [
  //     for (final product in products)
  //       if (product.productId == productId)
  //         ProductModel(
  //             productName: productName,
  //             // productDescription: productDescription,
  //             productImage: productImage,
  //             productId: productId,
  //             productPriceThapNhat: productPriceThapNhat,
  //             productPriceCaoNhat: productPriceCaoNhat,
  //             productRating: productRating,
  //             isFavourite: isFavourite,
  //             isPopular: isPopular,
  //             // ship: ship,
  //             // booking: booking,
  //             restaurantName: restaurantName,
  //             restaurantId: restaurantId,
  //             productdetailIdList: productdetailIdList)
  //       else
  //         product
  //   //   ];
  //   // });

  //   try {
  //     await read(API.product).getoneandupdate(
  //         productName: productName,
  //         // productDescription: productDescription,
  //         productImage: productImage,
  //         productId: productId,
  //         productPriceThapNhat: productPriceThapNhat,
  //         productPriceCaoNhat: productPriceCaoNhat,
  //         productRating: productRating,
  //         isFavourite: isFavourite,
  //         isPopular: isPopular,
  //         // ship: ship,
  //         // booking: booking,
  //         restaurantName: restaurantName,
  //         folderProductImage: folderProductImage,
  //         restaurantId: restaurantId);
  //   } on Exception catch (e, st) {
  //     logger.severe('Repository Exception', e, st);
  //     throw RepositoryException(
  //         message: 'Repository Exception', exception: e, stackTrace: st);
  //   }
  // }

  // Future<void> deleteProduct({
  //   required String productId,
  //   required String restaurantId,
  // }) async {
  //   _cacheState();

  //   state.where((element) => element.productId != productId).toList();
  //   try {
  //     await read(API.product)
  //         .getOneandDelete(productId: productId, restaurantId: restaurantId);
  //   } catch (e, st) {
  //     // state = AsyncValue.error(e, stackTrace: st);
  //   }
  // }

  // Future<void> deleteAllProductOfRestaurant(
  //     {required String restaurantId}) async {
  //   _cacheState();

  //   try {
  //     await read(API.product)
  //         .deleteAllProductOfRestaurant(restaurantId: restaurantId);

  //     state = [];
  //   } catch (e, st) {
  //     // state = AsyncValue.error(e, stackTrace: st);
  //   }
  // }

  // void _cacheState() {
  //   previousState = state;
  // }

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

  // ---------------------------

  Future<void> getOrderandUpdate({
    required String restaurantName,
    required String BuyingUserName,
    required String BuyingUserId,
    required String ProductId,
    required String restaurantId,
    required List<ProductDetailModel> productdetailsIdList,
    required List<ToppingModel> toppingsList,
    required String statusOrder,
    required String address,
    required String day,
    required String hour,
    required String minute,
    required String orderId,
    required String restaurantOnwnerId,
  }) async {
    // _cacheState();

    Map<String, OrderModel>? dataLocal = state;
    if (dataLocal.containsKey(orderId)) {
      dataLocal.update(orderId, (value) => value.copyWith(statusOrder: 'huy'));
      state = dataLocal;
      try {
        await read(API.orderTest).getoneandupdate(
          BuyingUserId: BuyingUserId,
          ProductId: ProductId,
          address: address,
          restaurantId: restaurantId,
          day: day,
          hour: hour,
          minute: minute,
          restaurantOnwnerId: restaurantOnwnerId,
          productdetailsIdList: productdetailsIdList,
          toppingsList: toppingsList,
          BuyingUserName: BuyingUserName,
          restaurantName: restaurantName,
          orderId: orderId,
          statusOrder: statusOrder,
        );
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    } else {
      return;
    }
  }
}
