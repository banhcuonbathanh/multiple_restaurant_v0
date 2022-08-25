import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';

class RowProductDetailPrice extends StatefulWidget {
  final TextEditingController priceSanPhamController;
  final WidgetRef ref;
  final String? serverProductPrice;
  RowProductDetailPrice({
    Key? key,
    required this.serverProductPrice,
    required this.ref,
    required this.priceSanPhamController,
  }) : super(key: key);
  @override
  State<RowProductDetailPrice> createState() => _RowProductNameState();
}

class _RowProductNameState extends State<RowProductDetailPrice> {
  bool isShowTextFormField = true;
  @override
  void initState() {
    //  kiem tra d/k de hien restaurantName
    if (widget.serverProductPrice != null) {
      isShowTextFormField = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isShowTextFormField)
          Container(
            // color: Colors.blue,
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(40),
            child: buildTextFormFieldTenSanPham(
                ref: widget.ref,
                tenSanPhamController: widget.priceSanPhamController),
          ),
        // --------------------------------------
        if (!isShowTextFormField)
          Container(
            // color: Colors.blue,
            alignment: Alignment.centerLeft,
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(40),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isShowTextFormField = true;
                  widget.priceSanPhamController.text = '';
                });
              },
              child: Text(
                  widget.priceSanPhamController.text != ''
                      ? widget.priceSanPhamController.text
                      : widget.serverProductPrice!,
                  overflow: TextOverflow.ellipsis,
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
