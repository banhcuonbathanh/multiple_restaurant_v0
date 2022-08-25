import 'package:flutter/material.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/model/topping_model.dart';

import '../../../../../size_config.dart';
import '../../favorite_screen/favorite_screen.dart';
import '../../favorite_screen/topping_with_inform_favorite.dart';

class ToppingButtonOrder extends StatefulWidget {
  const ToppingButtonOrder({
    Key? key,
    required this.toppingsProduct,
    required this.restart,
  }) : super(key: key);

  final List<ToppingModel> toppingsProduct;
  final ValueNotifier<bool> restart;

  @override
  State<ToppingButton> createState() => _ToppingButtonState();
}

class _ToppingButtonState extends State<ToppingButton> {
  var isShow = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: false,
      children: [
        if (isShow)
          for (var index = 0; index < widget.toppingsProduct.length; index++)
            ToppingWithInformFavorite(
              toppingModel: widget.toppingsProduct.elementAt(index),
              restartFunc: () {
                widget.restart.value = !widget.restart.value;
              },
            ),
        if (isShow)
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
        CustomerButton(
            text: ('Tuy Chon'),
            press: () async {
              setState(() {
                isShow = !isShow;
              });
            },
            buttonHeight: getProportionateScreenHeight(30),
            buttonWidth: double.infinity,
            BorderRadiuscircular: 10,
            backgoundColor: null),
      ],
    );
  }
}
