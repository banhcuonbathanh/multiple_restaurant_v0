import 'package:flutter/material.dart';

import 'package:untitled1/screens/home/components/filter/home_header%20filter.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'home_header.dart';

class SearchField extends StatelessWidget {
  final ScrollController controller;
  SearchField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(350),
      // width: SizeConfig.screenWidth * 0.6,
      // decoration: BoxDecoration(
      //   color: kSecondaryColor.withOpacity(0.1),
      //   borderRadius: BorderRadius.circular(15),
      // ),
      child: TextField(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return HomeHeaderFilter(
                  controller: controller,
                );
              });
        },
        onChanged: (value) {
          // showDialog(
          //     context: context,
          //     builder: (context) {
          //       return HomeHeaderFilter();
          //     });
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
