import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';

import '../../../../constants.dart';

class RowDiaChiQuanWithInfor extends StatefulWidget {
  final TextEditingController restaurantAddressController;
  final WidgetRef ref;

  final String? restaurantAdrress;

  RowDiaChiQuanWithInfor({
    Key? key,
    required this.restaurantAdrress,
    required this.ref,
    required this.restaurantAddressController,
  }) : super(key: key);

  @override
  State<RowDiaChiQuanWithInfor> createState() => _RowDiaChiQuanState();
}

class _RowDiaChiQuanState extends State<RowDiaChiQuanWithInfor> {
  bool isShowTextFormField = true;

  @override
  void initState() {
    if (widget.restaurantAdrress != null) {
      isShowTextFormField = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Địa Chỉ Quán :'),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        if (isShowTextFormField)
          Container(
            // color: Colors.blue,
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(150),
            child: buildTextFormFieldDiaChiCuaHang(
                ref: widget.ref,
                diaChiCuaHangController: widget.restaurantAddressController),
          ),
        // --------------------------------------
        if (!isShowTextFormField)
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
                  isShowTextFormField = true;
                  widget.restaurantAddressController.text = '';
                });
              },
              child: Text(
                  widget.restaurantAddressController.text != ''
                      ? widget.restaurantAddressController.text
                      : widget.restaurantAdrress!,
                  style: TextStyle(fontSize: getProportionateScreenHeight(14))),
            ),
          ),

        // -------------------------------------
      ],
    );
  }
}

Widget buildTextFormFieldDiaChiCuaHang({
  required TextEditingController diaChiCuaHangController,
  required WidgetRef ref,
}) {
  return TextFormField(
    style: TextStyle(fontSize: getProportionateScreenHeight(14)),
    controller: diaChiCuaHangController,
    keyboardType: TextInputType.emailAddress,
    onChanged: (value) {},
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
        return 'Nhập Địa Chỉ Quán';
      }

      return null;
    },
  );
}
