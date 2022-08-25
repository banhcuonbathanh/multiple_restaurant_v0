import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/utility_provider.dart';
import 'package:untitled1/size_config.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class RestaurantTitle extends HookConsumerWidget {
  final String restaurantName;
  final int index;
  final ScrollController controller;
  const RestaurantTitle(
      {required this.controller,
      required this.index,
      Key? key,
      required this.restaurantName})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationIsHalf = useState(true);
    final slidingTransitionCon =
        useAnimationController(duration: Duration(microseconds: 500));
    final animationSliding =
        Tween<Offset>(begin: Offset(1.5, 0.0), end: Offset(0.0, 0.0))
            .animate(slidingTransitionCon);

    late double offsety = 0;
    double location = 0;
    final deviceheigh = MediaQuery.of(context).size.height;

    final widgetoffsetData = ref.watch(Utility.widgetOffSet);

// -----------------------------------------------
//     useEffect(() {
//       // get dy of widget
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         final box = context.findRenderObject() as RenderBox;
//         location = box.localToGlobal(Offset.zero).dy - deviceheigh / 2;

// // store dy
//         ref
//             .read(Utility.widgetOffSet.notifier)
//             .addwidgetoffset(restaurantName, location);
//       });
//     });
// -------------------------------------------------

    useEffect(() {
      // get dy of widget
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final box = context.findRenderObject() as RenderBox;
        location = box.localToGlobal(Offset.zero).dy + controller.offset;

// store dy
        ref
            .read(Utility.widgetOffSet.notifier)
            .addwidgetoffset(restaurantName, location);
      });
    });
// -------------------------------------------------
    useEffect(() {
      controller.addListener(
        () {
          // print('<<<<<<<<<<<<<<<<<<<<<<<<<<');
          final box = context.findRenderObject() as RenderBox;
          offsety = box.localToGlobal(Offset.zero).dy;

          if (offsety < (deviceheigh) / 2 && offsety > 0) {
            ref
                .read(Utility.restaurantIsShow.notifier)
                .isOnScreen(restaurantName: restaurantName);

            // print(locationIsHalf.value);
            // print('<<<<<<<<<<<<<<<<<');
          } else {
            // print(locationIsHalf.value);
          }
          if (offsety < (deviceheigh) - 150 && offsety > 0) {
            locationIsHalf.value = false;
            // print(locationIsHalf.value);
            // print('<<<<<<<<<<<<<<<<<');
          } else {
            locationIsHalf.value = true;
            // print(locationIsHalf.value);
          }
        },
      );
    }, [controller]);

    useEffect(() {
      return () {};
    });
    // print(offsety);
    // useEffect(() {
    //   print('<<<<<<<<<<<<<<,');
    //   print(restaurantName);
    // });

    return Row(
      children: [
        Text('Quán :  '),
        index.isEven
            ? AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    '${restaurantName}',
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
                totalRepeatCount: 4,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              )
            : AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('${restaurantName}'),
                ],
                isRepeatingAnimation: true,
              ),
      ],
    );
  }
}
