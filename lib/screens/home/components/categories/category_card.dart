import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/utility_provider.dart';

class CategoryCard1 extends HookConsumerWidget {
  const CategoryCard1({
    Key? key,
    required this.categoryIndexValue,
    required this.icon,
    required this.categoryName,
    required this.press,
    required this.buildIndexValue,
  }) : super(key: key);
// // width: getProportionateScreenWidth(105),
//       height: getProportionateScreenWidth(95),
//       alignment: Alignment.center,
  final String? icon, categoryName;
  final GestureTapCallback press;
  final int categoryIndexValue;
  final int buildIndexValue;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryTitle = ref.watch(Utility.categoriesTitle);

    return Expanded(
      child: GestureDetector(
        onTap: press,
        child: Blur(
          colorOpacity: categoryName == categoryTitle ? 0 : 0.5,
          blur: categoryName == categoryTitle ? 0 : 1.5,
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.network(icon!),
                SizedBox(height: 5),
                Text(categoryName!, textAlign: TextAlign.center)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
