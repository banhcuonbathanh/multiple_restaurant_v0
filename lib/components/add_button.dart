import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/app_provider/utility_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/constants.dart';
import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/size_config.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
    required this.ProductDetailData,
    required this.productId,
    required this.ref,
    required this.restart,
  }) : super(key: key);

  final ProductDetailModel ProductDetailData;
  final String productId;
  final WidgetRef ref;
  final Function restart;
  @override
  Widget build(BuildContext context) {
    return CustomerButton(
      backgoundColor: kPrimaryColor,
      BorderRadiuscircular: 8,
      buttonHeight: getProportionateScreenHeight(20),
      buttonWidth: getProportionateScreenWidth(30),
      press: () {
        ref.read(Utility.showAnimationForBuying1.notifier).addOne();

// -----------------------------
        ref
            .read(AppStateProvider.productdetailMapNotifier.notifier)
            .editProductDetailAdd(
              productdetaiId: ProductDetailData.productdetaiId!,
              productId: productId,
            );
        restart();
      },
      text: '',
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: getProportionateScreenHeight(20),
      ),
    );
  }
}
