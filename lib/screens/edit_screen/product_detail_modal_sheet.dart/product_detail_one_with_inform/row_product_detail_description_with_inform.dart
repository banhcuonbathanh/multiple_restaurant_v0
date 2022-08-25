import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';

class RowProductDetailDescription extends StatefulWidget {
  final TextEditingController descriptionSanPhamController;
  final WidgetRef ref;
  final String? serverProductDetailDescription;
  RowProductDetailDescription({
    Key? key,
    required this.serverProductDetailDescription,
    required this.ref,
    required this.descriptionSanPhamController,
  }) : super(key: key);
  @override
  State<RowProductDetailDescription> createState() => _RowProductNameState();
}

class _RowProductNameState extends State<RowProductDetailDescription> {
  bool isShowTextFormField = true;
  @override
  void initState() {
    //  kiem tra d/k de hien restaurantName
    if (widget.serverProductDetailDescription != null) {
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
                tenSanPhamController: widget.descriptionSanPhamController),
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
                  widget.descriptionSanPhamController.text = '';
                });
              },
              child: Text(
                  widget.descriptionSanPhamController.text != ''
                      ? widget.descriptionSanPhamController.text
                      : widget.serverProductDetailDescription!,
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
