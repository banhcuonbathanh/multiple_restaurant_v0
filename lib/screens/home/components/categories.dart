import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/screens/home/components/categories/categoriesCustomer.dart';

import '../../../size_config.dart';

// class Categories extends HookConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     List<Map<String, dynamic>> categories = [
//       {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
//     ];
//     return Padding(
//         padding: EdgeInsets.all(getProportionateScreenWidth(20)),
//         child: CategoriesCustomer()

//         // Row(
//         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //     crossAxisAlignment: CrossAxisAlignment.start,
//         //     children: [
//         //       // CategoryCard(
//         //       //   icon: categories[0]["icon"],
//         //       //   text: categories[0]["text"],
//         //       //   press: () async {
//         //       //     ref
//         //       //         .read(AppStateProvider.categoriesNotifier.notifier)
//         //       //         .createCategory(
//         //       //             categoryImage: 'sadf',
//         //       //             categoryName: 'categoryName',
//         //       //             categoryId: '1',
//         //       //             ship: true,
//         //       //             booking: true);
//         //       //     print('object');
//         //       //     print(0);
//         //       //   },
//         //       // ),

//         //       // Categories()
//         //     ]),
//         );
//   }
// }

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
