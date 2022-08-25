import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/components/snackbarcontent.dart';
import 'package:untitled1/size_config.dart';
import '../../../constants.dart';

// class RowThoiGianPhucVuNoInfor extends StatefulWidget {
//   final TextEditingController ThoiGianPhucVuBatDauController;
//   final TextEditingController ThoiGianPhucVuKetThucController;
//   final WidgetRef ref;

//   final double? thoiGianBatDau;
//   final double? thoiGianKetThuc;

//   RowThoiGianPhucVuNoInfor({
//     Key? key,
//     required this.thoiGianBatDau,
//     required this.thoiGianKetThuc,
//     required this.ref,
//     required this.ThoiGianPhucVuBatDauController,
//     required this.ThoiGianPhucVuKetThucController,
//   }) : super(key: key);

//   @override
//   State<RowThoiGianPhucVuNoInfor> createState() => _RowThoiGianPhucVuState();
// }

class RowThoiGianPhucVuNoInfor extends HookConsumerWidget {
  final TextEditingController ThoiGianPhucVuBatDauController;
  final TextEditingController ThoiGianPhucVuKetThucController;

  final double? thoiGianBatDau;
  final double? thoiGianKetThuc;

  bool isShowTextFormFieldBatDau = true;
  bool isShowTextFormFieldKetThuc = true;

  RowThoiGianPhucVuNoInfor(
      {required this.ThoiGianPhucVuBatDauController,
      required this.ThoiGianPhucVuKetThucController,
      this.thoiGianBatDau,
      this.thoiGianKetThuc});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThoiGianPhucVuBatDauAnimtaionController = useAnimationController(
        initialValue: 1,
        lowerBound: 0,
        upperBound: 1,
        duration: Duration(milliseconds: 800));

