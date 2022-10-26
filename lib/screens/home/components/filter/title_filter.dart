import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/size_config.dart';

class TitleFilter extends HookConsumerWidget {
  const TitleFilter({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rotatingAniCon =
        useAnimationController(duration: Duration(milliseconds: 300));
    final rotateAni =
        Tween<double>(begin: 1, end: -1.6).animate(rotatingAniCon);
    useEffect(() {
      rotatingAniCon.addStatusListener((status) {
        print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
        print(status);
      });
    });
    return Container(
      alignment: Alignment.center,
      height: getProportionateScreenHeight(50),
      decoration: BoxDecoration(
        // color: Colors.white,
        color: Colors.white.withOpacity(1),
        // kSecondaryColor,
        borderRadius: BorderRadius.circular(14),
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '    ${title}',
            style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: getProportionateScreenHeight(16)),
          ),
          Transform.rotate(
            angle: rotateAni.value,
            child: IconButton(
              onPressed: () {
                print(' testy buttonm trong TitleFilter');
                print(rotatingAniCon.status);
                if (rotatingAniCon.status == AnimationStatus.completed) {}
                rotatingAniCon.forward();
              },
              icon: Icon(Icons.chevron_left_sharp),
            ),
          ),
        ],
      ),
    );
  }
}
