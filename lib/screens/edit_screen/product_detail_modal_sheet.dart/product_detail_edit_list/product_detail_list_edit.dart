import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';

import 'package:untitled1/screens/edit_screen/product_detail_modal_sheet.dart/product_detail_one_with_inform/product_detail_one_edit_with_inform.dart';

import 'package:untitled1/size_config.dart';

import '../../topping/topping_with_inform/topping_with_inform.dart';
import '../../topping/topping_with_no_inform/topping_with_no_inform.dart';
import '../product_detail_one_edit_no_infor/product_detail_one_edit_no_inform_home.dart';

class ProductDetailList_Edit1 extends HookConsumerWidget {
  const ProductDetailList_Edit1({
    required this.index,
    required this.serverRestaurantId,
    required this.isAccessFromMainScreen,
    Key? key,
    required this.serverProductId,
  }) : super(key: key);

  final String? serverProductId;
  final String serverRestaurantId;
  final bool isAccessFromMainScreen;
  final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print('build ProductDetailList_Home');

    final restart = useState<bool>(false);
    Function restartFunc = () {
      // print('restartFunc');
      restart.value = !restart.value;
    };
    // useEffect(() {
    //   return () {
    //     print('disposal ModalSheetProduct');
    //   };
    // });

    // ref.listen(categoryExceptiontestProvider, (previous, next) {
    //   print('ref.listen(categoryExceptiontestProvider build ModalSheetProduct');

    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           content: Text('khong co mang'),
    //           actions: [
    //             TextButton(
    //               onPressed: () async {
    //                 Navigator.of(context).pop();
    //               },
    //               child: Text("Đồng Ý"),
    //             )
    //           ],
    //         );
    //       });
    // });
    final ProductDetailPresen =
        ref.watch(AppStateProvider.productDetailEditState);

    final productsDetailData = ProductDetailPresen.where(
        (element) => element.productId == serverProductId).toList();
    final toppingList =
        ref.watch(AppStateProvider.toppingEditMapNotifier).values.toList();
    final toppingListOfProduct = toppingList
        .where((element) => element.productId == serverProductId)
        .toList();
    // print('toppingListOfProduct');
    // print(toppingListOfProduct.length);

    return DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (_, controller) {
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              controller: controller,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var index = 0;
                        index < productsDetailData.length;
                        index++)
                      ProductDetailOneEditWithInform(
                        ProductDetailData: productsDetailData[index],
                        productId: serverProductId!,
                      ),
                    // ProductDetailOneEditWithInform(
                    //   ProductDetailData: productsDetailData.elementAt(index),
                    //   productId: serverProductId!,
                    //   restart: () {
                    //     count.value = !count.value;
                    //   },
                    // ),

                    ProductDetailOne_EditNoInform_Home(
                      serverProductId: serverProductId!,
                    ),
                    Divider(),

                    // if (productsDetailData != null &&
                    //     productsDetailData.length >= 1)
                    //   MonAnKem(),

                    if (productsDetailData != null &&
                        productsDetailData.length >= 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomerButton(
                            backgoundColor: null,
                            BorderRadiuscircular: 10,
                            buttonHeight: getProportionateScreenHeight(25),
                            buttonWidth: getProportionateScreenWidth(70),
                            press: () {},
                            text: 'Xong',
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class draggablesheet extends StatelessWidget {
  final Widget contend;
  const draggablesheet({
    Key? key,
    required this.contend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (_, controller) {
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              controller: controller,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: GridView.count(
                        primary: false,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 4 / 5,
                        mainAxisSpacing: getProportionateScreenHeight(10),
                        crossAxisSpacing: getProportionateScreenWidth(10),
                        children: [
                          Container(
                            child: contend,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