    final isUserInputbatdau = useState<bool>(true);
    final isShowTextFormFieldbatdau = useState<bool>(true);
    final ThoiGianPhucVuBatDauFadeAnimation = Tween<double>(begin: 0, end: 1)
        .animate(ThoiGianPhucVuBatDauAnimtaionController);
    final ThoiGianPhucVuBatDauSlidingAnimation =
        Tween<Offset>(begin: Offset(0.05, 0), end: Offset(0, 0)).animate(
            CurvedAnimation(
                parent: ThoiGianPhucVuBatDauAnimtaionController,
                curve: Curves.elasticIn));
    useEffect(() {
      if (thoiGianBatDau != null) {
        isShowTextFormFieldbatdau.value = false;
      }
      ThoiGianPhucVuBatDauAnimtaionController.addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          ThoiGianPhucVuBatDauAnimtaionController.forward();
        }
      });
      return () {};
    });
    final isUserInputFuncfalsebatdau = () {
      isUserInputbatdau.value = false;
    };
    var isUserInputFuncTruebatdau = () {
      isUserInputbatdau.value = true;
    };

    // -----------------------------------------------------
    final ThoiGianPhucVuKetThucAnimtaionController = useAnimationController(
        initialValue: 1,
        lowerBound: 0,
        upperBound: 1,
        duration: Duration(milliseconds: 800));

    final isUserInputKetThuc = useState<bool>(true);
    final isShowTextFormFieldKetThuc = useState<bool>(true);
    final ThoiGianPhucVuKetThucFadeAnimation = Tween<double>(begin: 0, end: 1)
        .animate(ThoiGianPhucVuKetThucAnimtaionController);
    final ThoiGianPhucVuKetThucSlidingAnimation =
        Tween<Offset>(begin: Offset(0.05, 0), end: Offset(0, 0)).animate(
            CurvedAnimation(
                parent: ThoiGianPhucVuKetThucAnimtaionController,
                curve: Curves.elasticIn));
    useEffect(() {
      if (thoiGianKetThuc != null) {
        isShowTextFormFieldKetThuc.value = false;
      }
      ThoiGianPhucVuKetThucAnimtaionController.addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          ThoiGianPhucVuKetThucAnimtaionController.forward();
        }
      });
      return () {};
    });
    final isUserInputFuncfalseKetThuc = () {
      isUserInputbatdau.value = false;
    };
    var isUserInputFuncTrueKetThuc = () {
      isUserInputbatdau.value = true;
    };

    print('isUserInputbatdau.value');
    print(isUserInputbatdau.value);
    // -----------------------------------------------------
    return Row(
      children: [
        FadeTransition(
          opacity: isUserInputbatdau.value
              ? ThoiGianPhucVuBatDauFadeAnimation
              : ThoiGianPhucVuKetThucFadeAnimation,
          child: SlideTransition(
            position: isUserInputbatdau.value
                ? ThoiGianPhucVuBatDauSlidingAnimation
                : ThoiGianPhucVuKetThucSlidingAnimation,
            child: Text(
              'Thời Gian Phục Vụ  :',
              style: TextStyle(
                  color: isUserInputbatdau.value ? Colors.black : Colors.red),
            ),
          ),
        ),
        Flexible(
          // first component
          child: Row(
            children: [
              SizedBox(
                width: getProportionateScreenWidth(10),
              ),
              if (isShowTextFormFieldBatDau)
                Flexible(
                  child: Container(
                    // color: Colors.blue,
                    height: getProportionateScreenHeight(30),

                    child: buildTextFormFieldThoiGianPhucVuBatDAU(
                        ref: ref,
                        ThoiGianPhucVuBatDauController:
                            ThoiGianPhucVuBatDauController,
                        context: context,
                        isUserInputbatdau: isUserInputbatdau.value,
                        isUserInputFuncfalsebatdau: isUserInputFuncfalsebatdau,
                        isUserInputFuncTruebatdau: isUserInputFuncTruebatdau,
                        ThoiGianPhucVuBatDauAnimtaionController:
                            ThoiGianPhucVuBatDauAnimtaionController),
                  ),
                ),
              // --------------------------------------
              if (!isShowTextFormFieldBatDau)
                Flexible(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    // padding: EdgeInsets.symmetric(
                    //     horizontal: getProportionateScreenWidth(0),
                    //     vertical: getProportionateScreenHeight(0)),
                    height: getProportionateScreenHeight(30),

                    child: GestureDetector(
                      onTap: () {
                        isShowTextFormFieldBatDau = true;
                        ThoiGianPhucVuBatDauController.text = '';
                      },
                      child: Text(
                          ThoiGianPhucVuBatDauController.text != ''
                              ? ThoiGianPhucVuBatDauController.text
                              : thoiGianBatDau!.toString(),
                          style: TextStyle(
                              fontSize: getProportionateScreenHeight(14))),
                    ),
                  ),
                ),

              // -------------------------------------
            ],
          ),
        ),
        Flexible(
          child: Row(
            children: [
              SizedBox(
                width: getProportionateScreenWidth(10),
              ),
              if (isShowTextFormFieldKetThuc.value)
                Flexible(
                  child: Container(
                    // color: Colors.blue,
                    height: getProportionateScreenHeight(30),

                    child: buildTextFormFieldThoiGianPhucVuKetThuc(
                        ref: ref,
                        ThoiGianPhucVuKetThucController:
                            ThoiGianPhucVuKetThucController,
                        context: context,
                        isUserInputKetThuc: isUserInputKetThuc.value,
                        isUserInputFuncfalseKetThuc:
                            isUserInputFuncfalseKetThuc,
                        isUserInputFuncTrueKetThuc: isUserInputFuncTrueKetThuc,
                        ThoiGianPhucVuKetThucAnimtaionControlle:
                            ThoiGianPhucVuKetThucAnimtaionController),
                  ),
                ),
              // --------------------------------------
              if (!isShowTextFormFieldKetThuc.value)
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    // padding: EdgeInsets.symmetric(
                    //     horizontal: getProportionateScreenWidth(0),
                    //     vertical: getProportionateScreenHeight(0)),
                    height: getProportionateScreenHeight(30),

                    child: GestureDetector(
                      onTap: () {
                        isShowTextFormFieldKetThuc.value = true;
                        ThoiGianPhucVuBatDauController.text = '';
                      },
                      child: Text(
                          ThoiGianPhucVuBatDauController.text != ''
                              ? ThoiGianPhucVuBatDauController.text
                              : thoiGianKetThuc!.toString(),
                          style: TextStyle(
                              fontSize: getProportionateScreenHeight(14))),
                    ),
                  ),
                ),

              // -------------------------------------
            ],
          ),
        ),
      ],
    );
  }
}

