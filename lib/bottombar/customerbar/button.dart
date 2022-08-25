import 'package:flutter/material.dart';
import 'package:untitled1/components/custom_buttom.dart';

class buttonbottombar extends StatelessWidget {
  final String contend;
  final Function fuc;
  final Color? color;
  final double customerWith;
  final double customerheight;
  final double customerRadiusCircular;
  const buttonbottombar({
    Key? key,
    required this.contend,
    required this.fuc,
    required this.color,
    required this.customerWith,
    required this.customerheight,
    required this.customerRadiusCircular,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomerButton(
      backgoundColor: color,
      BorderRadiuscircular: customerRadiusCircular,
      buttonHeight: customerheight,
      buttonWidth: customerWith,
      press: () {
        fuc();
      },
      text: contend,
    );
  }
}
