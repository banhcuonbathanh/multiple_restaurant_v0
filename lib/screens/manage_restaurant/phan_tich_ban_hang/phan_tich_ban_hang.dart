import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';

import 'category_thoi_gian/selecting_time.dart';
import 'hom_qua/1analytic_screen.dart';

class PhanTichBanHang extends HookConsumerWidget {
  static String routeName = "/Phan_Tich_Ban_Hang";
  const PhanTichBanHang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restart = useState<bool>(true);
    print(' build PhanTichBanHang');
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
          SelectingTime(
            restartFunc: () {
              restart.value = !restart.value;
            },
            // funcHomQua: () {}, func7Ngay: () {}, func30Ngay: () {}
          ),
          Divider(),
          Expanded(
            child: AnalyticScreen(),
          ),
        ],
      ),
    );
  }
}
