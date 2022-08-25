import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'button.dart';
import 'firstchild.dart';
import 'secondchild.dart';

class customerBottomBar extends HookConsumerWidget {
  const customerBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restart = useState(true);

    final parentIndex = useState(0);
    final buttonIndex = useState(0);
    List<Color> listOfColors = [
      Color(0xffBDCBFE),
      Color(0xffFFCDFF),
      Color(0xffFFC6C1),
      Color(0xffFFE8A7),
      Color(0xff8DECA6),
    ];
    // ------------------------------------

    final changingWidthCon = useAnimationController(
      duration: Duration(milliseconds: 400),
    );
    final changingWidthAni = Tween<double>(begin: 1, end: .85).animate(
        CurvedAnimation(
            parent: changingWidthCon,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn))
      ..addListener(() {
        restart.value = !restart.value;
        // print('object');
        // setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          changingWidthCon.reverse();
          // tBHeightCon.forward();
        }
      });
    // ------------------------------------

    final changingWidthConButton = useAnimationController(
      duration: Duration(milliseconds: 1500),
    );
    final changingWidthButtonAni = Tween<double>(begin: 1, end: .3).animate(
        CurvedAnimation(
            parent: changingWidthConButton,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn))
      ..addListener(() {
        restart.value = !restart.value;
        // print('object');
        // setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          changingWidthConButton.reverse();
          // tBHeightCon.forward();
        }
      });
    // ------------------------------------
    final changingColors = useAnimationController(
      duration: Duration(milliseconds: 2000),
    );

    final changingColorsAni =
        ColorTween(begin: Colors.grey.shade200, end: Colors.orange.shade200)
            .animate(CurvedAnimation(
                parent: changingColors,
                curve: Curves.easeOut,
                reverseCurve: Curves.ease))
          ..addListener(() {
            restart.value = !restart.value;
            // print('object');
            // setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // changingColors.reverse();
            }
          });

    // -----------------------------------
    final goUpDown = useAnimationController(
      duration: Duration(milliseconds: 600),
    );
    final goDownAni = Tween<double>(begin: 0.0, end: 0.5)
        .animate(CurvedAnimation(parent: goUpDown, curve: Curves.easeOutCubic))
      ..addListener(() {
        restart.value = !restart.value;
        // setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // goUpCon.reverse();
          // oneToZeroCon.forward();
          goUpDown.reverse();
        }
      });

    // -----------------------------------
    final goUpCon = useAnimationController(
      duration: Duration(milliseconds: 600),
    );
    final goUpAni = Tween<double>(begin: 0.0, end: -0.5)
        .animate(CurvedAnimation(parent: goUpCon, curve: Curves.easeOutCubic))
      ..addListener(() {
        restart.value = !restart.value;
        // setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          goUpCon.reverse().then((value) => goUpDown.forward());
          // goUpDown.forward();
          // oneToZeroCon.forward();
        }
      });
    // ------------------------------------

    final transCon = useAnimationController(
      duration: Duration(milliseconds: 1500),
    );
    final transAni = Tween<double>(begin: 0.0, end: -85.0)
        .animate(CurvedAnimation(parent: transCon, curve: Curves.easeOutCubic))
      ..addListener(() {
        restart.value = !restart.value;
        // setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // oneToZeroCon.forward();
        }
      });
    // ------------------------------
    final oneToZeroCon = useAnimationController(
      duration: Duration(milliseconds: 200),
    );

    final oneToZeroAnim =
        Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: oneToZeroCon,
      curve: Curves.easeIn,
    ))
          ..addListener(() {
            restart.value = !restart.value;
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              transCon.reset();
              oneToZeroCon.reverse();
            }
          });
    // test({required String number, required Function safd}) {
    //   safd();
    //   print(number);
    // }

    // safd({required String number}) {
    //   goUpCon.forward();
    //   print(number);
    // }

    // --------------------------------
    // final changeWith = useState(false);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: 40,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        child: Center(
          child: Stack(
            children: [
              firstChild(
                // changingWidthAni: changingWidthAni,
                goDownAni: goDownAni,
                goUpAni: goUpAni,
                // changingWidthConButton: changingWidthConButton,
                // changingColors: changingColors,
                goUpCon: goUpCon,
                // changingColorsAni: changingColorsAni,
                // changingWidthButtonAni: changingWidthButtonAni,
                func: () {},
                parentIndex: parentIndex.value,
                buttonIndex: buttonIndex.value,
                changingWidthButtonAni: changingWidthButtonAni,
              ),
              SecondChild(
                changingWidthAni: changingWidthAni,
                // goDownAni: goDownAni,
                // goUpAni: goUpAni,
                changingWidthConButton: changingWidthConButton,
                changingColors: changingColors,
                // goUpCon: goUpCon,
                changingColorsAni: changingColorsAni,

                func12: () {
                  goUpCon.forward();
                  buttonIndex.value = 0;

                  restart.value = !restart.value;
                  // print('sdfsdfs');
                },
                func22: () {
                  goUpCon.forward();
                  buttonIndex.value = 1;

                  restart.value = !restart.value;
                },
                buttonIndex: buttonIndex.value,
                func32: () {
                  goUpCon.forward();
                  buttonIndex.value = 2;

                  restart.value = !restart.value;
                },
                func42: () {
                  goUpCon.forward();
                  buttonIndex.value = 3;

                  restart.value = !restart.value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
