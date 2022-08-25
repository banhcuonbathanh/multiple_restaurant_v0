import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';

class RowProductDetailPromotion extends StatefulWidget {
  final TextEditingController promotionSanPhamController;
  final WidgetRef ref;
  final String? serverProductPromotion;
  RowProductDetailPromotion({
    Key? key,
    required this.serverProductPromotion,
    required this.ref,
    required this.promotionSanPhamController,
  }) : super(key: key);
  @override
  State<RowProductDetailPromotion> createState() => _RowProductNameState();
}

class _RowProductNameState extends State<RowProductDetailPromotion> {
  bool isShowTextFormField = true;
  @override
  void initState() {
    //  kiem tra d/k de hien restaurantName
    if (widget.serverProductPromotion != null) {
      isShowTextFormField = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (isShowTextFormField)
          Container(
            alignment: Alignment.topLeft,
            // color: Colors.blue,
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(40),
            child: buildTextFormFieldTenSanPham(
                ref: widget.ref,
                tenSanPhamController: widget.promotionSanPhamController),
          ),
        // --------------------------------------
        if (!isShowTextFormField)
          Container(
            alignment: Alignment.topLeft,
            height: getProportionateScreenHeight(30),
            width: getProportionateScreenWidth(60),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isShowTextFormField = true;
                  widget.promotionSanPhamController.text = '';
                });
              },
              child: Text(
                  widget.promotionSanPhamController.text != ''
                      ? widget.promotionSanPhamController.text
                      : 'KM:' + widget.serverProductPromotion! + "%",
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
      hintText: 'Khuyến Mại',
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return;
      }

      return null;
    },
  );
}
