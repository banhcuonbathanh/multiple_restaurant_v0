import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/helper/custom_page_route.dart';
import 'package:untitled1/screens/profile/profile_screen.dart';

import 'button.dart';

class firstChild extends HookConsumerWidget {
  const firstChild({
    required this.changingWidthButtonAni,
    Key? key,

    // required this.changingWidthAni,
    required this.goDownAni,
    required this.goUpAni,
    // required this.changingWidthConButton,
    // required this.changingColors,
    required this.goUpCon,
    // required this.changingColorsAni,
    // required this.changingWidthButtonAni,
    required this.func,
    required this.parentIndex,
    required this.buttonIndex,
  }) : super(key: key);

  // final Animation<double> changingWidthAni;
  final Animation<double> goDownAni;
  final Animation<double> goUpAni;
  // final AnimationController changingWidthConButton;
  // final AnimationController changingColors;
  final AnimationController goUpCon;
  // final Animation<Color?> changingColorsAni;
  // final Animation<double> changingWidthButtonAni;
  final Function func;
  final int parentIndex;
  final int buttonIndex;
  final Animation<double> changingWidthButtonAni;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    final restart = useState(true);

    final index = 1;

    // }
    return Container(
      // alignment: Alignment.bottomCenter,
      height: 30,
      width: screenWidth,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Transform.translate(
            offset: Offset(0, buttonIndex == 0 ? goUpAni.value * 100 : 0),
            child: buttonbottombar(
              contend: buttonIndex == 0 ? '1-1' : "",
              fuc: () {
                // Navigator.of(context)
                //     .push(CustomPageRoute(child: ProfileScreen()));
                goUpCon.forward();
              },
              color: Colors.orange.withOpacity(buttonIndex == 0 ? 1 : 0),
              customerWith: 70 * changingWidthButtonAni.value,
              customerheight: 30, customerRadiusCircular: 20,
              // buttonIndex == 0 ? 70 * changingWidthButtonAni.value : 70,
            ),
          ),
          Transform.translate(
            offset: Offset(0, buttonIndex == 1 ? goUpAni.value * 100 : 0),
            child: buttonbottombar(
              contend: buttonIndex == 1 ? '2-1' : "",
              fuc: () {
                Navigator.of(context)
                    .push(CustomPageRoute(child: ProfileScreen()));
                func();

                // changingWidthConButton.forward();
                // changingColors.forward();
                if (buttonIndex == 1) {
                  goUpCon.forward();
                }

                // if (changingColorsAni.status == AnimationStatus.completed) {
                //   changingColors.reverse();
                // }
              },
              color: Colors.orange.withOpacity(buttonIndex == 1 ? 1 : 0),
              customerWith: 70,
              customerheight: 20,
              customerRadiusCircular: 10,
            ),
          ),
          Transform.translate(
            offset: Offset(0, buttonIndex == 2 ? goUpAni.value * 100 : 0),
            child: buttonbottombar(
              contend: buttonIndex == 2 ? '3-1' : "",
              fuc: () {
                func();

                // changingWidthConButton.forward();
                // changingColors.forward();
                goUpCon.forward();
                // if (changingColorsAni.status == AnimationStatus.completed) {
                //   changingColors.reverse();
                // }
              },
              color: Colors.orange.withOpacity(buttonIndex == 2 ? 1 : 0),
              customerWith: 70,
              customerheight: 10,
              customerRadiusCircular: 10,
            ),
          ),
          Transform.translate(
            offset: Offset(0, buttonIndex == 3 ? goUpAni.value * 100 : 0),
            child: buttonbottombar(
              contend: buttonIndex == 3 ? '4-1' : "",
              fuc: () {
                func();

                // changingWidthConButton.forward();
                // changingColors.forward();
                goUpCon.forward();
                // if (changingColorsAni.status == AnimationStatus.completed) {
                //   changingColors.reverse();
                // }
              },
              color: Colors.orange.withOpacity(buttonIndex == 3 ? 1 : 0),
              customerWith: 70,
              customerheight: 20,
              customerRadiusCircular: 10,
            ),
          ),
        ],
      ),
    );
  }
}
