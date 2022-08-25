import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';
import '../../../constants.dart';

class RowProductName extends StatefulWidget {
  final TextEditingController tenSanPhamController;
  final WidgetRef ref;
  final String? serverProductName;
  RowProductName({
    Key? key,
    required this.serverProductName,
    required this.ref,
    required this.tenSanPhamController,
  }) : super(key: key);
  @override
  State<RowProductName> createState() => _RowProductNameState();
}

class _RowProductNameState extends State<RowProductName> {
  bool isShowTextFormField = true;
  @override
  void initState() {
    //  kiem tra d/k de hien restaurantName
    if (widget.serverProductName != null) {
      isShowTextFormField = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isShowTextFormField)
          Container(
            // color: Colors.blue,
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(150),
            child: buildTextFormFieldTenSanPham(
                ref: widget.ref,
                tenSanPhamController: widget.tenSanPhamController),
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
                  widget.tenSanPhamController.text = '';
                });
              },
              child: Text(
                  widget.tenSanPhamController.text != ''
                      ? widget.tenSanPhamController.text
                      : widget.serverProductName!,
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
}) {
  return TextFormField(
    style: TextStyle(fontSize: getProportionateScreenHeight(14)),
    controller: tenSanPhamController,
    keyboardType: TextInputType.emailAddress,
    onChanged: (value) {},
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
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return;
      }

      return null;
    },
  );
}
