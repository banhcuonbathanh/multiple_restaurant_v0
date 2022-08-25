import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';

class xoaButton extends HookConsumerWidget {
  xoaButton({
    required this.productdetaiId,
    required this.productId,
    Key? key,
  }) : super(key: key);
  final String productdetaiId;
  final String productId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('Xoá Thông Tin Sản Phẩm'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await ref
                            .read(AppStateProvider
                                .productDetailEditState.notifier)
                            .deleteProductDetailWithId(
                                productdetaiId: productdetaiId,
                                productId: productId);
                        Navigator.pop(context);
                      },
                      child: Text("Đồng Ý"),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(" Không"))
                  ],
                );
              });
        },
        child: Text("Xoá"));
  }
}