// KetThuc
Widget buildTextFormFieldThoiGianPhucVuKetThuc(
    {required TextEditingController ThoiGianPhucVuKetThucController,
    required WidgetRef ref,
    required BuildContext context,
    required bool isUserInputKetThuc,
    required Function isUserInputFuncfalseKetThuc,
    required Function isUserInputFuncTrueKetThuc,
    required AnimationController ThoiGianPhucVuKetThucAnimtaionControlle}) {
  return TextFormField(
    style: TextStyle(fontSize: getProportionateScreenHeight(14)),
    controller: ThoiGianPhucVuKetThucController,
    keyboardType: TextInputType.emailAddress,
    onChanged: (value) {
      isUserInputFuncTrueKetThuc();
    },
    onSaved: (value) {
      ThoiGianPhucVuKetThucController.text = value!;
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
      hintText: 'Kết Thúc',
    ),
    validator: (value) {
      if (value!.isEmpty) {
        print('isUserInputFuncfalseKetThuc');
        isUserInputFuncfalseKetThuc();

        TickerFuture tickerFuture =
            ThoiGianPhucVuKetThucAnimtaionControlle.repeat();
        tickerFuture.timeout(Duration(seconds: 2), onTimeout: () {
          ThoiGianPhucVuKetThucAnimtaionControlle.forward(from: 0);
          ThoiGianPhucVuKetThucAnimtaionControlle.stop(canceled: true);
          ThoiGianPhucVuKetThucAnimtaionControlle.reverse();
        });
        return;
      }

      return null;
    },
  );
}

Widget buildTextFormFieldThoiGianPhucVuBatDAU(
    {required TextEditingController ThoiGianPhucVuBatDauController,
    required WidgetRef ref,
    required BuildContext context,
    required Function isUserInputFuncfalsebatdau,
    required Function isUserInputFuncTruebatdau,
    required bool isUserInputbatdau,
    required AnimationController ThoiGianPhucVuBatDauAnimtaionController}) {
  return TextFormField(
    style: TextStyle(fontSize: getProportionateScreenHeight(14)),
    controller: ThoiGianPhucVuBatDauController,
    keyboardType: TextInputType.emailAddress,
    onChanged: (value) {
      isUserInputFuncTruebatdau();
    },
    onSaved: (value) {
      ThoiGianPhucVuBatDauController.text = value!;
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
      hintText: 'Bắt Đầu',
    ),
    validator: (value) {
      if (value!.isEmpty) {
        isUserInputFuncfalsebatdau();

        TickerFuture tickerFuture =
            ThoiGianPhucVuBatDauAnimtaionController.repeat();
        tickerFuture.timeout(Duration(seconds: 2), onTimeout: () {
          ThoiGianPhucVuBatDauAnimtaionController.forward(from: 0);
          ThoiGianPhucVuBatDauAnimtaionController.stop(canceled: true);
          ThoiGianPhucVuBatDauAnimtaionController.reverse();
        });
        return;
      }

      return null;
    },
  );
}

//  Row(
//             children: [
//               Text('thoi gian phuc vu:'),
//               SizedBox(
//                 width: isShowTextFormFielThoiGianPhucVu.value
//                     ? getProportionateScreenWidth(6)
//                     : getProportionateScreenWidth(14),
//               ),
//               isShowTextFormFielThoiGianPhucVu.value
//                   ? Expanded(
//                       child: Row(
//                         children: [
//                           // thoi gian bat dau
//                           Expanded(
//                             child: SizedBox(
//                               height: getProportionateScreenHeight(40),
//                               child: buildTextFormFieldThoiGianPhucVuBatDAU(
//                                 ref: ref,
//                                 kiemtraFunction: () {
//                                   isShowTextFormFielThoiGianPhucVu.value =
//                                       !isShowTextFormFielThoiGianPhucVu.value;
//                                 },
//                                 ThoiGianPhucVuBatDauController:
//                                     restaurantServiceTimeStartController,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: getProportionateScreenWidth(10),
//                           ),

