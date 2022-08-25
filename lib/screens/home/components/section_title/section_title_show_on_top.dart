import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:untitled1/components/custom_container.dart';
import 'package:untitled1/size_config.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/app_provider/utility_provider.dart';
import 'animated_widget.dart';
import 'section_title.dart';

class ShowSectionTitleOnTop extends StatelessWidget {
  final Function restartAll;
  const ShowSectionTitleOnTop({
    Key? key,
    required this.restartAll,
    required this.isShowtitleontop,
    required this.scroller,
  }) : super(key: key);

  final ValueNotifier<bool> isShowtitleontop;
  final ScrollController scroller;
  @override
  Widget build(BuildContext context) {
    return HookBuilder(builder: (context) {
      final test = useValueListenable(isShowtitleontop);
      return !test
          ? Text('')
          : SizedBox(
              height: getProportionateScreenHeight(60),
              child: CustomContainer(
                bottompadding: 10,
                child: SectionTitle(
                  controller: scroller,
                  press: () {},
                  restartAll: restartAll,
                ),
              ),
            );
    });
  }
}

class SectionTitle12 extends HookConsumerWidget {
  const SectionTitle12({
    required this.controller,
    Key? key,
    required this.press,
  }) : super(key: key);

  final ScrollController controller;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyCategoryTitle = GlobalKey();
    final titleController = useScrollController();
    //  ---------------------------
    // animation
    // final animationcontrollerFade =
    //     useAnimationController(duration: Duration(milliseconds: 500));
    // final animationSliding = Tween(begin: Offset(0, 0), end: Offset(1, 0))
    //     .animate(animationcontrollerFade);
    // final animationFade =
    //     Tween(begin: 1.0, end: 0.0).animate(animationcontrollerFade);
    // print('animationcontrollerFade.status');
    // print(animationcontrollerFade.status);

    // useEffect(() {
    //   animationcontrollerFade.addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       print('objectobjectobjectobjectobjectobjectobject');
    //       animationcontrollerFade.reverse();
    //     }
    //   });
    // });
    // -----------------------------
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
        alignment: Alignment.topCenter,
        height: 50,
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(categoryTitle!),
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
            // SizedBox(
            //   height: 10,
            // ),
            // lineIndicator(
            //   scrollController: controller,
            //   restaurantsData: restaurantsData,
            // )
          ],
        ),
      ),
    );
  }
}
