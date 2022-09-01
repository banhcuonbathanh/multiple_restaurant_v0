import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'category_quan_ly_don_hang/category_quan_ly_don_hang.dart';
import 'cho_xac_nhan/1cho_xac_nhan_body.dart';
import 'hoan_thanh/1hoan_thanh_body.dart';
import 'xac_nhan/1xac_nhan_body.dart';

class QuanLyDonHang extends HookConsumerWidget {
  final Function restartFunc;
  const QuanLyDonHang({required this.restartFunc, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build QuanLyDonHang');
    final restart = useState(true);
    final isShowChoXacNhan = useState<bool>(true);
    final isShowXacNhan = useState<bool>(false);
    final isShowHoanThanh = useState<bool>(false);

    selectionScreen(int id) {
      switch (id) {
        case 0:
          isShowChoXacNhan.value = true;
          isShowXacNhan.value = false;
          isShowHoanThanh.value = false;

          break;

        case 1:
          isShowChoXacNhan.value = false;
          isShowXacNhan.value = true;
          isShowHoanThanh.value = false;
          break;
        case 2:
          isShowChoXacNhan.value = false;
          isShowXacNhan.value = false;
          isShowHoanThanh.value = true;
          break;

        default:
      }
    }

    return SafeArea(
      child: Column(
        children: [
          Text('Quản Lý Đơn Hàng', style: TextStyle(fontSize: 25)),
          Divider(),
          CategoryQuanLyDonHang(
            funcIsCanceled: () {
              selectionScreen(2);
            },
            funcIsShowConfirm: () {
              selectionScreen(1);
            },
            funcIsShowWaitingConfirm: () {
              selectionScreen(0);
            },
          ),
          if (isShowChoXacNhan.value)
            Expanded(
              child: ChoXacNhanBody(
                restartFunc: () {
                  restartFunc();
                },
              ),
            ),
          if (isShowXacNhan.value)
            Expanded(
              child: XacNhanBody(),
            ),
          if (isShowHoanThanh.value)
            Expanded(
              child: HoanThanhBody(
                restartFunc: () {
                  restartFunc();
                },
              ),
            ),
        ],
      ),
    );
  }
}
