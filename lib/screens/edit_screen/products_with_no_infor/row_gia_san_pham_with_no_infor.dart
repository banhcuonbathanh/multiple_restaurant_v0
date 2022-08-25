import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';
import '../../../constants.dart';

class GiaSanPham extends StatefulWidget {
  final TextEditingController giaThapNhatController;
  final TextEditingController giaCaoNhatController;
  final WidgetRef ref;

  final double? giaThapNhatServer;
  final double? giaCaoNhatServer;

  GiaSanPham({
    Key? key,
    required this.giaThapNhatServer,
    required this.giaCaoNhatServer,
    required this.ref,
    required this.giaThapNhatController,
    required this.giaCaoNhatController,
  }) : super(key: key);

  @override
  State<GiaSanPham> createState() => _GiaSanPhamState();
}

class _GiaSanPhamState extends State<GiaSanPham> {
  bool isShowTextFormFieldGiaThapNhat = true;
  bool isShowTextFormFieldGiaCaoNhat = true;
  bool giaCaoInput = true;
  bool giaThapInput = true;
  @override
  void initState() {
    //  kiem tra d/k de hien restaurantName
    if (widget.giaThapNhatServer != null) {
      isShowTextFormFieldGiaThapNhat = false;
    }
    if (widget.giaCaoNhatServer != null) {
      isShowTextFormFieldGiaCaoNhat = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isUserInputFuncfalseGiaCao = () {
      setState(() {
        giaCaoInput = false;
      });
    };
    var isUserInputFuncTrueGiaCao = () {
      setState(() {
        giaCaoInput = true;
      });
    };

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
        Row(
          children: [
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            if (isShowTextFormFieldGiaCaoNhat)
              Container(
                // color: Colors.blue,
                height: getProportionateScreenHeight(30),
                width: getProportionateScreenWidth(110),
                child: buildTextFormFieldGiaCaoNhat(
                  ref: widget.ref,
                  giaCaoNhatController: widget.giaCaoNhatController,
                  isUserInputFuncfalseGiaCao: isUserInputFuncfalseGiaCao,
                  isUserInputFuncTrueGiaCao: isUserInputFuncTrueGiaCao,
                  giaCaoInput: giaCaoInput,
                ),
              ),
            // --------------------------------------
            if (!isShowTextFormFieldGiaCaoNhat)
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
                      isShowTextFormFieldGiaCaoNhat = true;
                      widget.giaCaoNhatController.text = '';
                    });
                  },
                  child: Text(
                      widget.giaCaoNhatController.text != ''
                          ? widget.giaCaoNhatController.text
                          : widget.giaCaoNhatServer!.toString(),
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
        hintText: 'Giá Thấp',
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

Widget buildTextFormFieldGiaCaoNhat({
  required TextEditingController giaCaoNhatController,
  required WidgetRef ref,
  required Function isUserInputFuncfalseGiaCao,
  required Function isUserInputFuncTrueGiaCao,
  required bool giaCaoInput,
}) {
  return TextFormField(
    style: TextStyle(fontSize: getProportionateScreenHeight(14)),
    controller: giaCaoNhatController,
    keyboardType: TextInputType.emailAddress,
    onChanged: (value) {
      isUserInputFuncTrueGiaCao();
    },
    onSaved: (value) {
      giaCaoNhatController.text = value!;
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
            horizontal: getProportionateScreenWidth(10),
            vertical: getProportionateScreenHeight(10)),
        hintText: 'Giá Cao',
        hintStyle: TextStyle(color: giaCaoInput ? Colors.black : Colors.red)),
    validator: (value) {
      if (value!.isEmpty) {
        isUserInputFuncfalseGiaCao();
        return;
      }

      return null;
    },
  );
}
