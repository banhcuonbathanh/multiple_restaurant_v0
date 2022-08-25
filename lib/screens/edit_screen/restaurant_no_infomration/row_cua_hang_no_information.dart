import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:untitled1/size_config.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class RowCuaHangNoInformation extends HookConsumerWidget {
  final TextEditingController restaurantController;

  final String? restaurantName;

  RowCuaHangNoInformation(
      {required this.restaurantController, this.restaurantName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleAnimationController = useAnimationController(
        initialValue: 1,
        lowerBound: 0,
        upperBound: 1,
        duration: Duration(milliseconds: 800));
    // TickerFuture tickerFuture = titleAnimationController.repeat();
    // tickerFuture.timeout(Duration(seconds: 3 * 5), onTimeout: () {
    //   titleAnimationController.forward(from: 0);
    //   titleAnimationController.stop(canceled: true);
    // });
    // final sequenceAnimation = SequenceAnimationBuilder()
    //     .addAnimatable(
    //         animatable: new Tween<double>(begin: 0, end: 0.5),
    //         from: Duration(seconds: 0),
    //         to: Duration(milliseconds: 100),
    //         tag: "scale")
    //     .addAnimatable(
    //         animatable: new Tween<double>(begin: 0.2, end: -0.2),
    //         from: const Duration(milliseconds: 100),
    //         to: const Duration(milliseconds: 200),
    //         tag: "scale",
    //         curve: Curves.easeOut)
    //     .addAnimatable(
    //         animatable: new Tween<double>(begin: -0.2, end: 0),
    //         //  animatable: new Tween<double>(begin: 200.0, end: 40.0),
    //         from: const Duration(milliseconds: 200),
    //         to: const Duration(milliseconds: 300),
    //         tag: "scale",
    //         curve: Curves.fastOutSlowIn)
    //     .animate(titleAnimationController);
    // print(sequenceAnimation['scale'].value);
    // int repeats = 0;
    // final rotatingValueinput = useState<double>(-0.02);
    final isUserInput = useState<bool>(true);
    final isShowTextFormField = useState<bool>(true);
    // final torresta = useState<bool>(true);
    final titleFadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(titleAnimationController);
    // ..addStatusListener((status) {
    // if (repeats < 5) {
    //   if (status == AnimationStatus.completed) {
    //     print('1');
    //     titleAnimationController.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     print('2');
    //     titleAnimationController.forward();
    //   }
    //   repeats++;
    //   // rotatingValueinput.value = 0;
    // }

    // print(repeats);
    // if (repeats == 20) {
    //   print('repeats == 19');
    //   torresta.value = !torresta.value;
    // }
    // });
    // print('out of loop');
    // torresta.value = !torresta.value;
    // final titleRotatingAnimation = Tween<double>(begin: 0.02, end: -0.02)
    //     .animate(titleAnimationController);

    // final titleSlidingAnimation = TweenSequence(<TweenSequenceItem<double>>[
    //   TweenSequenceItem<double>(
    //       tween: Tween<double>(begin: 0, end: 1), weight: 50),
    //   TweenSequenceItem<double>(
    //       tween: Tween<double>(begin: 1, end: 0), weight: 50),
    // ]).animate(titleAnimationController);

    final titleSlidingAnimation =
        Tween<Offset>(begin: Offset(0.05, 0), end: Offset(0, 0)).animate(
            CurvedAnimation(
                parent: titleAnimationController, curve: Curves.elasticIn));
    // final titleColorAnimation = ColorTween(begin: Colors.black, end: Colors.red)
    //     .animate(CurvedAnimation(
    //         parent: titleAnimationController, curve: Curves.elasticIn));
    // Animation colorsAnimationTitle =
    //     ColorTween(begin: Colors.red, end: Colors.black45).animate(
    //         CurvedAnimation(
    //             parent: titleAnimationController, curve: Curves.elasticIn));
    useEffect(() {
      if (restaurantName != null) {
        isShowTextFormField.value = false;
      }
      titleAnimationController.addStatusListener((status) {
        // print('status');
        // print(status);
        // if (status == AnimationStatus.completed) {
        //   isUserInput.value = true;
        // }
        if (status == AnimationStatus.dismissed) {
          // isUserInput.value = false;
          titleAnimationController.forward();
        }
      });
      return () {};
    });

    // print('build RowCuaHangNoInformation');
    // print('widget.restaurantName!');
    // print(widget.restaurantName!);
    final isUserInputFunc2 = () {
      isUserInput.value = false;
    };
    var isUserInputFuncTrue2 = () {
      isUserInput.value = true;
    };

    // sequenceAnimation["scale"].value
    return Row(
      children: [
        // AnimatedBuilder(
        //     animation: titleAnimationController,
        //     builder: (BuildContext context, Widget? child) {
        //       return Container(
        //         transform: Matrix4.skewY(0.0)
        //           ..rotateX(sequenceAnimation['scale'].value),
        //         child: Text(
        //           'teset:',
        //           style: TextStyle(),
        //         ),
        //       );
        //     }),
        //'Cửa Hàng :'
        FadeTransition(
          opacity: titleFadeAnimation,
          child: SlideTransition(
            position: titleSlidingAnimation,
            child: Text(
              'Cửa Hàng :',
              style: TextStyle(
                  color: isUserInput.value ? Colors.black : Colors.red),
            ),
          ),
        ),

        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        if (isShowTextFormField.value)
          Container(
            // color: Colors.blue,
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(150),
            child: buildTextFormFieldRestaurantName1(
              ref: ref,
              restaurantController: restaurantController,
              context: context,
              isUserInputFunc: isUserInputFunc2,
              isUserInputFuncTrue: isUserInputFuncTrue2,
              titleAnimationController: titleAnimationController,
              isUserInput: isUserInput.value,
              // isUserInputFunc: () {
              //   setState(() {
              //     isUserInput = false;
              //   });
              // }
            ),
          ),
        // --------------------------------------
        if (!isShowTextFormField.value)
          Container(
            alignment: Alignment.centerLeft,
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(150),
            child: GestureDetector(
              onTap: () {
                isShowTextFormField.value = true;
                restaurantController.text = '';
              },
              child: Text(
                  restaurantController.text != ''
                      ? restaurantController.text
                      : restaurantName!,
                  style: TextStyle(fontSize: getProportionateScreenHeight(14))),
            ),
          ),
      ],
    );
  }
}

Widget buildTextFormFieldRestaurantName1(
    {required TextEditingController restaurantController,
    required WidgetRef ref,
    required BuildContext context,
    required Function isUserInputFunc,
    required Function isUserInputFuncTrue,
    required bool isUserInput,
    required AnimationController titleAnimationController}) {
  return TextFormField(
    style: TextStyle(fontSize: getProportionateScreenHeight(14)),
    controller: restaurantController,
    keyboardType: TextInputType.emailAddress,
    onChanged: (value) {
      isUserInputFuncTrue();
    },
    onSaved: (value) {
      restaurantController.text = value!;
    },
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        // borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      // border: new OutlineInputBorder(
      //   borderRadius: new BorderRadius.circular(1.0),
      //   borderSide: new BorderSide(),
      // ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(1),
          vertical: getProportionateScreenHeight(1)),
      hintText: 'Nhập Tên Quán', fillColor: Colors.red,
    ),
    validator: (value) {
      if (value!.isEmpty) {
        isUserInputFunc();

        TickerFuture tickerFuture = titleAnimationController.repeat();
        tickerFuture.timeout(Duration(seconds: 2), onTimeout: () {
          titleAnimationController.forward(from: 0);
          titleAnimationController.stop(canceled: true);
          titleAnimationController.reverse();
        });

        // titleAnimationController.forward();
        // print('test');
        // isUserInput
        //     ? titleAnimationController.reverse()
        //     : titleAnimationController.forward();
        // print(titleAnimationController.status);
        // if (titleAnimationController.status == AnimationStatus.completed) {
        //   titleAnimationController.reset();
        //   print('test');
        // }

        return;
      }

      return null;
    },
  );
}

class ShakeTransition extends StatelessWidget {
  const ShakeTransition(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 900),
      this.offset = 140.0,
      this.axis = Axis.horizontal})
      : super(key: key);
  final Widget child;
  final Duration duration;
  final double offset;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        child: child,
        tween: Tween(begin: 0, end: 1),
        duration: duration,
        curve: Curves.bounceInOut,
        builder: (context, value, child1) {
          return Transform.translate(
            offset: axis == Axis.horizontal
                ? Offset(value * offset, 0.0)
                : Offset(0.0, value * offset),
            child: child,
          );
        });
  }
}
