import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';

class ProductDetailPriceNoInform extends StatefulWidget {
  final TextEditingController giaThapNhatController;

  final WidgetRef ref;

  final double? giaThapNhatServer;

  ProductDetailPriceNoInform({
    Key? key,
    required this.giaThapNhatServer,
    required this.ref,
    required this.giaThapNhatController,
  }) : super(key: key);

  @override
  State<ProductDetailPriceNoInform> createState() => _GiaSanPhamState();
}

class _GiaSanPhamState extends State<ProductDetailPriceNoInform> {
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
                width: getProportionateScreenWidth(70),
                child: buildTextFormFieldGiaThapNhat(
                  ref: widget.ref,
                  giaThapNhatController: widget.giaThapNhatController,
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
                width: getProportionateScreenWidth(50),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isShowTextFormFieldGiaThapNhat = true;
                      widget.giaThapNhatController.text = '';
                    });
                  },
                  child: Text(
                      widget.giaThapNhatController.text != ''
                          ? widget.giaThapNhatController.text
                          : widget.giaThapNhatServer!.toString(),
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
        hintText: 'Giá Sản Phẩm',
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
