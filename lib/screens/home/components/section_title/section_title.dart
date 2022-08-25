import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/app_provider/utility_provider.dart';

import 'package:untitled1/size_config.dart';

import 'animated_widget.dart';
import 'category_title.dart';

class SectionTitle extends HookConsumerWidget {
  final Function restartAll;
  const SectionTitle({
    required this.restartAll,
    required this.controller,
    Key? key,
    required this.press,
  }) : super(key: key);

  final ScrollController controller;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useScrollController();

    final resraunarisShow = useValueNotifier<String>('1');

    late double offsety = 0;
    useEffect(() {
      // get dy of widget
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final box = context.findRenderObject() as RenderBox;
        offsety = box.localToGlobal(Offset.zero).dy;

// store dy
        ref
            .read(Utility.widgetOffSet.notifier)
            .addwidgetoffset('SectionTitle', offsety);
      });
    });
    final categoryTitle = ref.watch(Utility.categoriesTitle);
    final AllrestaurantsData1 =
        ref.watch(AppStateProvider.restaurantStateMap).values.toList();
    final restaurantDataWithCategories = AllrestaurantsData1.where(
        (element) => element.restaurantCategory == categoryTitle).toList();
    final restaruantisShow = ref.watch(Utility.restaurantIsShow);

    resraunarisShow.value = restaruantisShow;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
      child: Container(
        alignment: Alignment.center,
        height: 50,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CategoryTitle(
              categoryTitle: categoryTitle,
              controller: controller,
              restartAll: restartAll,
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                height: getProportionateScreenHeight(25),
                child: ListView.builder(
                    controller: titleController,
                    // controller: controller,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    // primary: true,
                    itemCount: restaurantDataWithCategories.length,
                    itemBuilder: (context, index) {
                      final restaurantData =
                          restaurantDataWithCategories[index];

                      return HookBuilder(builder: (context) {
                        return AnimatedForEachWidget12(
                          resraunarisShow: resraunarisShow,
                          restaurantData: restaurantData,
                          restaurantIndex: index,
                          restaurantsData: restaurantDataWithCategories,
                          sccollcontroller: controller,
                          titleSccollcontroller: titleController,
                        );
                      });
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// class lineIndicator extends HookConsumerWidget {
//   final ScrollController scrollController;
//   final List<RestaurantModel>? restaurantsData;
//   const lineIndicator({
//     required this.restaurantsData,
//     required this.scrollController,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final widgetOffset = ref.watch(Utility.widgetOffSet).values.toList();
//     StreamController<double> counterController = StreamController<double>();
//     final withOfContainer = 70.0;
//     final paddingContainer = 10.0;
//     final lengRestaurant = restaurantsData!.length;
//     final lengthHorizontal = withOfContainer * lengRestaurant +
//         paddingContainer * (lengRestaurant - 1);
//     double currentLenth = 0.0;
//     // final verticalLength = widgetOffset.last;

//     if (widgetOffset.length > 0) {
//       currentLenth = widgetOffset.last;
//       ;
//     }
//     double testminusofscrooloff = 0.0;
//     scrollController.addListener(() {
//       testminusofscrooloff =
//           1 - ((currentLenth - scrollController.offset) / currentLenth);

//       if (testminusofscrooloff < 0.0) {
//         testminusofscrooloff = 0.0;
//       } else if (testminusofscrooloff > 1) {
//         testminusofscrooloff = 1.0;
//       }

//       // if (testminusofscrooloff == 1) {
//       //           _refreshIndicatorKey.currentState?.show();
//       //   print('testminusofscrooloff');
//       // }
//       counterController.sink.add(testminusofscrooloff);
//     });
//     return StreamBuilder<double>(
//       stream: counterController.stream,
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         return LinearPercentIndicator(
//             lineHeight: 10.0,
//             percent: snapshot.data ?? 0.0,
//             progressColor: Colors.orange,
//             barRadius: Radius.circular(10),
//             backgroundColor: Colors.grey.shade300);
//       },
//     );
//   }
// }

// class AnimatedForEachWidget extends HookConsumerWidget {
//   const AnimatedForEachWidget({
//     required this.scrollController,
//     required this.restaurantsData,
//     required this.resraunarisShow,
//     Key? key,
//     required this.restaurantData,
//     required this.RestaurantIndex,
//   }) : super(key: key);

//   final int RestaurantIndex;

//   final RestaurantModel restaurantData;
//   final List<RestaurantModel>? restaurantsData;
//   final ValueNotifier<String> resraunarisShow;
//   final ScrollController scrollController;
//   // final Animation<double> animationFade;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final animationcontrollerFade =
//         useAnimationController(duration: Duration(milliseconds: 300));
//     final test = useValueListenable(resraunarisShow);
//     final int currentRestaurantIndex = restaurantsData!
//         .indexWhere(((element) => element.restaurantName == test));
//     if (currentRestaurantIndex == RestaurantIndex) {
//       animationcontrollerFade.forward();
//     }
//     final animationColor = ColorTween(begin: Colors.orange, end: Colors.black)
//         .animate(animationcontrollerFade);

//     final animationSliding = Tween(begin: Offset(0, 0), end: Offset(0.2, 0.0))
//         .animate(animationcontrollerFade);
//     final animationScale =
//         Tween(begin: 1.0, end: 0.8).animate(animationcontrollerFade);
//     final animationFade =
//         Tween(begin: 1.0, end: 0.5).animate(animationcontrollerFade);

//     useEffect(() {
//       animationcontrollerFade.addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           animationcontrollerFade.reverse();
//         }
//       });
//     });
//     // -----------------------------
//     return AnimatedBuilder(
//       animation: scrollController,
//       builder: (BuildContext context, Widget? child) {
//         final withOfContainer = 90.0;
//         final paddingContainer = 10.0;
//         double currentLenth = 0;
//         final lengthHorizontal = withOfContainer + paddingContainer;

//         final widgetOffset = ref.watch(Utility.widgetOffSet).values.toList();

//         if (widgetOffset.length > 0) {
//           currentLenth = widgetOffset[currentRestaurantIndex + 2];
//         }

//         double testminusofscrooloff = 0.0;
//         // double test = 0.5;
//         // if (RestaurantIndex == 0) {
//         //   scrollController.addListener(() {
//         //     testminusofscrooloff =
//         //         ((scrollController.offset - currentLenth) / currentLenth) *
//         //             (0.0 - 1.0);
//         //   });
//         // }
//         // print('RestaurantIndex');
//         // print(RestaurantIndex);
//         // print('currentRestaurantIndex');
//         // print(currentRestaurantIndex);
//         // print(currentRestaurantIndex == 0);
//         // ------------------------
//         StreamController<double> counterController = StreamController<double>();
//         // print('RestaurantIndex');
//         // print(RestaurantIndex);
//         // print('currentRestaurantIndex');
//         // print(currentRestaurantIndex);
//         print('currentLenth');
//         print(currentLenth);
//         if (RestaurantIndex == currentRestaurantIndex) {
//           scrollController.addListener(() {
//             testminusofscrooloff =
//                 1 - ((currentLenth - scrollController.offset) / currentLenth);

//             if (testminusofscrooloff < 0.0) {
//               print('333333333');
//               testminusofscrooloff = 0.0;
//             } else if (testminusofscrooloff > 1) {
//               testminusofscrooloff = 1.0;
//               print('4444444444444');
//             }
//             // print('testminusofscrooloff');
//             // print(testminusofscrooloff);
//             counterController.sink.add(testminusofscrooloff);
//             // print('testminusofscrooloff');
//             // print(testminusofscrooloff);
//           });
//         }
// // ------------------------------
//         return Padding(
//           padding: currentRestaurantIndex <= RestaurantIndex
//               ? EdgeInsets.only(right: 10)
//               : EdgeInsets.only(right: 0),
//           child: Container(
//             //     : BoxDecoration(),
//             child: ScaleTransition(
//               scale: animationScale,
//               child: FadeTransition(
//                 opacity: animationFade,
//                 child: StreamBuilder<double>(
//                   stream: counterController.stream,
//                   builder:
//                       (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//                     return LinearPercentIndicator(
//                       width: 170.0,
//                       lineHeight: 20.0,
//                       percent: snapshot.data ?? 0.0,
//                       progressColor: Colors.red,
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//     ;
//   }
// }
