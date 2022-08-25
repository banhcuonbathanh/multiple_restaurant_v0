import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    return errors.length == 0
        ? Text('data')
        : SizedBox(
            height: getProportionateScreenHeight(30),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/Error.svg",
                  height: getProportionateScreenWidth(14),
                  width: getProportionateScreenWidth(14),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(10),
                ),
                Text(errors[0].toString()),
              ],
            )

            // Column(
            //   children: List.generate(
            //       errors.length, (index) => formErrorText(error: errors[index]!)),
            // ),
            );
  }

  // Row formErrorText({required String error}) {
  //   return Row(
  //     children: [
  //       SvgPicture.asset(
  //         "assets/icons/Error.svg",
  //         height: getProportionateScreenWidth(14),
  //         width: getProportionateScreenWidth(14),
  //       ),
  //       SizedBox(
  //         width: getProportionateScreenWidth(10),
  //       ),
  //       Text(error),
  //     ],
  //   );
  // }
}
