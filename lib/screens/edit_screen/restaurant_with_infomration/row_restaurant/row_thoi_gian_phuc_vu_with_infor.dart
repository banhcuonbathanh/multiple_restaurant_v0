import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';
import '../../../../constants.dart';

class RowThoiGianPhucVuwithInfor extends StatefulWidget {
  final TextEditingController ThoiGianPhucVuBatDauController;
  final TextEditingController ThoiGianPhucVuKetThucController;
  final WidgetRef ref;

  final double restaurantStartTime;
  final double restaurantEndingTime;

  RowThoiGianPhucVuwithInfor({
    Key? key,
    required this.restaurantStartTime,
    required this.restaurantEndingTime,
    required this.ref,
    required this.ThoiGianPhucVuBatDauController,
    required this.ThoiGianPhucVuKetThucController,
  }) : super(key: key);

  @override
  State<RowThoiGianPhucVuwithInfor> createState() => _RowThoiGianPhucVuState();
}

class _RowThoiGianPhucVuState extends State<RowThoiGianPhucVuwithInfor> {
  bool isShowTextFormFieldBatDau = true;
  bool isShowTextFormFieldKetThuc = true;
  @override
  void initState() {
    //  kiem tra d/k de hien restaurantName
    if (widget.restaurantStartTime != null) {
      isShowTextFormFieldBatDau = false;
    }
    if (widget.restaurantEndingTime != null) {
      isShowTextFormFieldKetThuc = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Thời Gian Phục Vụ '),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Từ : '),
            if (isShowTextFormFieldBatDau)
              Container(
                // color: Colors.blue,
                height: getProportionateScreenHeight(30),
                width: getProportionateScreenWidth(50),
                child: buildTextFormFieldThoiGianPhucVuBatDAU(
                    ref: widget.ref,
                    ThoiGianPhucVuBatDauController:
                        widget.ThoiGianPhucVuBatDauController),
              ),
            // --------------------------------------
            if (!isShowTextFormFieldBatDau)
              Container(
                alignment: Alignment.centerLeft,
                // padding: EdgeInsets.symmetric(
                //     horizontal: getProportionateScreenWidth(0),
                //     vertical: getProportionateScreenHeight(0)),
                height: getProportionateScreenHeight(30),
                width: getProportionateScreenWidth(50),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isShowTextFormFieldBatDau = true;
                      widget.ThoiGianPhucVuBatDauController.text = '';
                    });
                  },
                  child: Text(
                      widget.ThoiGianPhucVuBatDauController.text != ''
                          ? widget.ThoiGianPhucVuBatDauController.text
                          : widget.restaurantStartTime.toString(),
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(14))),
                ),
              ),

            // -------------------------------------
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Đến : '),
            if (isShowTextFormFieldKetThuc)
              Container(
                width: getProportionateScreenWidth(50),
                height: getProportionateScreenHeight(30),
                child: buildTextFormFieldThoiGianPhucVuKetThuc(
                    ref: widget.ref,
                    ThoiGianPhucVuKetThucController:
                        widget.ThoiGianPhucVuKetThucController),
              ),
            // --------------------------------------
            if (!isShowTextFormFieldKetThuc)
              Container(
                alignment: Alignment.centerLeft,
                // padding: EdgeInsets.symmetric(
                //     horizontal: getProportionateScreenWidth(0),
                //     vertical: getProportionateScreenHeight(0)),
                height: getProportionateScreenHeight(30),
                width: getProportionateScreenWidth(50),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isShowTextFormFieldKetThuc = true;
                      widget.ThoiGianPhucVuBatDauController.text = '';
                    });
                  },
                  child: Text(
                      widget.ThoiGianPhucVuBatDauController.text != ''
                          ? widget.ThoiGianPhucVuBatDauController.text
                          : widget.restaurantEndingTime.toString(),
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(14))),
                ),
              ),

            // -------------------------------------
          ],
        ),
      ],
    );
  }
}

Widget buildTextFormFieldThoiGianPhucVuKetThuc({
  required TextEditingController ThoiGianPhucVuKetThucController,
  required WidgetRef ref,
}) {
  return TextFormField(
    style: TextStyle(fontSize: getProportionateScreenHeight(14)),
    controller: ThoiGianPhucVuKetThucController,
    keyboardType: TextInputType.emailAddress,
    onChanged: (value) {},
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
        return 'Kết Thúc';
      }

      return null;
    },
  );
}

Widget buildTextFormFieldThoiGianPhucVuBatDAU({
  required TextEditingController ThoiGianPhucVuBatDauController,
  required WidgetRef ref,
}) {
  return TextFormField(
    style: TextStyle(fontSize: getProportionateScreenHeight(14)),
    controller: ThoiGianPhucVuBatDauController,
    keyboardType: TextInputType.emailAddress,
    onChanged: (value) {},
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
        return 'Bắt Đầu';
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