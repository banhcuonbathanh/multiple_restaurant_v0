import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/components/snackbarcontent.dart';
import 'package:untitled1/size_config.dart';
import '../../../constants.dart';

class RowDiaChiQuanNoInfor extends HookConsumerWidget {
  final TextEditingController restaurantAddressController;
  final String? restaurantAdrress;
  bool isShowTextFormField = true;

  RowDiaChiQuanNoInfor(
      {this.restaurantAdrress, required this.restaurantAddressController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressAnimationController = useAnimationController(
        initialValue: 1,
        lowerBound: 0,
        upperBound: 1,
        duration: Duration(milliseconds: 800));
    final isUserInput = useState<bool>(true);
    final isShowTextFormField = useState<bool>(true);
    final addressFadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(addressAnimationController);
    final addressSlidingAnimation =
        Tween<Offset>(begin: Offset(0.05, 0), end: Offset(0, 0)).animate(
            CurvedAnimation(
                parent: addressAnimationController, curve: Curves.elasticIn));
    useEffect(() {
      if (restaurantAdrress != null) {
        isShowTextFormField.value = false;
      }
      addressAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          addressAnimationController.forward();
        }
      });
      return () {};
    });
    final isUserInputFuncfalse = () {
      isUserInput.value = false;
    };
    var isUserInputFuncTrue2 = () {
      isUserInput.value = true;
    };

    return Row(
      children: [
        FadeTransition(
          opacity: addressFadeAnimation,
          child: SlideTransition(
            position: addressSlidingAnimation,
            child: Text(
              'Địa Chỉ Quán :',
              style: TextStyle(
                  color: isUserInput.value ? Colors.black : Colors.red),
            ),
          ),
        ),

        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        if (isShowTextFormField.value)
          Container(
            // color: Colors.blue,
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(150),
            child: buildTextFormFieldDiaChiCuaHang(
                ref: ref,
                diaChiCuaHangController: restaurantAddressController,
                context: context,
                isUserInput: isUserInput.value,
                isUserInputFuncfalse: isUserInputFuncfalse,
                isUserInputFuncTrue: isUserInputFuncTrue2,
                addressAnimationController: addressAnimationController),
          ),
        // --------------------------------------
        if (!isShowTextFormField.value)
          Container(
            alignment: Alignment.centerLeft,
            // padding: EdgeInsets.symmetric(
            //     horizontal: getProportionateScreenWidth(0),
            //     vertical: getProportionateScreenHeight(0)),
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(150),
            child: GestureDetector(
              onTap: () {
                isShowTextFormField.value = true;
                restaurantAddressController.text = '';
              },
              child: Text(
                  restaurantAddressController.text != ''
                      ? restaurantAddressController.text
                      : restaurantAdrress!,
                  style: TextStyle(fontSize: getProportionateScreenHeight(14))),
            ),
          ),

        // -------------------------------------
      ],
    );
  }
}

Widget buildTextFormFieldDiaChiCuaHang(
    {required TextEditingController diaChiCuaHangController,
    required WidgetRef ref,
    required BuildContext context,
    required Function isUserInputFuncfalse,
    required Function isUserInputFuncTrue,
    required bool isUserInput,
    required AnimationController addressAnimationController}) {
  return TextFormField(
    style: TextStyle(fontSize: getProportionateScreenHeight(14)),
    controller: diaChiCuaHangController,
    keyboardType: TextInputType.emailAddress,
    onChanged: (value) {
      isUserInputFuncTrue();
    },
    onSaved: (value) {
      diaChiCuaHangController.text = value!;
    },
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        // borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(1),
          vertical: getProportionateScreenHeight(1)),
      hintText: 'Nhập Địa Chỉ Quán',
    ),
    validator: (value) {
      if (value!.isEmpty) {
        isUserInputFuncfalse();

        TickerFuture tickerFuture = addressAnimationController.repeat();
        tickerFuture.timeout(Duration(seconds: 2), onTimeout: () {
          addressAnimationController.forward(from: 0);
          addressAnimationController.stop(canceled: true);
          addressAnimationController.reverse();
        });

        return;
      }

      return null;
    },
  );
}
