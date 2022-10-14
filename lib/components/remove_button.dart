import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/size_config.dart';

import '../app_provider/utility_provider.dart';
import '../model/productdetail_model.dart';

class RemoveButton extends StatelessWidget {
  const RemoveButton({
    Key? key,
    required this.ProductDetailData,
    required this.ref,
    required this.restart,
  }) : super(key: key);

  final ProductDetailModel ProductDetailData;
  final WidgetRef ref;
  final Function restart;
  @override
  Widget build(BuildContext context) {
    var kPrimaryColor;
    return CustomerButton(
      backgoundColor: kPrimaryColor,
      BorderRadiuscircular: getProportionateScreenHeight(8),
      buttonHeight: getProportionateScreenHeight(20),
      buttonWidth: getProportionateScreenWidth(30),
      press: () async {
        ref.read(Utility.showAnimationForBuying1.notifier).minusOne();
        restart();
        ref
            .read(AppStateProvider.productdetailMapNotifier.notifier)
            .editProductDetailRemove(
              productdetaiId: ProductDetailData.productdetaiId!,
              productId: ProductDetailData.productId!,
            );
      },
      text: '+',
      child: Icon(
        Icons.remove,
        color: Colors.white,
        size: getProportionateScreenHeight(20),
      ),
    );
  }
}
