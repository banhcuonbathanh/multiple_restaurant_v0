import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/app_provider/utility_provider.dart';

import 'package:untitled1/enums.dart';
import 'package:untitled1/helper/custom_page_route.dart';

import 'package:untitled1/screens/cart/cart_screen.dart';

import 'package:untitled1/screens/home/home_screen.dart';
import 'package:untitled1/screens/profile/profile_screen.dart';
import 'package:untitled1/size_config.dart';

import '../constants.dart';
import '../screens/manage_restaurant/manage_restaurant_body.dart';

class CustomBottomNavBar extends HookConsumerWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(AppStateProvider.userNotifier);
    final orders = ref
        .watch(AppStateProvider.orderTestNotifier)
        .values
        .toList()
        .where((element) => element.BuyingUserId == user!.userId!);
    final restart = useState<bool>(true);
    // print('CustomBottomNavBar');

    // final animationController = useValueNotifier<bool>(false);
    // print('user?.restaurantId');
    // print(user?.restaurantId == '');
    final productdetailMap = ref
        .watch(AppStateProvider.productdetailMapNotifier)!
        .values
        .where((element) => element.productdetailQuantity! > 0)
        .toList();

    // -------------------------------------------------
    final offsetAnimationControler = useAnimationController(
      duration: const Duration(milliseconds: 800),
    )..addListener(() {
        restart.value = !restart.value;
      });
    final ofseetAnimation =
        Tween(begin: 1.0, end: 0.0).animate(offsetAnimationControler);
    final nimationbuyingcondition = ref.watch(Utility.showAnimationForBuying1);
    ref.listen(disposeofhome, (previous, next) {
      if (nimationbuyingcondition > 0 && next == true) {
        TickerFuture tickerFuture = offsetAnimationControler.repeat();
        tickerFuture.timeout(const Duration(seconds: 10), onTimeout: () {
          offsetAnimationControler.forward(from: 0);
          offsetAnimationControler.stop(canceled: true);
        });
        // offsetAnimationControler.forward();

        ref.read(Utility.showAnimationForBuying1.notifier).reset();
      }

      ref.read(Utility.disposeofhomeGetter.notifier).diposefalse();
    });
    // -------------------------------------------------
    const inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      height: getProportionateScreenHeight(60),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(40),
        //   topRight: Radius.circular(40),
        // ),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/Shop Icon.svg",
                    color: MenuState.home == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  }),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Cart Icon.svg",
                  height: getProportionateScreenHeight(22),
                  color: MenuState.favourite == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () async {
                  await ref
                      .read(AppStateProvider.productdetailMapNotifier.notifier)
                      .addItemFavaoriteFromServer(userId: user!.userId!);
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Chat bubble Icon.svg",
                  color: MenuState.message == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () async {
                  // print('user!.restaurantId!');
                  // print(user!.restaurantId!);
                  if (user!.restaurantId != null && user.restaurantId != '') {
                    await ref
                        .read(AppStateProvider.restaurantEditNotifier.notifier)
                        .searchRestaurantsUserId(
                            restaurantId: user.restaurantId!);
                    await ref
                        .read(AppStateProvider.productEditNotifier.notifier)
                        .searchingProductsOfRestaurantUserId(
                            searchingKey: user.restaurantId!);
                  }
// ----------------

                  final orderTest = await ref
                      .read(AppStateProvider.orderTestNotifier.notifier)
                      .searchingorderByBuyingUserId(
                        BuyingUserId: user.userId!,
                        numberOfOrder: 0,
                        page: 0,
                        statusOrder: 'dat hang',
                      );
// -------------------------------------
                  Navigator.pushNamed(context, ManageRestaurantBody.routeName);
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                  // Navigator.pushNamed(context, ProfileScreen.routeName);
                  Navigator.of(context)
                      .push(CustomPageRoute(child: ProfileScreen()));
                },
              ),
            ],
          ),

          // final asdfs = useValueListenable(animationController);
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.fastLinearToSlowEaseIn,
            left: 145,
            bottom: 27 * ofseetAnimation.value,
            child: Container(
              alignment: Alignment.center,
              width: getProportionateScreenWidth(30),
              decoration: const BoxDecoration(
                  color: Colors.red, shape: BoxShape.circle),
              child: Text(
                orders.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
