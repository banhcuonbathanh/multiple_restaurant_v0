import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/api_provider.dart';
import 'package:untitled1/app_provider/utility_provider.dart';
import 'package:untitled1/exception/repository_exception.dart';
import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/utils.dart';

class ProductDetailMapState
    extends StateNotifier<Map<String, ProductDetailModel>> {
  ProductDetailMapState(this.read, Map<String, ProductDetailModel>? state)
      : super({}) {}

  final Reader read;

// ---------------------------------------------------------
  Future<void> addItem({required String productId}) async {
    // print('ProductDetailMapState addItem');
    Map<String, ProductDetailModel>? dataLocal = state;
    if (dataLocal.length <= 1) {
      // print('state.value == null');
      try {
        final listproductdetail = await read(API.productdetail)
            .searchingProductDetailproductId(searchingkey: productId);
        Map<String, ProductDetailModel> temporary = {};
        listproductdetail.forEach((element) {
          temporary['${element.productdetaiId}'] = element;
        });
        state = temporary;
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
    } else {
      // print('state.value !!!!!= null');

      try {
        final productdetailsServer = await read(API.productdetail)
            .searchingProductDetailproductId(searchingkey: productId);
        for (final productdetail in productdetailsServer) {
          dataLocal.putIfAbsent(
              productdetail.productdetaiId!, () => productdetail);
        }
      } on Exception catch (e, st) {
        logger.severe('Repository Exception', e, st);
        throw RepositoryException(
            message: 'Repository Exception', exception: e, stackTrace: st);
      }
// ---------------------------------------------------------

      state = dataLocal;
    }
  }

  Future<void> addItemFavaoriteFromServer({
    required String userId,
  }) async {
    // print('productdetail addItemFavaoriteFromServer');
    try {
      Map<String, ProductDetailModel>? dataLocal = state;

      // print(dataLocal);
      //  if (dataLocal!.isEmpty)
      // print('dataLocal!.length');
      // print(dataLocal!.length <= 1);
      if (dataLocal.length <= 1) {
        // print('dataLocal == null');

        final listproductdetailFromServer =
            await read(API.user).getFavouriteProductDetails(userId: userId);
        Map<String, ProductDetailModel> temporary = {};
        listproductdetailFromServer.forEach((element) {
          temporary['${element.productdetaiId}'] = element;
        });

        state = temporary;
        // print('state');
        // print(state);
      } else {
        // print('dataLocal not nulll');

        final listproductdetailFromServer =
            await read(API.user).getFavouriteProductDetails(userId: userId);

        for (final productdetail in listproductdetailFromServer) {
          // print(dataLocal.containsKey(productdetail.productdetaiId));
          // print('dataLocal.containsKey(productdetail.productdetaiId)');
          if (dataLocal.containsKey(productdetail.productdetaiId) == false) {
            dataLocal.putIfAbsent(
                productdetail.productdetaiId!, () => productdetail);
          }
        }
        state = dataLocal;
      }
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  void editProductDetailAdd({
    required String productdetaiId,
    required String productId,
  }) {
    Map<String, ProductDetailModel>? dataLocal = state;
    // read(Utility.showAnimationForBuying.notifier).changeToTrue();
    dataLocal.update(
        productdetaiId,
        (value) => value.copyWith(
            productdetailQuantity: value.productdetailQuantity! + 1,
            productdetailBill:
                (value.productdetailQuantity! + 1) * value.productdetaiPrice!));

    state = dataLocal;
  }

  void editProductDetailRemove({
    required String productdetaiId,
    required String productId,
  }) {
    Map<String, ProductDetailModel>? dataLocal = state;

    dataLocal.update(
        productdetaiId,
        (value) => value.copyWith(
            productdetailQuantity: value.productdetailQuantity! > 0
                ? value.productdetailQuantity! - 1
                : 0,
            productdetailBill: (value.productdetailQuantity! > 0
                    ? value.productdetailQuantity! - 1
                    : 0) *
                value.productdetaiPrice!));

    state = dataLocal;
  }

  List<ProductDetailModel> pullOutFavoriteItem(
      {required List<ProductDetailModel> stateData,
      required List<String> favoutielist}) {
    // print('stateData asdfasdf');
    // print(stateData.length);
    List<ProductDetailModel> fiteltr = [];
    favoutielist.forEach((idfromuser) {
      stateData.forEach((productdetail) {
        if (productdetail.productdetaiId == idfromuser) {
          fiteltr.add(productdetail);
        }
      });
    });
    return fiteltr;
  }

  // ----------------------------------------------

  Future<List<ProductDetailModel>> searchingProductDetailWithNameLetter({
    required String nameLetters,
  }) async {
    Map<String, ProductDetailModel> dataLocal = state;
    Map<String, ProductDetailModel> tem = {};
    try {
      // print('searchingKey');
      // print(searchingKey);
      final serverproducts = await read(API.productdetail)
          .searchingProductDetailWithNameLetter(nameLetters: nameLetters);

      if (dataLocal.length < 1) {
        for (final serverProduct in serverproducts) {
          tem['${serverProduct.productId}'] = serverProduct;

          // dataLocal.putIfAbsent(serverOrder.orderId, () => serverOrder);
        }
        state = tem;
      } else {
        for (final serverProduct in serverproducts) {
          dataLocal.putIfAbsent(serverProduct.productId!, () => serverProduct);
        }
        state = dataLocal;
      }
      return serverproducts;
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  // ----------------------------------------------

  Future<void> resetProductDetail({
    required String productdetailId,
  }) async {
    Map<String, ProductDetailModel> dataLocal = state;

    if (dataLocal.containsKey(productdetailId)) {
      dataLocal.update(
          productdetailId, (value) => value.copyWith(productdetailQuantity: 0));
    } else {
      return;
    }
  }
}
