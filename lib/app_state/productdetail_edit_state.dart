import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/api_provider.dart';
import 'package:untitled1/exception/repository_exception.dart';
import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/utils.dart';

class ProductDetailEditState extends StateNotifier<List<ProductDetailModel>> {
  ProductDetailEditState(this.read,
      // this.productId,
      [AsyncValue<List<ProductDetailModel>>? state])
      : super([]) {
    // getProductDetailproductId();
    // getProductDetailproductId(searchingKey: productId);
    // state = AsyncValue.data([]);

    // searchingProductDetailOfRestaurantUserId(searchingKey: searchingKey);
  }
  final Reader read;
  // final String productId;
  List<ProductDetailModel>? previousState;

  Future<void> createProductDetail({
    required ProductDetailModel productdetail,
  }) async {
    // getAllProduct();

    ProductDetailModel productBackEnd;
    try {
      productBackEnd = await read(API.productdetail)
          .createProductDetail(productdetail: productdetail);

      state = [...state, productBackEnd];
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

// ---------------------------------------
  Future<void> getProductDetailproductId({
    required String searchingKey,
  }) async {
    try {
      final products = await read(API.productdetail)
          .searchingProductDetailproductId(searchingkey: searchingKey);

      state = products;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }
// ----testtesttesttesttesttesttesttesttesttesttesttest

// ----testtesttesttesttesttesttesttesttesttesttesttest
  Future<void> getAllProduct() async {
    try {
      final products = await read(API.productdetail).getAllProduct();
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

  Future<void> getoneandupdate(
      {required String productdetaitName,
      required String productdetaiDescription,
      required String productdetaiImage,
      required String productdetaiId,
      required double productdetaiPrice,
      required double productdetaiRating,
      required double productdetailQuantity,
      required double productdetailBill,
      required bool productdetaiIsFavourite,
      required bool productdetaiIsPopular,
      required String restaurantName,
      required String restaurantId,
      required String productName,
      required String productId,
      required String userId,
      required List<String> productdetailIdList,
      required String? productdetailFolder}) async {
    _cacheState();

    state = [
      for (final productdetail in state)
        if (productdetail.productdetaiId == productdetaiId)
          ProductDetailModel(
              productdetaitName: productdetaitName,
              productdetaiDescription: productdetaiDescription,
              productdetaiImage: productdetaiImage,
              productdetaiId: productdetaiId,
              productdetaiPrice: productdetaiPrice,
              productdetaiRating: productdetaiRating,
              productdetailQuantity: productdetailQuantity,
              productdetailBill: productdetailBill,
              productdetaiIsFavourite: productdetaiIsFavourite,
              productdetaiIsPopular: productdetaiIsPopular,
              restaurantName: restaurantName,
              restaurantId: restaurantId,
              productName: productName,
              productId: productId,
              productdetailIdList: productdetailIdList,
              productdetailFolder: productdetailFolder,
              userId: userId,
              toppingList: [],
              promotion: null)
        else
          productdetail
    ];
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
    //   ];
    // });

    try {
      await read(API.productdetail).getoneandupdate(
        productdetaitName: productdetaitName,
        productdetaiDescription: productdetaiDescription,
        productdetaiImage: productdetaiImage,
        productdetaiId: productdetaiId,
        productdetaiPrice: productdetaiPrice,
        productdetaiRating: productdetaiRating,
        productdetailQuantity: productdetailQuantity,
        productdetailBill: productdetailBill,
        productdetaiIsFavourite: productdetaiIsFavourite,
        productdetaiIsPopular: productdetaiIsPopular,
        restaurantName: restaurantName,
        restaurantId: restaurantId,
        productName: productName,
        productId: productId,
        userId: userId,
      );
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  Future<void> editProductDetailAdd({
    required String? productdetaiId,
    // required String? productId,
    required double? productdetaiPrice,
    required double? productdetailQuantity,
    // required double? productDetailBill,
  }) async {
    state = [
      for (final productdetail in state)
        if (productdetail.productdetaiId == productdetaiId)
          productdetail.copyWith(
              productdetailQuantity: productdetail.productdetailQuantity! + 1,
              productdetailBill: (productdetail.productdetailQuantity! + 1) *
                  productdetaiPrice!)
        else
          productdetail
    ];
  }

  Future<void> editProductDetailRemove({
    required String? productdetaiId,
    // required String? productId,
    required double? productdetaiPrice,
    required double? productdetailQuantity,
    // required double? productDetailBill,

    // required String? category,
  }) async {
    state = [
      for (final productdetail in state)
        if (productdetail.productdetaiId == productdetaiId)
          productdetail.copyWith(
              productdetailQuantity:
                  productdetailQuantity! > 0 ? productdetailQuantity - 1 : 0,
              productdetailBill:
                  (productdetailQuantity > 0 ? productdetailQuantity - 1 : 0) *
                      productdetaiPrice!)
        else
          productdetail
    ];
  }

  Future<void> deleteProductDetailWithId(
      {required String productdetaiId, required String productId}) async {
    // _cacheState();

    final tem = state
        .where((element) => element.productdetaiId != productdetaiId)
        .toList();
    state = tem;

    try {
      await read(API.productdetail).getOneandDelete(
          productdetaiId: productdetaiId, productId: productId);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  Future<void> deleteAllProductDetailOfRestaurant(
      {required String restaurantId}) async {
    _cacheState();

    try {
      await read(API.productdetail)
          .deleteAllProductDetailOfRestaurant(restaurantId: restaurantId);

      state = [];
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  Future<void> deleteProductDetailImage(
      {required String productdetailImage,
      required String newProductDetailImage,
      required String productdetailId}) async {
    try {
      await read(API.productdetail).deleteProductDetailImage(
          newProductDetailImage: newProductDetailImage,
          productdetailId: productdetailId,
          productdetailImage: productdetailImage);

      state = [
        for (final productdetail in state)
          if (productdetail.productId == productdetailId)
            productdetail.copyWith(productdetaiImage: newProductDetailImage)
          else
            productdetail
      ];
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
