import 'package:flutter/material.dart';
import 'package:untitled1/size_config.dart';

class SnackbarContend extends StatelessWidget {
  const SnackbarContend({
    Key? key,
    required this.contend,
  }) : super(key: key);
  final String contend;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
      height: getProportionateScreenHeight(70),
      decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Text(
        contend,
        style: TextStyle(
            fontSize: getProportionateScreenHeight(15), color: Colors.white),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

void CustomScaffoldMessger({
  required BuildContext context,
  required String contend,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: SnackbarContend(
      contend: contend,
    ),
    action: SnackBarAction(
      label: 'close',
      textColor: Colors.red,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
  ));
}
