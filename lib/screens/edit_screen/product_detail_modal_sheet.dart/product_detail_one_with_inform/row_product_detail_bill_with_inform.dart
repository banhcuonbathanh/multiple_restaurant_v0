import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';

class RowProductDetailBill extends StatefulWidget {
  final TextEditingController billSanPhamController;
  final WidgetRef ref;
  final String? serverProductBill;
  RowProductDetailBill({
    Key? key,
    required this.serverProductBill,
    required this.ref,
    required this.billSanPhamController,
  }) : super(key: key);
  @override
  State<RowProductDetailBill> createState() => _RowProductNameState();
}

class _RowProductNameState extends State<RowProductDetailBill> {
  bool isShowTextFormField = true;
  @override
  void initState() {
    //  kiem tra d/k de hien restaurantName
    if (widget.serverProductBill != null) {
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
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(30),
            child: buildTextFormFieldTenSanPham(
                ref: widget.ref,
                tenSanPhamController: widget.billSanPhamController),
          ),
        // --------------------------------------
        if (!isShowTextFormField)
          Container(
            alignment: Alignment.centerLeft,
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(30),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isShowTextFormField = true;
                  widget.billSanPhamController.text = '';
                });
              },
              child: Text(
                  widget.billSanPhamController.text != ''
                      ? widget.billSanPhamController.text
                      : widget.serverProductBill!,
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
      hintText: 'Tiền Sản Phẩm',
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return;
      }

      return null;
    },
  );
}
