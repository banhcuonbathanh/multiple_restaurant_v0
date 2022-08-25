import 'package:flutter/material.dart';
import 'package:untitled1/helper/custom_page_route.dart';
import 'package:untitled1/screens/profile/profile_screen.dart';

import 'button.dart';

class SecondChild extends StatelessWidget {
  const SecondChild({
    Key? key,
    required this.changingWidthAni,
    // required this.goDownAni,
    // required this.goUpAni,
    required this.changingWidthConButton,
    required this.changingColors,
    required this.changingColorsAni,
    required this.func12,
    required this.func22,
    required this.buttonIndex,
    required this.func32,
    required this.func42,
  }) : super(key: key);

  final Animation<double> changingWidthAni;
  // final Animation<double> goDownAni;
  // final Animation<double> goUpAni;
  final AnimationController changingWidthConButton;
  final AnimationController changingColors;
  // final AnimationController goUpCon;
  final Animation<Color?> changingColorsAni;

  final Function func12;
  final Function func22;
  final Function func32;
  final Function func42;
  final int buttonIndex;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      // alignment: Alignment.bottomCenter,
      height: 30,
      width: screenWidth * changingWidthAni.value,
      color: Colors.blue.withOpacity(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buttonbottombar(
            contend: buttonIndex == 0 ? '' : '1-2',
            fuc: () {
              func12();
              // Navigator.of(context)
              //     .push(CustomPageRoute(child: ProfileScreen()));
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return ProfileScreen();
                  },
                  opaque: false));
              changingWidthConButton.forward();
              changingColors.forward();
              if (changingColorsAni.status == AnimationStatus.completed) {
                changingColors.reverse();
              }
            },
            color: buttonIndex == 0
                ? changingColorsAni.value!.withOpacity(buttonIndex == 0 ? 0 : 1)
                : Colors.grey.shade300,
            customerWith: 70,
            customerheight: 20,
            customerRadiusCircular: 10,
          ),
          buttonbottombar(
            contend: buttonIndex == 1 ? '' : '2-2',
            fuc: () {
              func22();

              changingWidthConButton.forward();
              changingColors.forward();
              if (changingColorsAni.status == AnimationStatus.completed) {
                changingColors.reverse();
              }
            },
            color: buttonIndex == 1
                ? changingColorsAni.value!.withOpacity(buttonIndex == 1 ? 0 : 1)
                : Colors.grey.shade300,
            customerWith: 70,
            customerheight: 20,
            customerRadiusCircular: 10,
          ),
          buttonbottombar(
            contend: buttonIndex == 2 ? '' : '3-2',
            fuc: () {
              func32();

              changingWidthConButton.forward();
              changingColors.forward();
              if (changingColorsAni.status == AnimationStatus.completed) {
                changingColors.reverse();
              }
            },
            color: buttonIndex == 2
                ? changingColorsAni.value!.withOpacity(buttonIndex == 2 ? 0 : 1)
                : Colors.grey.shade300,
            customerWith: 70,
            customerheight: 20,
            customerRadiusCircular: 10,
          ),
          buttonbottombar(
            contend: buttonIndex == 3 ? '' : '4-2',
            fuc: () {
              func42();

              changingWidthConButton.forward();
              changingColors.forward();
              if (changingColorsAni.status == AnimationStatus.completed) {
                changingColors.reverse();
              }
            },
            color: buttonIndex == 3
                ? changingColorsAni.value!.withOpacity(buttonIndex == 3 ? 0 : 1)
                : Colors.grey.shade300,
            customerWith: 70,
            customerheight: 20,
            customerRadiusCircular: 10,
          ),
        ],
      ),
    );
  }
}
