import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/exception/repository_exception.dart';
import 'package:untitled1/model/product_model.dart';
import 'package:untitled1/utils.dart';

import '../app_provider/api_provider.dart';

// List<Category>
class ProductsEditState extends StateNotifier<List<ProductModel>> {
  ProductsEditState(this.read, [List<ProductModel>? state])
      : super(state ?? []) {
    // getAllProduct();
  }
  final Reader read;
  List<ProductModel>? previousState;
  // void addCategoryList(List<Category> newCategory) {
  //   state = [...state, ...newCategory];
  // }
  Future<void> createProduct({
    required String productName,
    // required String productDescription,
    required String productImage,
    required String productId,
    required double productPriceThapNhat,
    required double productPriceCaoNhat,
    required double productRating,
    required bool isFavourite,
    required bool isPopular,
    required bool ship,
    required bool booking,
    required String restaurantName,
    required String restaurantId,
    required List<String> productdetailIdList,
    required String? folderProductImage,
  }) async {
    // getAllProduct();
    state = [
      ...state,
      ProductModel(
        productName: productName,
        // productDescription: productDescription,
        productImage: productImage,
        productId: productId,
        productRating: productRating,
        isFavourite: isFavourite,
        isPopular: isPopular,
        // ship: ship,
        // booking: booking,
        restaurantName: restaurantName,
        productPriceCaoNhat: productPriceCaoNhat,
        productPriceThapNhat: productPriceCaoNhat,
        restaurantId: restaurantId,
        productdetailIdList: [], toppingList: [],
        folderProductImage: folderProductImage, promotionList: [],
      )
    ];

    try {
      await read(API.product).createProduct(
        productName: productName,
        // productDescription: productDescription,
        // productImage: productImage,
        // productId: productId,
        productRating: productRating,
        isFavourite: isFavourite,
        isPopular: isPopular,
        // ship: ship,
        // booking: booking,
        restaurantName: restaurantName,
        productPriceCaoNhat: productPriceCaoNhat,
        productPriceThapNhat: productPriceCaoNhat,
        restaurantId: restaurantId,
        productImage: productImage, folderProductImage: folderProductImage!,
      );
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  Future<void> searchingProductsOfRestaurantUserId({
    required String searchingKey,
  }) async {
    try {
      final products = await read(API.product)
          .searchingProductsByRestaurantId(searchingkey: searchingKey);
      state = products;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  Future<void> getAllProduct() async {
    try {
      final products = await read(API.product).getAllProduct();
      state = products;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  // Future<void> retryLoadingProduct() async {
  //   state = const AsyncValue.loading();
  //   try {
  //     final products = await read(APIServiceProductProvider).getAllProduct();
  //     state = AsyncValue.data(products);
  //   } on CategoryException catch (e, st) {
  //     state = AsyncValue.error(e, stackTrace: st);
  //   }
  // }

  // Future<void> refresh() async {
  //   try {
  //     final products = await read(APIServiceProductProvider).getAllProduct();
  //     state = AsyncValue.data(products);
  //   } catch (e, st) {
  //     state = AsyncValue.error(e, stackTrace: st);
  //   }
  // }

  Future<void> getoneandupdate({
    required String productName,
    required String productImage,
    required String productId,
    required double productPriceThapNhat,
    required double productPriceCaoNhat,
    required bool isFavourite,
    required bool isPopular,
    required String restaurantName,
    required String restaurantId,
    required List<String?>? productdetailIdList,
    required List<String?>? toppingList,
    required double productRating,
    required String folderProductImage,
  }) async {
    _cacheState();
    state = [
      for (final product in state)
        if (product.productId == productId)
          ProductModel(
            productName: productName,
            productImage: productImage,
            productId: productId,
            productPriceThapNhat: productPriceThapNhat,
            productPriceCaoNhat: productPriceCaoNhat,
            productRating: productRating,
            isFavourite: isFavourite,
            isPopular: isPopular,
            restaurantName: restaurantName,
            restaurantId: restaurantId,
            productdetailIdList: productdetailIdList,
            toppingList: toppingList,
            folderProductImage: folderProductImage,
            promotionList: [],
          )
        else
          product
    ];

    try {
      await read(API.product).getoneandupdate(
          productName: productName,
          // productDescription: productDescription,
          productImage: productImage,
          productId: productId,
          productPriceThapNhat: productPriceThapNhat,
          productPriceCaoNhat: productPriceCaoNhat,
          productRating: productRating,
          isFavourite: isFavourite,
          isPopular: isPopular,
          // ship: ship,
          // booking: booking,
          restaurantName: restaurantName,
          folderProductImage: folderProductImage,
          restaurantId: restaurantId);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }
// ------------------------------------------------

  Future<void> deleteProduct({
    required String productId,
    required String restaurantId,
  }) async {
    _cacheState();

    final tem =
        state.where((element) => element.productId != productId).toList();
    state = tem;
    try {
      await read(API.product)
          .getOneandDelete(productId: productId, restaurantId: restaurantId);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

// ----------------------------------------------
  Future<void> getoneandupdatetopping({
    required String productId,
    required String toppingName,
    required String toppingQuantity,
  }) async {
    // _cacheState();
    // for (final product in state) {
    //   // print('product');
    //   // print(product);
    // }

    // final product1 =
    //     state.where((element) => element.productId != productId).toList();

    for (final product in state) {
      if (product.productId == productId) {
        // final key = product.topping;
      }
    }

    // final product2 =
    //     state.where((element) => element.productId != productId).toList();
    // print('product2');
    // print(product2);
    try {
      await read(API.product).getoneandupdatetopping(
        productId: productId,
        toppingName: toppingName,
        toppingQuantity: toppingQuantity,
      );
      // print('test');
      // print(test);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

// ------------------------------------
  Future<void> deleteAllProductOfRestaurant(
      {required String restaurantId}) async {
    _cacheState();

    try {
      await read(API.product)
          .deleteAllProductOfRestaurant(restaurantId: restaurantId);

      state = [];
    } catch (e, st) {
      // state = AsyncValue.error(e, stackTrace: st);
    }
  }

// -----------------------------------
  Future<void> deleteProductImage(
      {required String productImage,
      required String newProductImage,
      required String productId}) async {
    try {
      await read(API.product).deleteProductImage(
          productImage: productImage,
          newProductImage: newProductImage,
          productId: productId);
      state = [
        for (final product in state)
          if (product.productId == productId)
            product.copyWith(productImage: newProductImage)
          else
            product
      ];
      // final test =
      //     state.firstWhere((element) => element.productId == productId);
      // print('test.productImage trong state');
      // print(test.productImage);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  void _cacheState() {
    previousState = state;
  }

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
