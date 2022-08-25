import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';

import '../../../../components/custom_buttom.dart';

class RowCategoryWithInformation extends StatelessWidget {
  final Function doAnFunc;
  final Function doUongFunc;
  final Function thucPhamFunc;
  final String restaurantCategoryServer;
  final ValueNotifier<String> categoryIndex;
  const RowCategoryWithInformation({
    required this.restaurantCategoryServer,
    required this.categoryIndex,
    required this.doAnFunc,
    required this.doUongFunc,
    required this.thucPhamFunc,
  }) : super();

  @override
  Widget build(BuildContext context) {
    // var categoryIndex = useState<String>('Đồ Ăn');
    String restaurantCategory = '';
    bool isCategoryDoAn = false;
    bool isCategoryDoUong = false;
    bool isCategoryThucPham = false;

    if (restaurantCategoryServer != null && categoryIndex.value == '') {
      categoryIndex.value = restaurantCategoryServer;
    }

    switch (categoryIndex.value) {
      case 'Đồ Ăn':
        isCategoryDoAn = true;
        isCategoryDoUong = false;
        isCategoryThucPham = false;
        restaurantCategory = 'Đồ Ăn';

        break;

      case 'Đồ Uống':
        isCategoryDoAn = false;
        isCategoryDoUong = true;
        isCategoryThucPham = false;
        restaurantCategory = 'Đồ Uống';
        break;
      case 'Thực Phẩm':
        isCategoryDoAn = false;
        isCategoryDoUong = false;
        isCategoryThucPham = true;
        restaurantCategory = 'Thực Phẩm';
        break;
      default:
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Category : '),
        CustomerButton(
          buttonHeight: 35,
          buttonWidth: 80,
          text: 'Đồ Ăn',
          BorderRadiuscircular: 10,
          press: () {
            categoryIndex.value = 'Đồ Ăn';

            // isCategoryDoAn.value = !isCategoryDoAn.value;
          },
          backgoundColor:
              categoryIndex.value == 'Đồ Ăn' ? null : Colors.grey.shade300,
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        CustomerButton(
          buttonHeight: 35,
          buttonWidth: 80,
          text: 'Đồ Uống',
          BorderRadiuscircular: 10,
          press: () {
            categoryIndex.value = 'Đồ Uống';
            // isCategoryDoUong.value = !isCategoryDoUong.value;
          },
          backgoundColor:
              categoryIndex.value == 'Đồ Uống' ? null : Colors.grey.shade300,
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        CustomerButton(
          buttonHeight: 35,
          buttonWidth: 80,
          text: 'Thực Phẩm',
          BorderRadiuscircular: 10,
          press: () {
            categoryIndex.value = 'Thực Phẩm';
            // isCategoryThucPham.value = !isCategoryThucPham.value;
          },
          backgoundColor:
              categoryIndex.value == 'Thực Phẩm' ? null : Colors.grey.shade300,
        ),
      ],
    );
  }
}
