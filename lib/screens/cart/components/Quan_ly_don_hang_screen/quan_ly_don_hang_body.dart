import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'category_quan_ly_don_hang/category_quan_ly_don_hang.dart';
import 'cho_xac_nhan/1cho_xac_nhan_body.dart';

class DeliveryScreen extends HookConsumerWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        children: [
          Text('Quản Lý Đơn Hàng', style: TextStyle(fontSize: 25)),
          Divider(),
          CategoryQuanLyDonHang(
            funcIsCanceled: funcIsCanceled,
            funcIsShowConfirm: funcIsShowConfirm,
            funcIsShowWaitingConfirm: funcIsShowWaitingConfirm,
          ),
          Expanded(
            child: ChoXacNhanBody(),
          ),
        ],
      ),
    );
  }

  //   SafeArea(
  //     child: ListView(
  //       shrinkWrap: true,
  //       primary: true,
  //       children: [
  //         Text('Quản Lý Đơn Hàng', style: TextStyle(fontSize: 25)),
  //         Divider(),
  //         CategoryOrder(
  //           funcIsCanceled: funcIsCanceled,
  //           funcIsShowConfirm: funcIsShowConfirm,
  //           funcIsShowWaitingConfirm: funcIsShowWaitingConfirm,
  //         ),
  //         Divider(),
  //         ChoXacNhan(),
  //       ],
  //     ),
  //   );
  // }

  funcIsCanceled() {
    print('funcIsCanceled');
  }

  funcIsShowConfirm() {}
  funcIsShowWaitingConfirm() {
    print('funcIsShowWaitingConfirm');
  }
}
