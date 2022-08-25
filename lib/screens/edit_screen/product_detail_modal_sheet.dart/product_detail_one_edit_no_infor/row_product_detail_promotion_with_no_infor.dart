import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';

class ProductDetailPromotionNoInform extends StatefulWidget {
  final TextEditingController promotionController;

  final WidgetRef ref;

  final double? giaThapNhatServer;

  ProductDetailPromotionNoInform({
    Key? key,
    required this.giaThapNhatServer,
    required this.ref,
    required this.promotionController,
  }) : super(key: key);

  @override
  State<ProductDetailPromotionNoInform> createState() => _GiaSanPhamState();
}

class _GiaSanPhamState extends State<ProductDetailPromotionNoInform> {
  bool isShowTextFormFieldGiaThapNhat = true;

  bool giaThapInput = true;
  @override
  void initState() {
    //  kiem tra d/k de hien restaurantName
    if (widget.giaThapNhatServer != null) {
      isShowTextFormFieldGiaThapNhat = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isUserInputFuncfalseGiaThap = () {
      setState(() {
        giaThapInput = false;
      });
    };
    var isUserInputFuncTrueGiaThap = () {
      setState(() {
        giaThapInput = true;
      });
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            if (isShowTextFormFieldGiaThapNhat)
              Container(
                // color: Colors.blue,
                height: getProportionateScreenHeight(30),
                width: getProportionateScreenWidth(150),
                child: buildTextFormFieldGiaThapNhat(
                  ref: widget.ref,
                  giaThapNhatController: widget.promotionController,
                  isUserInputFuncfalseGiaThap: isUserInputFuncfalseGiaThap,
                  isUserInputFuncTrueGiaThap: isUserInputFuncTrueGiaThap,
                  giaThapInput: giaThapInput,
                ),
              ),
            // --------------------------------------
            if (!isShowTextFormFieldGiaThapNhat)
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
                      isShowTextFormFieldGiaThapNhat = true;
                      widget.promotionController.text = '';
                    });
                  },
                  child: Text(
                      widget.promotionController.text != ''
                          ? widget.promotionController.text
                          : widget.giaThapNhatServer!.toString(),
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(12))),
                ),
              ),

            // -------------------------------------
          ],
        ),
      ],
    );
  }
}

Widget buildTextFormFieldGiaThapNhat({
  required TextEditingController giaThapNhatController,
  required WidgetRef ref,
  required Function isUserInputFuncfalseGiaThap,
  required Function isUserInputFuncTrueGiaThap,
  required bool giaThapInput,
}) {
  return TextFormField(
    style: TextStyle(fontSize: getProportionateScreenHeight(14)),
    controller: giaThapNhatController,
    keyboardType: TextInputType.emailAddress,
    onChanged: (value) {
      isUserInputFuncTrueGiaThap();
    },
    onSaved: (value) {
      giaThapNhatController.text = value!;
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
        hintText: 'Khuyến Mại',
        hintStyle: TextStyle(color: giaThapInput ? Colors.black : Colors.red)),
    validator: (value) {
      if (value!.isEmpty) {
        isUserInputFuncfalseGiaThap();
        return;
      }

      return null;
    },
  );
}
