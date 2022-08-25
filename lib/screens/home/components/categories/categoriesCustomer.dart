import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:blur/blur.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/app_provider/utility_provider.dart';
import 'package:untitled1/model/category_model.dart';
import 'package:untitled1/size_config.dart';

import 'category_card.dart';

class CategoriesCustomer extends HookConsumerWidget {
  final Function restartAll;

  CategoriesCustomer({
    required this.restartAll,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesList = ref.watch(AppStateProvider.categoriesNotifier);

    // var _currenttab = useValueNotifier(0);

    // double selectionPositionX = 79.25;

    // GlobalKey _key0 = GlobalKey();
    // GlobalKey _key1 = GlobalKey();

    // setWidgePosion(GlobalKey selectKey) {
    //   final RenderBox widgetREnderBox =
    //       selectKey.currentContext!.findRenderObject() as RenderBox;
    //   final widgetPosition = widgetREnderBox.localToGlobal(Offset.zero);
    //   selectionPositionX = widgetPosition.dx;

    //   // print('selectionPositionX ${selectionPositionX}');
    // }

    // useEffect(() {
    //   sccollcontroller.animateTo(20,
    //       duration: Duration(milliseconds: 100), curve: Curves.ease);
    // });

    // useEffect(() {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     setWidgePosion(_key0);
    //   });
    // });
    // selectionItem(int id) {
    //   _currenttab.value = id;

    //   GlobalKey selectglobalkey = _key0;
    //   switch (id) {
    //     case 0:
    //       selectglobalkey = _key0;
    //       break;

    //     case 1:
    //       selectglobalkey = _key1;
    //       break;

    //     default:
    //   }
    //   setWidgePosion(selectglobalkey);
    // }

    final categoryIndex = useValueNotifier<int>(0);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: categoryasync(
        categoriesList: categoriesList,
        categoryIndex: categoryIndex,
        restartAll: () {
          restartAll();
        },
      ),
    );
  }
}

class categoryasync extends HookConsumerWidget {
  const categoryasync({
    required this.restartAll,
    Key? key,
    required this.categoriesList,
    required this.categoryIndex,
  }) : super(key: key);

  final List<CategoryModel> categoriesList;
  final ValueNotifier<int> categoryIndex;
  final Function restartAll;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              categoriesList.length,
              (index) => HookBuilder(builder: (context) {
                final categoryBuilder = useValueListenable(categoryIndex);
                final category = categoriesList[index];
                return CategoryCard1(
                  icon: category.categoryImage,
                  categoryName: category.categoryName,
                  categoryIndexValue: categoryIndex.value,
                  buildIndexValue: index,
                  press: () async {
                    categoryIndex.value = index;
                    ref
                        .read(Utility.categoriesTitle.notifier)
                        .categoriesTitleOnScreen(
                            categoriesTitle: category.categoryName!);
                    final test = await ref
                        .read(AppStateProvider.restaurantStateMap.notifier)
                        .controllGetLoadingData(
                            categoryName: 'Đồ Uống',
                            page: 0,
                            numberOfRestaurant: 0);
                    restartAll();
                  },
                );
              }),
            ),
          ),
          HookBuilder(builder: (context) {
            final asdfs = useValueListenable(categoryIndex);

            return AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              curve: Curves.fastLinearToSlowEaseIn,
              left: asdfs == 0
                  ? 10
                  : asdfs == 1
                      ? 130
                      : 250,
              bottom: 0,
              child: Container(
                width: getProportionateScreenWidth(100),
                height: getProportionateScreenHeight(4),
                decoration: ShapeDecoration(
                    shape: StadiumBorder(), color: Colors.orange.shade200),
              ),
            );
          })
        ],
      ),
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: List.generate(
    //     categoriesList.d.length,
    //     (index) => HookBuilder(builder: (context) {
    //       final categoryBuilder = useValueListenable(categoryIndex);
    //       final category = categoriesList[index];
    //       return CategoryCard(
    //         icon: category.categoryImage,
    //         text: category.categoryName,
    //         categoryIndexValue: categoryIndex.value,
    //         buildIndexValue: index,
    //         press: () {
    //           categoryIndex.value = index;
    //         },
    //       );
    //     }),
    //   ),
    // );
  }
}

// class categoryasync1 extends StatelessWidget {
//   const categoryasync1({
//     Key? key,
//     required this.categoriesList,
//     required this.categoryIndex,
//   }) : super(key: key);

//   final AsyncValue<List<Category>> categoriesList;
//   final ValueNotifier<int> categoryIndex;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: List.generate(
//         categoriesList.d.length,
//         (index) => HookBuilder(builder: (context) {
//           final categoryBuilder = useValueListenable(categoryIndex);
//           final category = categoriesList[index];
//           return CategoryCard(
//             icon: category.categoryImage,
//             text: category.categoryName,
//             categoryIndexValue: categoryIndex.value,
//             buildIndexValue: index,
//             press: () {
//               categoryIndex.value = index;
//             },
//           );
//         }),
//       ),
//     );
//   }
// }

// class CategoryCard extends StatelessWidget {
//   const CategoryCard({
//     Key? key,
//     required this.categoryIndexValue,
//     required this.icon,
//     required this.text,
//     required this.press,
//     required this.buildIndexValue,
//   }) : super(key: key);

//   final String? icon, text;
//   final GestureTapCallback press;
//   final int categoryIndexValue;
//   final int buildIndexValue;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       child: Container(
//         width: getProportionateScreenWidth(105),
//         height: getProportionateScreenWidth(95),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(15)),
//         child: GestureDetector(
//           onTap: press,
//           child: Blur(
//             colorOpacity: categoryIndexValue == buildIndexValue ? 0 : 0.5,
//             blur: categoryIndexValue == buildIndexValue ? 0 : 1.5,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SvgPicture.asset(icon!),
//                 SizedBox(height: 5),
//                 Text(text!, textAlign: TextAlign.center)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
