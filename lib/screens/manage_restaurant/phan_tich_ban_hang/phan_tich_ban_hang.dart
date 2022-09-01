import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled1/size_config.dart';

import 'category_thoi_gian/category_quan_ly_don_hang.dart';
import 'hom_qua/hom_qua.dart';

class PhanTichBanHang extends StatelessWidget {
  static String routeName = "/Phan_Tich_Ban_Hang";
  const PhanTichBanHang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'phan tich ban hang',
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ),
      body: Column(
        // shrinkWrap: true,
        children: [
          CategoryPhanTichDonHang(
              funcHomQua: () {}, func7Ngay: () {}, func30Ngay: () {}),
          Divider(),
          Expanded(
            child: HomQuaBody(),
          ),
        ],
      ),
    );
  }
}
