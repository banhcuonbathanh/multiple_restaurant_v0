import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/size_config.dart';

class CartCategory extends HookConsumerWidget {
  final Function funcIsShowDeliveryScreen;
  // final Function funcIsShowOrderScreen;
  final Function funcIsShowFavoriteScreen;
  final Function funcIsShowHistoryScreen;
  const CartCategory(
      {required this.funcIsShowDeliveryScreen,
      required this.funcIsShowFavoriteScreen,
      required this.funcIsShowHistoryScreen,
      // required this.funcIsShowOrderScreen,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print('CartCategory');
    final user = ref.watch(AppStateProvider.userNotifier);
    var _currenttab = useValueNotifier(1);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(40),
            child: Stack(
              children: [
                HookBuilder(builder: (context) {
                  final index = useValueListenable(_currenttab);
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.fastLinearToSlowEaseIn,
                    left: index == 0
                        ? getProportionateScreenWidth(5)
                        : (index == 1
                            ? getProportionateScreenWidth(93)
                            : (index == 2
                                ? getProportionateScreenWidth(180)
                                : getProportionateScreenWidth(270))),
                    bottom: getProportionateScreenHeight(5),
                    child: CustomerButton(
                      backgoundColor: null,
                      BorderRadiuscircular: 10,
                      buttonHeight: 30,
                      buttonWidth: 80,
                      press: () {},
                      text: '',
                    ),
                  );
                }),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            _currenttab.value = 0;
                            funcIsShowDeliveryScreen();
                          },
                          child: HookBuilder(builder: (context) {
                            final index = useValueListenable(_currenttab);
                            return Text(
                              'Đang Đến',
                              style: TextStyle(
                                  color: index == 0
                                      ? Colors.white
                                      : Colors.grey.shade400),
                            );
                          }),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Center(
                    //     child: InkWell(
                    //       onTap: () {
                    //         _currenttab.value = 1;
                    //         funcIsShowOrderScreen();
                    //       },
                    //       child: HookBuilder(builder: (context) {
                    //         final index = useValueListenable(_currenttab);
                    //         return Text(
                    //           'Đặt Hàng',
                    //           style: TextStyle(
                    //               color: index == 1
                    //                   ? Colors.white
                    //                   : Colors.grey.shade400),
                    //         );
                    //       }),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            await ref
                                .read(AppStateProvider
                                    .productdetailMapNotifier.notifier)
                                .addItemFavaoriteFromServer(
                                    userId: user!.userId!);
                            _currenttab.value = 2;
                            funcIsShowFavoriteScreen();
                          },
                          child: HookBuilder(builder: (context) {
                            final index = useValueListenable(_currenttab);
                            return Text(
                              'Yêu Thích',
                              style: TextStyle(
                                  color: index == 2
                                      ? Colors.white
                                      : Colors.grey.shade400),
                            );
                          }),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            _currenttab.value = 3;
                            funcIsShowHistoryScreen();
                          },
                          child: HookBuilder(builder: (context) {
                            final index = useValueListenable(_currenttab);
                            return Text(
                              'Lịch Sử',
                              style: TextStyle(
                                  color: index == 3
                                      ? Colors.white
                                      : Colors.grey.shade400),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
