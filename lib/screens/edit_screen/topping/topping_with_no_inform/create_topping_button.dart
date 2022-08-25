import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/api_provider.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/components/snackbarcontent.dart';
import 'package:untitled1/model/topping_model.dart';
import 'package:untitled1/size_config.dart';

class CreateToppingButton extends HookConsumerWidget {
  String toppingName;
  final String toppingQuantity;
  final String serverProductId;
  final String serverProductdetailId;
  final Function restartFunc;
  final Function resetTextFunc;
  final GlobalKey<FormState> formKey;
  CreateToppingButton({
    required this.serverProductdetailId,
    required this.resetTextFunc,
    required this.formKey,
    required this.restartFunc,
    Key? key,
    required this.toppingName,
    required this.toppingQuantity,
    required this.serverProductId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print(' build CreateToppingButton');
    // print(serverProductdetailId);
    final user = ref.watch(AppStateProvider.userNotifier);

    return Column(
      children: [
        CustomerButton(
            text: 'Tạo Tuỳ Chọn',
            press: () async {
              if (formKey.currentState!.validate()) {
                // print('formKey.currentState!.validate()');
                formKey.currentState!.save();

                if (toppingName != '') {
                  final ToppingModel? topping = await ref
                      .read(AppStateProvider.toppingEditMapNotifier.notifier)
                      .createTopping(
                          toppingModel: ToppingModel(
                        productId: serverProductId,
                        restaurantId: user!.restaurantId!,
                        toppingId: '',
                        toppingName: toppingName,
                        toppingQuantity: toppingQuantity,
                        userId: user.userId!,
                        productDetailId: serverProductdetailId,
                      ));

                  if (topping == null) {
                    CustomScaffoldMessger(
                        contend: 'Tuỳ Chọn Đã Có', context: context);
                  }

                  restartFunc();
                  resetTextFunc();
                }
              }
            },
            buttonHeight: getProportionateScreenHeight(30),
            buttonWidth: getProportionateScreenWidth(100),
            BorderRadiuscircular: 10,
            backgoundColor: null)
      ],
    );
  }
}
