import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';
import '../../../../constants.dart';

class RowToppingName extends StatefulWidget {
  final TextEditingController tenToppingController;
  final WidgetRef ref;
  final String? toppingServerName;
  RowToppingName({
    Key? key,
    required this.toppingServerName,
    required this.ref,
    required this.tenToppingController,
  }) : super(key: key);
  @override
  State<RowToppingName> createState() => _RowProductNameState();
}

class _RowProductNameState extends State<RowToppingName> {
  bool isShowTextFormField = true;
  bool toppingNameInput = true;
  @override
  void initState() {
    //  kiem tra d/k de hien restaurantName
    if (widget.toppingServerName != null) {
      isShowTextFormField = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isUserInputFuncfalseName = () {
      setState(() {
        toppingNameInput = false;
        print('toppingNameInput');
      });
    };
    var isUserInputFuncTrueName = () {
      setState(() {
        toppingNameInput = true;
      });
    };

    return Row(
      children: [
        if (isShowTextFormField)
          Container(
            // color: Colors.blue,
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(50),
            child: buildTextFormFieldTenSanPham(
              ref: widget.ref,
              tenSanPhamController: widget.tenToppingController,
              isUserInputFuncfalseName: isUserInputFuncfalseName,
              isUserInputFuncTrueName: isUserInputFuncTrueName,
              productNameInput: toppingNameInput,
            ),
          ),
        // --------------------------------------
        if (!isShowTextFormField)
          Container(
            alignment: Alignment.centerLeft,
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(150),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isShowTextFormField = true;
                  widget.tenToppingController.text = '';
                });
              },
              child: Text(
                  widget.tenToppingController.text != ''
                      ? widget.tenToppingController.text
                      : widget.toppingServerName!,
                  style: TextStyle(fontSize: getProportionateScreenHeight(14))),
            ),
          ),
      ],
    );
  }
}

Widget buildTextFormFieldTenSanPham({
  required TextEditingController tenSanPhamController,
  required WidgetRef ref,
  required Function isUserInputFuncfalseName,
  required Function isUserInputFuncTrueName,
  required bool productNameInput,
}) {
  return TextFormField(
    style: TextStyle(fontSize: getProportionateScreenHeight(14)),
    controller: tenSanPhamController,
    keyboardType: TextInputType.emailAddress,
    onChanged: (value) {
      isUserInputFuncTrueName();
    },
    onSaved: (value) {
      tenSanPhamController.text = value!;
    },
    decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
          // borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(1),
            vertical: getProportionateScreenHeight(1)),
        hintText: 'Tên Sản Phẩm',
        hintStyle:
            TextStyle(color: productNameInput ? Colors.black : Colors.red)),
    validator: (value) {
      if (value!.isEmpty) {
        isUserInputFuncfalseName();
        return;
      }

      return null;
    },
  );
}
