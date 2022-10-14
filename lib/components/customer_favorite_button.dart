import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/model/productdetail_model.dart';

class CustomerFavoriteButton extends StatelessWidget {
  const CustomerFavoriteButton({
    Key? key,
    required this.isFavorite,
    required this.ProductDetailData,
    required this.ref,
  }) : super(key: key);

  final bool isFavorite;
  final ProductDetailModel ProductDetailData;
  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    return FavoriteButton(
      iconColor: Colors.blue,
      isFavorite: isFavorite,
      iconSize: 13,
      // iconDisabledColor: Colors.white,
      valueChanged: (_isFavorite) {
        if (_isFavorite == true) {
          // print('this true');
          ref
              .read(AppStateProvider.userNotifier.notifier)
              .addFavouriteProductDetails(
                  productDetailId: ProductDetailData.productdetaiId!);
          ProductDetailData.productdetaiIsFavourite;
        }
        if (_isFavorite == false) {
          // print('this false');
          ref
              .read(AppStateProvider.userNotifier.notifier)
              .removeFavouriteProductDetails(
                  productDetailId: ProductDetailData.productdetaiId!);
          ProductDetailData.productdetaiIsFavourite;
        }
      },
    );
  }
}
