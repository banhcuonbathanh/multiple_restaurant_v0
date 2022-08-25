import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/model/product_model.dart';
import 'package:untitled1/screens/home/components/product_detail_modal_sheet_home/product_detail_list_home.dart';
import 'package:untitled1/size_config.dart';

class ItemFilterProduct extends HookConsumerWidget {
  const ItemFilterProduct({
    Key? key,
    required this.filterProducts,
    required this.title,
  }) : super(key: key);

  final ValueNotifier<List<ProductModel>> filterProducts;
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: getProportionateScreenHeight(30),
            decoration: BoxDecoration(
              // color: Colors.white,
              color: Colors.white.withOpacity(1),
              // kSecondaryColor,
              borderRadius: BorderRadius.circular(14),
            ),
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  '    ${title}',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7), fontSize: 14),
                ),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.chevron_left_sharp))
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              // color: Colors.white,

              // kSecondaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            // color: Colors.white,
            child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: filterProducts.value.length,
                itemBuilder: (context, index) {
                  final product = filterProducts.value[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.white.withOpacity(0.9)),
                        color: Colors.white.withOpacity(0.9),

                        // kSecondaryColor,
                        borderRadius: BorderRadius.circular(17),
                      ),
                      padding: EdgeInsets.all(8),
                      height: getProportionateScreenHeight(90),
                      child: InkWell(
                        onTap: () async {
                          await ref
                              .read(AppStateProvider
                                  .productdetailMapNotifier.notifier)
                              .addItem(productId: product.productId!);
                          if (product.toppingList != null) {
                            await ref
                                .read(AppStateProvider
                                    .toppingEditMapNotifier.notifier)
                                .searchingToppingWithProductId(
                                    productId: product.productId!);
                          }

                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return ProductDetailList_Home(
                                  serverProductId: product.productId!,
                                  restaurantId: product.restaurantId!,
                                );
                              });
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(product.productImage!),
                            ),
                            Spacer(),
                            Text(product.productName!,
                                style: TextStyle(color: Colors.black))
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
