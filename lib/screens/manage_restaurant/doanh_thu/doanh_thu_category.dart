import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:untitled1/size_config.dart';

class DoanhThuCategory extends StatelessWidget {
  const DoanhThuCategory({
    Key? key,
    required this.categoryIndex,
  }) : super(key: key);

  final ValueNotifier<int> categoryIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding:
              EdgeInsets.fromLTRB(0, 0, 0, getProportionateScreenHeight(8)),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      categoryIndex.value = 0;
                    },
                    child: HookBuilder(builder: (context) {
                      final asdfs = useValueListenable(categoryIndex);
                      return Text(
                        'Sẽ Thanh Toán',
                        style: TextStyle(
                            color: asdfs == 0
                                ? Colors.black
                                : Colors.grey.shade400),
                      );
                    }),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      categoryIndex.value = 1;
                    },
                    child: HookBuilder(builder: (context) {
                      final asdfs = useValueListenable(categoryIndex);
                      return Text(
                        'da Thanh Toán',
                        style: TextStyle(
                            color: asdfs == 1
                                ? Colors.black
                                : Colors.grey.shade400),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
        HookBuilder(builder: (context) {
          final asdfs = useValueListenable(categoryIndex);
          return AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            curve: Curves.fastLinearToSlowEaseIn,
            left: asdfs == 0
                ? getProportionateScreenWidth(30)
                : asdfs == 1
                    ? getProportionateScreenWidth(205)
                    : 0,
            bottom: 0,
            child: Container(
              width: getProportionateScreenWidth(120),
              height: getProportionateScreenHeight(4),
              decoration: ShapeDecoration(
                  shape: StadiumBorder(), color: Colors.orange.shade200),
            ),
          );
        })
      ],
    );
  }
}
