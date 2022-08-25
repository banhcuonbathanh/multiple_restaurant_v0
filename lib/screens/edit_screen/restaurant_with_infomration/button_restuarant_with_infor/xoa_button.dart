import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/model/restaurant_model.dart';
import 'package:untitled1/size_config.dart';

class XoaButton extends HookConsumerWidget {
  const XoaButton({required this.restaurantData, Key? key}) : super(key: key);
  final RestaurantModel restaurantData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      print('build XoaButton');
      return () {
        print('dispose xoaButton');
      };
    });
    //----------------------------------------------
    final restaurantData = ref.watch(AppStateProvider.restaurantEditNotifier);
    //-------------------------------------------------------
    // print('XoaButton');
    return CustomerButton(
        text: "Xoá",
        press: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // title: Text('Xoá Thông Tin Nhà Hàng và Sản Phẩm'),
                  content: Text('Xoá Thông Tin Nhà Hàng và Sản Phẩm '),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        // ref.read(EditProductProvider.notifier).changetoState();

                        // print('1');
                        await ref
                            .read(AppStateProvider
                                .restaurantEditNotifier.notifier)
                            .deleteRestaurant(
                                restaurantId: restaurantData!.restaurantId!,
                                restaurantImageStoreFolder:
                                    restaurantData.restaurantImageStoreFolder!);
                        await ref
                            .read(AppStateProvider.userNotifier.notifier)
                            .searchUserSId(userId: restaurantData.userId!);
                        // print('11111');
                        // await ref
                        //     .read(AppStateProvider
                        //         .restaurantEditNotifier.notifier)
                        //     .deleteRestaurantImage(
                        //         restaurantImage:
                        //             restaurantData.restaurantImage!);
                        // ref.read(EditProductProvider.notifier).changetoState();
                        // print('2');

                        await ref
                            .read(AppStateProvider.productEditNotifier.notifier)
                            .deleteAllProductOfRestaurant(
                                restaurantId: restaurantData.restaurantId!);
                        // ref.read(EditProductProvider.notifier).changetoState();
                        await ref
                            .read(AppStateProvider.productEditNotifier.notifier)
                            .deleteAllProductOfRestaurant(
                                restaurantId: restaurantData.restaurantId!);
                        // ref.read(EditProductProvider.notifier).changetoState();
                        // print('3');
                        // await ref
                        //     .read(productsDetailNotifierProvider.notifier)
                        //     .deleteAllProductDetailOfRestaurant(
                        //         restaurantId: restaurantData.restaurantId!);
                        // ref.read(EditProductProvider.notifier).changetoState();
                        // print('3');
                        await ref
                            .read(AppStateProvider.userNotifier.notifier)
                            .searchUserSId(userId: restaurantData.userId!);
                        // print('4');

                        // showDialog(
                        //     context: context,
                        //     builder: (contetxt) {
                        //       return AlertDialog(
                        //         content: Text(
                        //             'Xoá Thành Công Nhà Hàng và Sản Phẩm '),
                        //       );
                        //     });
                      },
                      child: Text("Đồng Ý"),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(" Không Đồng Ý"))
                  ],
                );
              });
        },
        buttonHeight: getProportionateScreenHeight(38),
        buttonWidth: getProportionateScreenWidth(70),
        BorderRadiuscircular: 10,
        backgoundColor: null);
  }
}
