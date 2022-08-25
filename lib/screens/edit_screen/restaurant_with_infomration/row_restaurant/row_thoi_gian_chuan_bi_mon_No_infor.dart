import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';
import '../../../../constants.dart';

class RowThoiGianChuanBiMonAwnNoInfor extends StatefulWidget {
  final TextEditingController restaurantTimeMealPreparationController;
  final WidgetRef ref;

  final double restaurantMealPreparation;

  RowThoiGianChuanBiMonAwnNoInfor({
    Key? key,
    required this.restaurantMealPreparation,
    required this.ref,
    required this.restaurantTimeMealPreparationController,
  }) : super(key: key);

  @override
  State<RowThoiGianChuanBiMonAwnNoInfor> createState() =>
      _RowThoiGianChuanBiMonAwnState();
}

class _RowThoiGianChuanBiMonAwnState
    extends State<RowThoiGianChuanBiMonAwnNoInfor> {
  bool isShowTextFormField = true;
  @override
  void initState() {
    //  kiem tra d/k de hien restaurantName
    if (widget.restaurantMealPreparation != null) {
      isShowTextFormField = true;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Thơì Gian Chuẩnn Bị :'),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        if (!isShowTextFormField)
          Container(
            // color: Colors.blue,
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(150),
            child: buildTextFormFieldDiaChiCuaHang(
                ref: widget.ref,
                ThoiGianChuanBiMonAnController:
                    widget.restaurantTimeMealPreparationController),
          ),
        // --------------------------------------
        if (isShowTextFormField)
          Container(
            alignment: Alignment.centerLeft,
            // padding: EdgeInsets.symmetric(
            //     horizontal: getProportionateScreenWidth(0),
            //     vertical: getProportionateScreenHeight(0)),
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(150),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isShowTextFormField = false;
                  widget.restaurantTimeMealPreparationController.text = '';
                });
              },
              child: Text(
                  widget.restaurantTimeMealPreparationController.text != ''
                      ? widget.restaurantTimeMealPreparationController.text
                      : widget.restaurantMealPreparation.toString(),
                  style: TextStyle(fontSize: getProportionateScreenHeight(14))),
            ),
          ),

        // -------------------------------------
      ],
    );
  }
}

Widget buildTextFormFieldDiaChiCuaHang({
  required TextEditingController ThoiGianChuanBiMonAnController,
  required WidgetRef ref,
}) {
  return TextFormField(
    style: TextStyle(fontSize: getProportionateScreenHeight(14)),
    controller: ThoiGianChuanBiMonAnController,
    keyboardType: TextInputType.emailAddress,
    onChanged: (value) {},
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
        return 'Nhập Thời Gian Chuẩn Bị';
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