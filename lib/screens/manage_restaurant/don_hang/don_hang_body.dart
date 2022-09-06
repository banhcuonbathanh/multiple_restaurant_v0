import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'da_xac_nhan/1da_xac_nhan_body.dart';
import 'dat_hang/1dat_hang_body.dart';
import 'don_hang_category/don_hang_category.dart';
import 'hoan_thanh/1hoan_thanh_body.dart';
import 'huy/1huy_body.dart';

class DonHangBody extends HookConsumerWidget {
  static String routeName = "/Don_Hang_Body";

  const DonHangBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restart = useState(true);
    final isShowChoXacNhan = useState<bool>(true);
    final isShowXacNhan = useState<bool>(false);
    final isShowHoanThanh = useState<bool>(false);
    final isShowHuy = useState<bool>(false);

    selectionScreen(int id) {
      switch (id) {
        case 0:
          isShowChoXacNhan.value = true;
          isShowXacNhan.value = false;
          isShowHoanThanh.value = false;
          isShowHuy.value = false;
          break;

        case 1:
          isShowChoXacNhan.value = false;
          isShowXacNhan.value = true;
          isShowHoanThanh.value = false;
          isShowHuy.value = false;
          break;
        case 2:
          isShowChoXacNhan.value = false;
          isShowXacNhan.value = false;
          isShowHoanThanh.value = true;
          isShowHuy.value = false;
          break;
        case 3:
          isShowChoXacNhan.value = false;
          isShowXacNhan.value = false;
          isShowHoanThanh.value = false;
          isShowHuy.value = true;
          break;
        default:
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quản Lý Đơn Hàng',
            style: TextStyle(fontSize: 25, color: Colors.grey)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CategoryDonHang(
              funcIsCompleted: () {
                selectionScreen(2);
              },
              funcIsShowConfirm: () {
                selectionScreen(1);
              },
              funcIsShowWaitingConfirm: () {
                selectionScreen(0);
              },
              funcIsShowCalceled: () {
                selectionScreen(3);
              },
            ),
            const Divider(),
            if (isShowChoXacNhan.value)
              Expanded(
                child: DatHangBody(
                  restartFunc: () {
                    print('>>>>>>>>>>>>>>>>>>>>');
                    restart.value = !restart.value;
                  },
                  // restartFunc: () {
                  //   restartFunc();
                  // },
                ),
              ),
            if (isShowXacNhan.value)
              Expanded(
                child: DaXacNhanBody(
                  restartFunc: () {
                    restart.value = !restart.value;
                  },
                ),
              ),
            if (isShowHoanThanh.value)
              Expanded(
                child: HoanThanhBodyamnagerRestaurant(
                  restartFunc: () {
                    restart.value = !restart.value;
                  },
                ),
              ),
            if (isShowHuy.value)
              Expanded(
                child: HuyBody(
                  restartFunc: () {
                    restart.value = !restart.value;
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
