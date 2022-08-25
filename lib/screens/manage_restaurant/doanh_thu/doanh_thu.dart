import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled1/size_config.dart';

class DoanhThu extends StatelessWidget {
  static String routeName = "/Doanh_Thu";
  const DoanhThu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doanh Thu',
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Sẽ Thanh Toán'),
                ),
                Expanded(
                  child: Text('Đã Thanh Toán'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
