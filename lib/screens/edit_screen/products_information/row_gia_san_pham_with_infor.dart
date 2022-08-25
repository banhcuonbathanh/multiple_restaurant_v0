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
    return Row(
      children: [
        Row(
          children: [
            if (isShowTextFormFieldGiaThapNhat)
              Container(
                // color: Colors.blue,
                height: getProportionateScreenHeight(30),
                width: getProportionateScreenWidth(110),
                child: buildTextFormFieldGiaThapNhat(
                    ref: widget.ref,
                    giaThapNhatController: widget.giaThapNhatController),
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
                    giaCaoNhatController: widget.giaCaoNhatController),
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
}) {
  return TextFormField(
    style: TextStyle(fontSize: getProportionateScreenHeight(14)),
    controller: giaThapNhatController,
    keyboardType: TextInputType.emailAddress,
    onChanged: (value) {},
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
      hintText: 'Giá Thấp Nhất',
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Giá Thấp Nhất';
      }

      return null;
    },
  );
}

Widget buildTextFormFieldGiaCaoNhat({
  required TextEditingController giaCaoNhatController,
  required WidgetRef ref,
}) {
  return TextFormField(
    style: TextStyle(fontSize: getProportionateScreenHeight(14)),
    controller: giaCaoNhatController,
    keyboardType: TextInputType.emailAddress,
    onChanged: (value) {},
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
          horizontal: getProportionateScreenWidth(1),
          vertical: getProportionateScreenHeight(1)),
      hintText: 'Giá Cao Nhất',
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Giá Cao Nhất';
      }

      return null;
    },
  );
}
