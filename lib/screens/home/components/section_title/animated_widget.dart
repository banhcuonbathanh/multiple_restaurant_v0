import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/utility_provider.dart';
import 'package:untitled1/model/restaurant_model.dart';
import 'package:untitled1/size_config.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

class AnimatedForEachWidget12 extends HookConsumerWidget {
  const AnimatedForEachWidget12({
    required this.titleSccollcontroller,
    required this.sccollcontroller,
    required this.restaurantsData,
    required this.resraunarisShow,
    Key? key,
    required this.restaurantData,
    required this.restaurantIndex,
  }) : super(key: key);

  final int restaurantIndex;

  final RestaurantModel restaurantData;
  final List<RestaurantModel>? restaurantsData;
  final ValueNotifier<String> resraunarisShow;
  final ScrollController sccollcontroller;
  final ScrollController titleSccollcontroller;
  // final Animation<double> animationFade;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // -----------------------------
    final restaurantIsShow = useValueListenable(resraunarisShow);
    final int currentRestaurantIndex = restaurantsData!
        .indexWhere(((element) => element.restaurantName == restaurantIsShow));
    final withOfContainer = getProportionateScreenWidth(70);
    final paddingContainer = getProportionateScreenWidth(10);
    // -------------------------------
    //  horizontal move
    double currentLenth = 0.0;
    double restaurantPosition = 0.0;
    final widgetOffsetMap = ref.watch(Utility.widgetOffSet);

    final widgetOffset = widgetOffsetMap.values.toList();
    if (widgetOffset.length > 0) {
      currentLenth = widgetOffset[currentRestaurantIndex + 2];

      if (widgetOffsetMap[restaurantData.restaurantName] != null) {
        restaurantPosition = widgetOffsetMap[restaurantData.restaurantName]!;
      }
    }

    // --------------------------------

    // final lengthHorizontal = withOfContainer + paddingContainer;

    // final hesochuyendoi = lengthHorizontal / currentLenth;

    // final scrollernga = sccollcontroller.offset * hesochuyendoi;
    // bool isWidgetOnActice = false;
    // if (sccollcontroller.offset < currentLenth) {
    //   isWidgetOnActice = true;
    // }
    // ---------------------------
    final animationcontrollerFade =
        useAnimationController(duration: Duration(milliseconds: 300));
    // --------------------------
    // final animationcontrollerdispose =
    //     useAnimationController(duration: Duration(milliseconds: 300));
    // final animationScaleDispose =
    //     Tween(begin: 1.0, end: 0.0).animate(animationcontrollerdispose);
    // --------------------------
    final testmount = useIsMounted();
    if (currentRestaurantIndex == restaurantIndex) {
      animationcontrollerFade.forward();
      // print('testmounttestmounttestmounttestmounttestmounttestmount');
      // print(testmount());
      if (testmount() == true) {
        titleSccollcontroller.animateTo(
            currentRestaurantIndex == 0
                ? 1
                : currentRestaurantIndex > 1
                    ? (currentRestaurantIndex) * 50
                    : 2,
            duration: Duration(milliseconds: 400),
            curve: Curves.ease);
      }
    }
    final animationColor = ColorTween(begin: Colors.orange, end: Colors.black)
        .animate(animationcontrollerFade);

    // final animationSliding = Tween(begin: Offset(0, 0), end: Offset(0.2, 0.0))
    //     .animate(animationcontrollerFade);
    final animationScale =
        Tween(begin: 1.0, end: 0.0).animate(animationcontrollerFade);
    final animationFade =
        Tween(begin: 1.0, end: 0.0).animate(animationcontrollerFade);
    // print('animationcontrollerFade.statussadfsdfsdfsdfsfsdf');
    // print(animationcontrollerFade.status);
    // bool transformScale = true;
    useEffect(() {
      animationcontrollerFade.addStatusListener((status) {
        // print('11111111');
        // print(status);
        if (status == AnimationStatus.completed) {
          // print('objectobjectobjectobjectobjectobjectobject');
          animationcontrollerFade.reverse();
          // print('2222222');
          // print(status);
        }
        // print('2222222');as        // print(status);
      });

      return () {};
    });

    return AnimatedBuilder(
      // opacity: animationFade,
      animation: animationcontrollerFade,
      child: Container(
          alignment: Alignment.center,
          width: withOfContainer,
          height: getProportionateScreenHeight(25),
          decoration: restaurantIsShow == restaurantData.restaurantName!
              ? BoxDecoration(
                  color: animationColor.value,
                  borderRadius: BorderRadius.circular(10),
                )
              : BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
          child: Text(
            restaurantsData![restaurantIndex].restaurantName!,
            style: TextStyle(
                color: restaurantIsShow == restaurantData.restaurantName!
                    ? Colors.white
                    : Colors.white.withOpacity(0.5)),
          )),
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: EdgeInsets.only(left: 5),
          child: InkWell(
            onTap: () {
              sccollcontroller.animateTo(restaurantPosition - 100,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
            child: Container(
              // decoration: test == restaurantData.restaurantName!
              //     ? BoxDecoration(
              //         color: animationColor.value,
              //         borderRadius: BorderRadius.circular(10),
              //       )
              //     : BoxDecoration(),
              child: ScaleTransition(
                scale: animationScale,
                child: FadeTransition(
                  opacity: animationFade,
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
