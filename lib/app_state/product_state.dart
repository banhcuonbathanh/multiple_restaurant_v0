import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/exception/repository_exception.dart';
import 'package:untitled1/model/product_model.dart';
import 'package:untitled1/utils.dart';

import '../app_provider/api_provider.dart';

// List<Category>
class ProductState extends StateNotifier<List<ProductModel>> {
  ProductState(this.read, [List<ProductModel>? state])
      : super(state ?? const []) {
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
    required String folderProductImage,
  }) async {
    getAllProduct();

    // ProductModel? serverproduct;
    try {
      final serverproduct = await read(API.product).createProduct(
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
          productImage: productImage,
          folderProductImage: folderProductImage);

      if (state == []) {
        state = [serverproduct];
      } else {
        state = [...state, serverproduct];
      }
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
    // state = state.whenData((products) => [
    //       ...products, serverproduct!
    //       // Product(
    //       //     productName: productName,
    //       //     // productDescription: productDescription,
    //       //     productImage: productImage,
    //       //     productId: productId,
    //       //     productRating: productRating,
    //       //     isFavourite: isFavourite,
    //       //     isPopular: isPopular,
    //       //     // ship: ship,
    //       //     // booking: booking,
    //       //     restaurantName: restaurantName,
    //       //     productPriceCaoNhat: productPriceCaoNhat,
    //       //     productPriceThapNhat: productPriceCaoNhat,
    //       //     restaurantId: restaurantId)
    //     ]);
  }

  Future<List<ProductModel>?> searchingProductsOfRestaurantUserId({
    required String searchingKey,
  }) async {
    try {
      List<ProductModel> test = [];
      // print('searchingKey');
      // print(searchingKey);
      final products = await read(API.product)
          .searchingProductsByRestaurantId(searchingkey: searchingKey);

      List<ProductModel>? checkListFromRestauran = state
          .where((element) => element.restaurantId == searchingKey)
          .toList();
      if (checkListFromRestauran.isEmpty) {
        test = [...state, ...products];
      }

      state = test;
      return products;
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

  Future<void> retryLoadingProduct() async {
    try {
      final products = await read(API.product).getAllProduct();
      state = products;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  // Future<void> refresh() async {
  //   try {
  //     final products = await read(API.product).getAllProduct();
  //     state = AsyncValue.data(products);
  //   } catch (e, st) {
  //     state = AsyncValue.error(e, stackTrace: st);
  //   }
  // }

  Future<void> editProduct({
    required String productName,
    required String productImage,
    // required String productDescription,

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
            toppingList: [],
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

  Future<void> deleteProduct({
    required String productId,
    required String restaurantId,
  }) async {
    _cacheState();

    state = state.where((element) => element.productId != productId).toList();
    try {
      await read(API.product)
          .getOneandDelete(productId: productId, restaurantId: restaurantId);
    } catch (e, st) {
      // state = AsyncValue.error(e, stackTrace: st);
    }
  }

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
