import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_container.dart';
import 'package:untitled1/size_config.dart';

import '../../../cart/components/order_screen/customer_ordring_information/row_new_address_order_Screen.dart';
import 'time_ordering.dart';

class CustomerOrderingInformation extends HookConsumerWidget {
  CustomerOrderingInformation(
      {required this.restaurantId, required this.newAdressController, Key? key})
      : super(key: key);
  final TextEditingController newAdressController;
  final String restaurantId;
  // final ValueNotifier<int> recevingHour;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(AppStateProvider.userNotifier);
    final recevingHour = useState<int>(6);
    final recevingMinute = useState<int>(0);
    final recevingDay = useState<String>('hom_nay');
    final isShowNewAddress = useState(false);

    return CustomContainer(
      bottompadding: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('   Thông Tin Đặt Hàng:', style: TextStyle(color: Colors.black)),
          Text('   Địa Chỉ: ${user!.userAdrress}'),

          Text('   Số Điện Thoại: ${user.userPhone}'),

          Timingorder(
              recevingHour: recevingHour,
              recevingMinute: recevingMinute,
              recevingDay: recevingDay,
              restaurantId: restaurantId),
          // TimeOrdering(
          //   recevingHour: recevingHour,
          //   recevingMinute: recevingMinute,
          //   recevingDay: recevingDay,
          //   restaurantId: '',
          // ),
          if (!isShowNewAddress.value)
            DiaChiMoi(
                tenSanPhamController: newAdressController,
                isShowNewAddress: isShowNewAddress),
          if (isShowNewAddress.value)
            TextFormFieldDiaChi(
                tenSanPhamController: newAdressController,
                isShowNewAddress: isShowNewAddress),
        ],
      ),
    );
  }
}

class TextFormFieldDiaChi extends StatelessWidget {
  const TextFormFieldDiaChi({
    Key? key,
    required this.tenSanPhamController,
    required this.isShowNewAddress,
  }) : super(key: key);

  final TextEditingController tenSanPhamController;
  final ValueNotifier<bool> isShowNewAddress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RowNewAddressOrderScreen(
          tenSanPhamController: tenSanPhamController,
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            isShowNewAddress.value = !isShowNewAddress.value;
          },
          child: Text('Ok'),
        )
      ],
    );
  }
}

class DiaChiMoi extends StatelessWidget {
  const DiaChiMoi({
    Key? key,
    required this.tenSanPhamController,
    required this.isShowNewAddress,
  }) : super(key: key);

  final TextEditingController tenSanPhamController;
  final ValueNotifier<bool> isShowNewAddress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        tenSanPhamController.text == ''
            ? Text('   Địa Chỉ Mới')
            : SizedBox(
                width: getProportionateScreenWidth(10),
              ),
        Text(tenSanPhamController.text),
        Spacer(),
        TextButton(
            onPressed: () {
              isShowNewAddress.value = !isShowNewAddress.value;
            },
            child: Text('+'))
      ],
    );
  }
}
