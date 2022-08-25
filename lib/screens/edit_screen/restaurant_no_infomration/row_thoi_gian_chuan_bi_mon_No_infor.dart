import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/components/snackbarcontent.dart';
import 'package:untitled1/size_config.dart';
import '../../../constants.dart';

class RowThoiGianChuanBiMonAwnNoInfor extends HookConsumerWidget {
  final TextEditingController restaurantTimeMealPreparationController;

  final double? restaurantMealPreparation;
  bool isShowTextFormField = true;

  RowThoiGianChuanBiMonAwnNoInfor(
      {required this.restaurantTimeMealPreparationController,
      this.restaurantMealPreparation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preparationAnimationController = useAnimationController(
        initialValue: 1,
        lowerBound: 0,
        upperBound: 1,
        duration: Duration(milliseconds: 800));
    final isUserInput = useState<bool>(true);
    final isShowTextFormField = useState<bool>(true);
    final preparationFadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(preparationAnimationController);
    final preparationSlidingAnimation =
        Tween<Offset>(begin: Offset(0.05, 0), end: Offset(0, 0)).animate(
            CurvedAnimation(
                parent: preparationAnimationController,
                curve: Curves.elasticIn));
    useEffect(() {
      if (restaurantMealPreparation != null) {
        isShowTextFormField.value = false;
      }
      preparationAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          preparationAnimationController.forward();
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
          opacity: preparationFadeAnimation,
          child: SlideTransition(
            position: preparationSlidingAnimation,
            child: Text(
              'Thơì Gian Chuẩnn Bị :',
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
                ThoiGianChuanBiMonAnController:
                    restaurantTimeMealPreparationController,
                context: context,
                isUserInput: isUserInput.value,
                isUserInputFuncfalse: isUserInputFuncfalse,
                isUserInputFuncTrue: isUserInputFuncTrue2,
                preparationAnimationController: preparationAnimationController),
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
                restaurantTimeMealPreparationController.text = '';
              },
              child: Text(
                  restaurantTimeMealPreparationController.text != ''
                      ? restaurantTimeMealPreparationController.text
                      : restaurantMealPreparation.toString(),
                  style: TextStyle(fontSize: getProportionateScreenHeight(14))),
            ),
          ),

        // -------------------------------------
      ],
    );
  }
}

Widget buildTextFormFieldDiaChiCuaHang(
    {required TextEditingController ThoiGianChuanBiMonAnController,
    required WidgetRef ref,
    required BuildContext context,
    required Function isUserInputFuncfalse,
    required Function isUserInputFuncTrue,
    required bool isUserInput,
    required AnimationController preparationAnimationController}) {
  return TextFormField(
    style: TextStyle(fontSize: getProportionateScreenHeight(14)),
    controller: ThoiGianChuanBiMonAnController,
    keyboardType: TextInputType.emailAddress,
    onChanged: (value) {
      isUserInputFuncTrue();
    },
    onSaved: (value) {
      ThoiGianChuanBiMonAnController.text = value!;
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
      hintText: 'Nhập Thời Gian Chuẩn Bị',
    ),
    validator: (value) {
      if (value!.isEmpty) {
        isUserInputFuncfalse();

        TickerFuture tickerFuture = preparationAnimationController.repeat();
        tickerFuture.timeout(Duration(seconds: 2), onTimeout: () {
          preparationAnimationController.forward(from: 0);
          preparationAnimationController.stop(canceled: true);
          preparationAnimationController.reverse();
        });

        return;
      }

      return null;
    },
  );
}

































//  Row(
//               children: [
//                 Text('thoi gian chuan bi mon an:'),
//                 SizedBox(
//                   width: isShowTextFormFielThoiGianChuanBiMonAn.value
//                       ? getProportionateScreenWidth(6)
//                       : getProportionateScreenWidth(14),
//                 ),
//                 isShowTextFormFielThoiGianChuanBiMonAn.value
//                     ? Expanded(
//                         child: SizedBox(
//                           height: getProportionateScreenHeight(40),
//                           child: buildTextFormFieldThoiGianChuanBiMonAn(
//                             ref: ref,
//                             kiemtraFunction: () {
//                               isShowTextFormFielThoiGianChuanBiMonAn.value =
//                                   !isShowTextFormFielThoiGianChuanBiMonAn.value;
//                             },
//                             ThoiGianChuanBiMonAnController:
//                                 restaurantTimeMealPreparationController,
//                           ),
//                         ),
//                       )
//                     : Expanded(
//                         child:
//                             Text(restaurantTimeMealPreparationController.text),
//                       ),
//                 if (isShowTextFormFielCapNhat.value)
//                   TextButton(
//                       onPressed: () {
//                         isShowTextFormFielThoiGianChuanBiMonAn.value =
//                             !isShowTextFormFielThoiGianChuanBiMonAn.value;
//                       },
//                       child: isShowTextFormFielThoiGianChuanBiMonAn.value
//                           ? Text(" kiem tra")
//                           : Text(" nhap lai"))
//               ],
//             ),