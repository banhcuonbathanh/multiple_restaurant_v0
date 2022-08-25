import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/components/custom_buttom.dart';

import 'package:untitled1/size_config.dart';

import 'create_topping_button.dart';
import 'row_product_name_with_no_infor.dart';

class Topping_NoInform extends HookConsumerWidget {
  final String serverProductId;
  final String serverProductdetailId;
  final Function restartFunc;
  const Topping_NoInform(
      {required this.serverProductdetailId,
      required this.restartFunc,
      required this.serverProductId,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tenToppingController = useTextEditingController();
    bool isChooseKHong = true;
    bool isChooseIt = false;
    bool isChooseVua = false;
    bool isChooseNhieu = false;
    final toppingQuantity = useState<String>('Vừa');

    switch (toppingQuantity.value) {
      case 'Không':
        isChooseKHong = true;
        isChooseIt = false;
        isChooseVua = false;
        isChooseNhieu = false;

        break;

      case 'Ít':
        isChooseKHong = false;
        isChooseIt = true;
        isChooseVua = false;
        isChooseNhieu = false;
        break;
      case 'Vừa':
        isChooseKHong = false;
        isChooseIt = false;
        isChooseVua = true;
        isChooseNhieu = false;
        break;
      case 'Nhiều':
        isChooseKHong = false;
        isChooseIt = false;
        isChooseVua = false;
        isChooseNhieu = true;
        break;
      default:
    }
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Form(
          key: formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowToppingName(
                ref: ref,
                toppingServerName: null,
                tenToppingController: tenToppingController,
              ),
              Flexible(
                flex: 3,
                child: CustomerButton(
                  backgoundColor: toppingQuantity.value == 'Không'
                      ? null
                      : Colors.grey.shade300,
                  BorderRadiuscircular: 10,
                  buttonHeight: getProportionateScreenHeight(25),
                  buttonWidth: getProportionateScreenWidth(50),
                  press: () {
                    toppingQuantity.value = 'Không';
                  },
                  text: 'Không',
                ),
              ),
              Flexible(
                flex: 3,
                child: CustomerButton(
                  backgoundColor: toppingQuantity.value == 'Ít'
                      ? null
                      : Colors.grey.shade300,
                  BorderRadiuscircular: 10,
                  buttonHeight: getProportionateScreenHeight(25),
                  buttonWidth: getProportionateScreenWidth(50),
                  press: () {
                    toppingQuantity.value = 'Ít';
                  },
                  text: 'Ít',
                ),
              ),
              Flexible(
                flex: 3,
                child: CustomerButton(
                  backgoundColor: toppingQuantity.value == 'Vừa'
                      ? null
                      : Colors.grey.shade300,
                  BorderRadiuscircular: 10,
                  buttonHeight: getProportionateScreenHeight(25),
                  buttonWidth: getProportionateScreenWidth(50),
                  press: () {
                    toppingQuantity.value = 'Vừa';
                  },
                  text: 'Vừa',
                ),
              ),
              Flexible(
                flex: 3,
                child: CustomerButton(
                  backgoundColor: toppingQuantity.value == 'Nhiều'
                      ? null
                      : Colors.grey.shade300,
                  BorderRadiuscircular: 10,
                  buttonHeight: getProportionateScreenHeight(25),
                  buttonWidth: getProportionateScreenWidth(50),
                  press: () {
                    toppingQuantity.value = 'Nhiều';
                  },
                  text: 'Nhiều',
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        CreateToppingButton(
          toppingName: tenToppingController.text,
          toppingQuantity: toppingQuantity.value,
          serverProductId: serverProductId,
          restartFunc: restartFunc,
          formKey: formKey,
          resetTextFunc: () {
            tenToppingController.text = '';
          },
          serverProductdetailId: serverProductdetailId,
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
      ],
    );
  }
}
