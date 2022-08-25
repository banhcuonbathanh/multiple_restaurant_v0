import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';

import '../../../../constants.dart';

class RowCuaHangWithInformation extends StatefulWidget {
  final TextEditingController restaurantController;
  final WidgetRef ref;
  final String? restaurantName;

  RowCuaHangWithInformation({
    Key? key,
    required this.restaurantName,
    required this.ref,
    required this.restaurantController,
  }) : super(key: key);

  @override
  State<RowCuaHangWithInformation> createState() => _RowCuaHangState();
}

class _RowCuaHangState extends State<RowCuaHangWithInformation> {
  bool isShowTextFormField = true;
  @override
  void initState() {
    //  kiem tra d/k de hien restaurantName
    if (widget.restaurantName != null) {
      isShowTextFormField = true;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Cửa Hàng :'),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        if (!isShowTextFormField)
          Container(
            // color: Colors.blue,
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(150),
            child: buildTextFormFieldRestaurantName1(
                ref: widget.ref,
                restaurantController: widget.restaurantController),
          ),
        // --------------------------------------
        if (isShowTextFormField)
          Container(
            alignment: Alignment.centerLeft,
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(150),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isShowTextFormField = false;
                  widget.restaurantController.text = '';
                });
              },
              child: Text(
                  widget.restaurantController.text != ''
                      ? widget.restaurantController.text
                      : widget.restaurantName!,
                  style: TextStyle(fontSize: getProportionateScreenHeight(14))),
            ),
          ),
      ],
    );
  }
}

Widget buildTextFormFieldRestaurantName1({
  required TextEditingController restaurantController,
  required WidgetRef ref,
}) {
  return TextFormField(
    style: TextStyle(fontSize: getProportionateScreenHeight(14)),
    controller: restaurantController,
    keyboardType: TextInputType.emailAddress,
    onChanged: (value) {},
    onSaved: (value) {
      restaurantController.text = value!;
    },
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        // borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      // border: new OutlineInputBorder(
      //   borderRadius: new BorderRadius.circular(1.0),
      //   borderSide: new BorderSide(),
      // ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(1),
          vertical: getProportionateScreenHeight(1)),
      hintText: 'Nhập Tên Quán',
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Nhập Tên Quán';
      }

      return null;
    },
  );
}