//                           // thoi gian ket thuc  --------------------------------------------------------------------------
//                           Expanded(
//                             child: SizedBox(
//                               height: getProportionateScreenHeight(40),
//                               child: buildTextFormFieldThoiGianPhucVuKeThuc(
//                                 ref: ref,
//                                 kiemtraFunction: () {
//                                   isShowTextFormFielThoiGianPhucVu.value =
//                                       !isShowTextFormFielThoiGianPhucVu.value;
//                                 },
//                                 ThoiGianPhucVuKetThucController:
//                                     restaurantServiceTimeEndController,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   : Expanded(
//                       child: Row(
//                         children: [
//                           Text(restaurantServiceTimeStartController.text),
//                           SizedBox(
//                             width: getProportionateScreenWidth(10),
//                           ),
//                           Text(':'),
//                           SizedBox(
//                             width: getProportionateScreenWidth(10),
//                           ),
//                           Text(restaurantServiceTimeEndController.text),
//                         ],
//                       ),
//                     ),
//               if (isShowTextFormFielCapNhat.value)
//                 TextButton(
//                     onPressed: () {
//                       isShowTextFormFielThoiGianPhucVu.value =
//                           !isShowTextFormFielThoiGianPhucVu.value;
//                     },
//                     child: isShowTextFormFielThoiGianPhucVu.value
//                         ? Text(" kiem tra")
//                         : Text(" nhap lai"))
//             ],
//           ),

//  Row(
//             children: [
//               Text('thoi gian phuc vu:'),
//               SizedBox(
//                 width: isShowTextFormFielThoiGianPhucVu.value
//                     ? getProportionateScreenWidth(6)
//                     : getProportionateScreenWidth(14),
//               ),
//               isShowTextFormFielThoiGianPhucVu.value
//                   ? Expanded(
//                       child: Row(
//                         children: [
//                           // thoi gian bat dau
//                           Expanded(
//                             child: SizedBox(
//                               height: getProportionateScreenHeight(40),
//                               child: buildTextFormFieldThoiGianPhucVuBatDAU(
//                                 ref: ref,
//                                 kiemtraFunction: () {
//                                   isShowTextFormFielThoiGianPhucVu.value =
//                                       !isShowTextFormFielThoiGianPhucVu.value;
//                                 },
//                                 ThoiGianPhucVuBatDauController:
//                                     restaurantServiceTimeStartController,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: getProportionateScreenWidth(10),
//                           ),

//                           // thoi gian ket thuc  --------------------------------------------------------------------------
//                           Expanded(
//                             child: SizedBox(
//                               height: getProportionateScreenHeight(40),
//                               child: buildTextFormFieldThoiGianPhucVuKeThuc(
//                                 ref: ref,
//                                 kiemtraFunction: () {
//                                   isShowTextFormFielThoiGianPhucVu.value =
//                                       !isShowTextFormFielThoiGianPhucVu.value;
//                                 },
//                                 ThoiGianPhucVuKetThucController:
//                                     restaurantServiceTimeEndController,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   : Expanded(
//                       child: Row(
//                         children: [
//                           Text(restaurantServiceTimeStartController.text),
//                           SizedBox(
//                             width: getProportionateScreenWidth(10),
//                           ),
//                           Text(':'),
//                           SizedBox(
//                             width: getProportionateScreenWidth(10),
//                           ),
//                           Text(restaurantServiceTimeEndController.text),
//                         ],
//                       ),
//                     ),
//               if (isShowTextFormFielCapNhat.value)
//                 TextButton(
//                     onPressed: () {
//                       isShowTextFormFielThoiGianPhucVu.value =
//                           !isShowTextFormFielThoiGianPhucVu.value;
//                     },
//                     child: isShowTextFormFielThoiGianPhucVu.value
//                         ? Text(" kiem tra")
//                         : Text(" nhap lai"))
//             ],
//           ),
