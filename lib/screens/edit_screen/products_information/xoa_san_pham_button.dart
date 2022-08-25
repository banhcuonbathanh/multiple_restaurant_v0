
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';

import '../../../app_provider/utility_provider.dart';

class XoaThongTinSanPham extends HookConsumerWidget {
  const XoaThongTinSanPham(
      {required this.serverRestaurantId,
      required this.serverProductId,
      Key? key})
      : super(key: key);
  final String serverProductId;
  final String serverRestaurantId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(AppStateProvider.userNotifier);
    return ElevatedButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('Xoá Thông Tin Sản Phẩm'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        // ref.read(EditProductProvider.notifier).changetoState();
                        // xoa san pham
                  

                        await ref
                            .read(AppStateProvider.productEditNotifier.notifier)
                            .deleteProduct(
                                productId: serverProductId,
                                restaurantId: serverRestaurantId);
                        // final restaruatdata = await ref
                        //     .read(restaurantsNotifierProvider.notifier)
                        //     .searchRestaurantsUserId(
                        //         searchingkey: user!.restaurantId!);
                        Navigator.of(context).pop();
// cap nhat thong tin san pham

                        //        await ref
                        // .read(restaurantsNotifierProvider.notifier)
                        // .searchUserSId(userId: restaurantData.userId!);
                      },
                      child: Text("Đồng Ý"),
                    )
                  ],
                );
              });
        },
        child: Text('Xoá'));
  }
}
