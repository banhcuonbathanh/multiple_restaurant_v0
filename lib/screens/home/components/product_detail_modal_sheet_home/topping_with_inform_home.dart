import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/model/topping_model.dart';
import 'package:untitled1/size_config.dart';

class ToppingWithInformHome extends HookConsumerWidget {
  final ToppingModel toppingModel;
  final Function restartFunc;
  const ToppingWithInformHome(
      {required this.restartFunc, required this.toppingModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isChooseKHong = true;
    bool isChooseIt = false;
    bool isChooseVua = false;
    bool isChooseNhieu = false;
    final tuyChon = useState<String>(toppingModel.toppingQuantity!);

    switch (tuyChon.value) {
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text(" Xoá Tuỳ Chọn"),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  await ref
                                      .read(AppStateProvider
                                          .toppingEditMapNotifier.notifier)
                                      .deleteToppingWithId(
                                          toppingId: toppingModel.toppingId!);
                                  Navigator.pop(context);
                                  restartFunc();
                                },
                                child: Text(" OK")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(" Không"))
                          ],
                        ));
              },
              child: SizedBox(
                height: getProportionateScreenHeight(30),
                width: getProportionateScreenWidth(50),
                child: Text(toppingModel.toppingName!),
              ),
            ),
            CustomerButton(
              backgoundColor:
                  tuyChon.value == 'Không' ? null : Colors.grey.shade300,
              BorderRadiuscircular: 10,
              buttonHeight: getProportionateScreenHeight(25),
              buttonWidth: getProportionateScreenWidth(50),
              press: () {
                tuyChon.value = 'Không';
              },
              text: 'Không',
            ),
            CustomerButton(
              backgoundColor:
                  tuyChon.value == 'Ít' ? null : Colors.grey.shade300,
              BorderRadiuscircular: 10,
              buttonHeight: getProportionateScreenHeight(25),
              buttonWidth: getProportionateScreenWidth(50),
              press: () {
                tuyChon.value = 'Ít';
              },
              text: 'Ít',
            ),
            CustomerButton(
              backgoundColor:
                  tuyChon.value == 'Vừa' ? null : Colors.grey.shade300,
              BorderRadiuscircular: 10,
              buttonHeight: getProportionateScreenHeight(25),
              buttonWidth: getProportionateScreenWidth(50),
              press: () {
                tuyChon.value = 'Vừa';
              },
              text: 'Vừa',
            ),
            CustomerButton(
              backgoundColor:
                  tuyChon.value == 'Nhiều' ? null : Colors.grey.shade300,
              BorderRadiuscircular: 10,
              buttonHeight: getProportionateScreenHeight(25),
              buttonWidth: getProportionateScreenWidth(50),
              press: () {
                tuyChon.value = 'Nhiều';
              },
              text: 'Nhiều',
            ),
          ],
        ),
      ],
    );
  }
}
