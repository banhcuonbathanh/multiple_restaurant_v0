import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focused_menu/modals.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/app_provider/utility_provider.dart';

import 'package:untitled1/size_config.dart';

import 'package:focused_menu/focused_menu.dart';

class CategoryTitle extends HookConsumerWidget {
  final Function restartAll;
  CategoryTitle(
      {required this.controller,
      required this.categoryTitle,
      required this.restartAll});

  final String? categoryTitle;
  final ScrollController controller;

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final RenderBox? box =
  //         keyText.currentContext!.findRenderObject() as RenderBox;
  //     position = box!.localToGlobal(Offset.zero);
  //     // final offsety = box.localToGlobal(Offset.zero);
  //     // dyWidget.value = offsety.dy;
  //     // dxWidget.value = offsety.dx;
  //     // print('dyWidget');
  //     // print(dyWidget.value);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesList = ref.watch(AppStateProvider.categoriesNotifier);

    // widget.controller.addListener(() {
    //   print('position');
    //   print(widget.controller.offset);
    // });
    // final dyWidget = useState(0.0);
    // final dxWidget = useState(0.0);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final box = context.findRenderObject() as RenderBox;
    //   final offsety = box.localToGlobal(Offset.zero);
    //   // final offsety = box.localToGlobal(Offset.zero);
    //   dyWidget.value = offsety.dy;
    //   dxWidget.value = offsety.dx;
    //   print('dyWidget');
    //   print(dyWidget.value);
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_) {

    //   final box = key.findRenderObject() as RenderBox;
    //   final offsety = box.localToGlobal(Offset.zero);
    //   // final offsety = box.localToGlobal(Offset.zero);
    //   dyWidget.value = offsety.dy;
    //   dxWidget.value = offsety.dx;
    // });
    // print('dx');
    // print(dxWidget.value);

    // print('controller.offset');
    // print(controller.offset);
    // useEffect(() {

    // });
    // controller.addListener(() {
    //   print('dy');
    //   print(dyWidget.value);
    // });
    return FocusedMenuHolder(
      menuItems: [
        FocusedMenuItem(
            onPressed: () async {
              ref
                  .read(Utility.categoriesTitle.notifier)
                  .categoriesTitleOnScreen(
                      categoriesTitle: categoriesList[0].categoryName!);
              final test = await ref
                  .read(AppStateProvider.restaurantStateMap.notifier)
                  .controllGetLoadingData(
                      categoryName: categoriesList[0].categoryName!,
                      page: 0,
                      numberOfRestaurant: 0);
              restartAll();
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(categoriesList[0].categoryName!),
                SizedBox(
                  width: 180,
                ),
                SvgPicture.network(categoriesList[0].categoryImage!),
              ],
            )),
        FocusedMenuItem(
            onPressed: () async {
              ref
                  .read(Utility.categoriesTitle.notifier)
                  .categoriesTitleOnScreen(categoriesTitle: 'Đồ Uống');
              final test = await ref
                  .read(AppStateProvider.restaurantStateMap.notifier)
                  .controllGetLoadingData(
                      categoryName: 'Đồ Uống', page: 0, numberOfRestaurant: 0);
              restartAll();
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Đồ Uống'),
                SizedBox(
                  width: 160,
                ),
                SvgPicture.network(categoriesList[1].categoryImage!),
              ],
            )),
        FocusedMenuItem(
            onPressed: () async {
              ref
                  .read(Utility.categoriesTitle.notifier)
                  .categoriesTitleOnScreen(
                      categoriesTitle: categoriesList[2].categoryName!);
              final test = await ref
                  .read(AppStateProvider.restaurantStateMap.notifier)
                  .controllGetLoadingData(
                      categoryName: categoriesList[2].categoryName!,
                      page: 0,
                      numberOfRestaurant: 0);
              restartAll();
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(categoriesList[2].categoryName!),
                SizedBox(
                  width: 143,
                ),
                SvgPicture.network(categoriesList[2].categoryImage!),
              ],
            )),
      ],
      onPressed: () {},
      child: Text(
        categoryTitle!,
        style: TextStyle(
          fontSize: getProportionateScreenWidth(15),
          color: Colors.black,
        ),
      ),
    );
    // return InkWell(
    //   onTap: () {
    //     showDialog(
    //         context: context,
    //         builder: (context) {
    //           return AlignPositioned(
    //             dx: -50,
    //             dy: -widget.controller.offset,
    //             child: Container(
    //               height: 100,
    //               width: 100,
    //               color: Colors.white,
    //               child: Text('dataasdkjfhakjshdfkhsdkj'),
    //             ),
    //           );
    //         });
    //   },
    //   child: buildtext(),
    // );
  }

  // Text buildtext() {
  //   return Text(
  //     widget.categoryTitle!,
  //     key: keyText,
  //     style: TextStyle(
  //       fontSize: getProportionateScreenWidth(15),
  //       color: Colors.black,
  //     ),
  //   );
  // }
}
