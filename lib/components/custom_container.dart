import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled1/size_config.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {Key? key,
      required this.child,
      required this.bottompadding,
      this.containerHeight,
      this.borderRadius,
      this.leftPadding,
      this.rightPadding})
      : super(key: key);
  final Widget child;
  final double bottompadding;
  final double? containerHeight;
  final double? borderRadius;
  final double? leftPadding;
  final double? rightPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenHeight(5),
          right: getProportionateScreenHeight(5),
          bottom: getProportionateScreenHeight(bottompadding)),
      child: Container(
        height: containerHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green.shade100),
            borderRadius: BorderRadius.circular(borderRadius ?? 20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.3),
              ),
            ]),
        child: child,
      ),
    );
  }
}
