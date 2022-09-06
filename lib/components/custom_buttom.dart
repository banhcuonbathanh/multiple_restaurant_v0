import 'package:flutter/material.dart';
import 'package:untitled1/size_config.dart';

import '../constants.dart';

class CustomerButton extends StatelessWidget {
  const CustomerButton({
    Key? key,
    required this.text,
    required this.press,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.BorderRadiuscircular,
    required this.backgoundColor,
    this.child,
    this.fontSize,
  }) : super(key: key);
  final Widget? child;
  final String text;
  final Function press;
  final double buttonHeight;
  final double buttonWidth;
  final double BorderRadiuscircular;
  final Color? backgoundColor;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function()?,
      child: Container(
        alignment: Alignment.center,
        width: getProportionateScreenWidth(buttonWidth),
        height: getProportionateScreenHeight(buttonHeight),
        decoration: BoxDecoration(
            color: backgoundColor == null ? kPrimaryColor : backgoundColor,
            borderRadius: BorderRadius.circular(BorderRadiuscircular)),
        child: child ??
            Text(
              text,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(fontSize ?? 14),
                color: backgoundColor == null
                    ? Colors.white
                    : Colors.grey.shade600,
              ),
            ),
      ),
    );
  }
}
