import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/api_provider.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/model/topping_model.dart';
import 'package:untitled1/size_config.dart';

import '../../../../../model/user_model.dart';

class OderingButtongeneral extends HookConsumerWidget {
  const OderingButtongeneral({
    required this.orderingFunc,
    Key? key,
  }) : super(key: key);
  final Function orderingFunc;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(AppStateProvider.userNotifier);
    return CustomerButton(
        text: ('Đặt Hàng'),
        press: () async {
          if (user?.userPhone == null ||
              user?.userAdrress == null ||
              user?.userName == null) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    content: Text('Nhập ĐỊa Thông Tin Giao Hàng'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(
                            //     context, OrderingInformationScreen1.routeName);
                            // orderingFunc();
                          },
                          child: Text("OK")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Không")),
                    ],
                  );
                });
          } else {
            orderingFunc();
          }
          // print('isShow.value');
          // print(isShow.value);
        },
        buttonHeight: getProportionateScreenHeight(30),
        buttonWidth: double.infinity,
        BorderRadiuscircular: 10,
        backgoundColor: null);
  }
}

class orderbutton extends HookConsumerWidget {
  const orderbutton({
    Key? key,
    required this.setOfproduct,
    required this.orderedProductdetails,
    required this.toppings,
    required this.newAdressController,
    required this.user,
  }) : super(key: key);

  final Set<String> setOfproduct;
  final List<ProductDetailModel>? orderedProductdetails;
  final List<ToppingModel> toppings;
  final TextEditingController newAdressController;
  final UserModel? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OderingButtongeneral(
      orderingFunc: () async {
        final list = setOfproduct.toList();
        for (var index = 0; index < list.length; index++) {
          final ListproductsDetail = orderedProductdetails!.where((element) {
            return element.productId == setOfproduct.elementAt(0);
          }).toList();

          final toppingsProduct = toppings
              .where((element) =>
                  element.productId == setOfproduct.elementAt(index))
              .toList();
          final order = await ref.read(API.order).createOrder(
              BuyingUserId: user!.userId!,
              ProductId: ListproductsDetail[0].productId!,
              restaurantId: ListproductsDetail[0].restaurantId!,
              productdetailsList: ListproductsDetail,
              toppingsList: toppingsProduct,
              address: newAdressController.text == ''
                  ? user!.userAdrress!
                  : newAdressController.text,
              day: 'test mi',
              hour: "test moi",
              minute: 'test moi',
              restaurantOnwnerId: '111111111111111');
// ListproductsDetail[0].userId!
          // ref.read(API.socket).sendMessage(
          //     userId: '62b2d37d9176c5d25ac393ab',
          //     orderId: '62b2d37d9176c5d25ac393ab',
          //     receiveId: '62b2d37d9176c5d25ac393ab');

          // final ordertest = await ref
          //     .read(AppStateProvider.orderNotifier.notifier)
          //     .getOneOrderById(orderId: '62b6c50826c43663da078355');
          // print('ordertest');
          // print(ordertest);
        }
      },
    );
  }
}
