import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/model/productdetail_model.dart';

class ProductDetailDeleteButton extends StatelessWidget {
  const ProductDetailDeleteButton({
    Key? key,
    required this.ProductDetailData,
    required this.ref,
  }) : super(key: key);

  final ProductDetailModel ProductDetailData;
  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    // print('build ModalSheetFormWithInformXoaButton');
    // print(ProductDetailData);
    return TextButton(
      onPressed: () async {
        // await ref
        //     .read(AppStateProvider.productdetailNotifier.notifier)
        //     .deleteProductDetailWithId(
        //         productdetaiId: ProductDetailData.productdetaiId!,
        //         productId: ProductDetailData.productId!);

        Navigator.of(context).pop();
      },
      child: Text("Đồng Ý"),
    );
  }
}
