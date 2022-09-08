import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/app_provider/utility_provider.dart';
import 'package:untitled1/components/custom_container.dart';
import 'package:untitled1/model/product_model.dart';
import 'package:untitled1/screens/home/components/list_product/grid_layout_product.dart';
import 'package:untitled1/size_config.dart';
import 'package:uuid/uuid.dart';
import 'one_restaurant.dart';
import 'restaurant_tittle.dart';

class ListAllRestaurantAndProduct extends HookConsumerWidget {
  final ScrollController controller;
  const ListAllRestaurantAndProduct({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var uuid = Uuid();
    final page = useState<int>(1);
    final isShowLoadingToFetch = useState(true);
    bool isLodingMore = false;
    final hasMoreData = useState<bool>(true);
    final categorytitle = ref.watch(Utility.categoriesTitle);
    final AllrestaurantsData1 =
        ref.watch(AppStateProvider.restaurantStateMap).values.toList();
    final restaurantDataWithCategories = AllrestaurantsData1.where(
        (element) => element.restaurantCategory == categorytitle).toList();

    final all_ProductData =
        ref.watch(AppStateProvider.productMapNotifier)!.values.toList();
    // print(all_ProductData?.length);

    // ----------------------------------------------------------
    Future<void> refresh() async {
      if (isLodingMore) return;
      isLodingMore = true;
      final test = await ref
          .read(AppStateProvider.restaurantStateMap.notifier)
          .controllGetLoadingData(
              categoryName: categorytitle!,
              page: page.value,
              numberOfRestaurant: restaurantDataWithCategories.length);
      if (test.length < 1) {
        hasMoreData.value = false;
      }
      // if (test.length > 1) {
      //   hasMoreData.value = true;
      // }
      isLodingMore = false;
      page.value = page.value + 1;
    }

    controller.addListener(() {
      // testminusofscrooloff =
      //     1 - ((currentLenth - controller.offset) / currentLenth);
      if (controller.position.maxScrollExtent == controller.offset) {
        isShowLoadingToFetch.value = true;
        refresh();
      } else {
        isShowLoadingToFetch.value = false;
      }
    });
    // --------------------------------------------------------
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: restaurantDataWithCategories.length,
        itemBuilder: (context, index) {
          final restaurantData = restaurantDataWithCategories[index];
          List<ProductModel> listProducts = all_ProductData.where((element) {
            return element.restaurantId == restaurantData.restaurantId;
          }).toList();
          final searchValue = ref.watch(Utility.searchValue);
          // print('searchValue');
          // print(searchValue);
          return CustomContainer(
            bottompadding: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: [
                  RestaurantTitle(
                    // key: ValueKey(uuid.v1()),
                    index: index,
                    restaurantName: restaurantData.restaurantName!,
                    controller: controller,
                    promotionList: restaurantData.promotionList,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  if (restaurantDataWithCategories != [])
                    OneRestaurant(
                      restaurantData: restaurantData,
                    ),
                  if (listProducts.isNotEmpty)
                    gridlayoutproduct(
                      listProducts: listProducts,
                      restaurantData: restaurantData,
                      scontroller: controller,
                    ),
                  const Divider(),
                  if (index == (restaurantDataWithCategories.length - 1) &&
                      isShowLoadingToFetch.value)
                    Center(
                      child: hasMoreData.value
                          ? CircularProgressIndicator()
                          : Text('no more data to load'),
                    ),
                ],
              ),
            ),
          );
        });
  }
}

//

class buyingproducthorizontaltype extends StatelessWidget {
  const buyingproducthorizontaltype({
    Key? key,
    required this.imageProductLink,
  }) : super(key: key);

  final String imageProductLink;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imageProductLink,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        Expanded(
          child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Banh Thuong'),
                RatingBar.builder(
                    minRating: 1,
                    itemSize: 17,
                    updateOnDrag: true,
                    itemBuilder: (context, index) {
                      return Icon(
                        Icons.star,
                        color: Colors.yellowAccent,
                      );
                    },
                    onRatingUpdate: (rating) {}),
                Text('3.00k'),
                Row(
                  children: [
                    ...List.generate(3, (index) {
                      return buttondathang(
                        soluongbanhdathang: '1',
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('10 chiec'),
              Text('2.0000 K'),
            ],
          ),
        ),
      ],
    );
  }
}

class buttondathang extends StatelessWidget {
  final String soluongbanhdathang;
  const buttondathang({
    Key? key,
    required this.soluongbanhdathang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          print(soluongbanhdathang);
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(5)),
          height: 20,
          width: 20,
          child: Text(soluongbanhdathang.toString()),
        ),
      ),
    );
  }
}
