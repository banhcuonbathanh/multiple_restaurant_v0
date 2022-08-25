import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:untitled1/app_provider/utility_provider.dart';
import 'package:untitled1/components/custom_container.dart';

import 'package:untitled1/screens/home/components/list_all_restaurant_product/list_all_restaurant_and_product.dart';
import 'package:untitled1/screens/home/components/section_title/section_title.dart';
import '../../../size_config.dart';
import 'categories/categoriesCustomer.dart';

import 'list_all_restaurant_product/restaurant_tittle_addtionnal.dart';
import 'search_field.dart';
import 'section_title/section_title_show_on_top.dart';
import 'promotion/promotion.dart';

class Body extends HookConsumerWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restartAll = useState(true);

    ScrollController scroller = ScrollController();
    final isShowtitleontop = useValueNotifier<bool>(false);
    final widgetoffsetData = ref.watch(Utility.widgetOffSet);

    scroller.addListener(() {
      var section = widgetoffsetData['SectionTitle'];
      if (scroller.offset > section! - 20 && isShowtitleontop.value == false) {
        isShowtitleontop.value = true;
      }
      if (scroller.offset < section - 20 && isShowtitleontop.value == true) {
        isShowtitleontop.value = false;
      }
    });

    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: scroller,
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(10)),
                CustomContainer(
                  bottompadding: 10,
                  child: SearchField(
                    controller: scroller,
                  ),
                ),
                CustomContainer(
                  bottompadding: 10,
                  child: CategoriesCustomer(
                    restartAll: () {
                      restartAll.value = !restartAll.value;
                    },
                  ),
                ),
                const CustomContainer(
                  bottompadding: 10,
                  child: Promotion(),
                ),
                CustomContainer(
                  bottompadding: 10,
                  child: SectionTitle(
                    press: () {},
                    controller: scroller,
                    restartAll: () {
                      restartAll.value = !restartAll.value;
                    },
                  ),
                ),
                ListAllRestaurantAndProduct(
                  controller: scroller,
                ),
                RestaurantTitleAdditional(
                  index: widgetoffsetData.values.toList().length + 1,
                  restaurantName: '',
                  controller: scroller,
                ),
                SizedBox(height: getProportionateScreenWidth(30)),
              ],
            ),
          ),
          ShowSectionTitleOnTop(
            isShowtitleontop: isShowtitleontop,
            scroller: scroller,
            restartAll: () {
              restartAll.value = !restartAll.value;
            },
          ),

          // CustomerBottomNavigationBar(),
          // Positioned(
          //   bottom: 0,
          //   child: customerBottomBar(),
          // ),
          // LiquidTabBar(),
        ],
      ),
    );
  }
}
