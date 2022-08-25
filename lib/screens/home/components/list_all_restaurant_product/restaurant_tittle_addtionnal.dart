import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/utility_provider.dart';

class RestaurantTitleAdditional extends HookConsumerWidget {
  final String restaurantName;
  final int index;
  final ScrollController controller;
  const RestaurantTitleAdditional(
      {required this.controller,
      required this.index,
      Key? key,
      required this.restaurantName})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late double offsety = 0;
    double location = 0;
    final deviceheigh = MediaQuery.of(context).size.height;

    final widgetoffsetData = ref.watch(Utility.widgetOffSet);

    final restaurantLocation = widgetoffsetData['${restaurantName}'];
    useEffect(() {
      // get dy of widget
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final box = context.findRenderObject() as RenderBox;
        location = box.localToGlobal(Offset.zero).dy - deviceheigh / 2;

// store dy
        ref
            .read(Utility.widgetOffSet.notifier)
            .addwidgetoffset(restaurantName, location);
      });
    });
    useEffect(() {
      controller.addListener(() {
        final box = context.findRenderObject() as RenderBox;
        offsety = box.localToGlobal(Offset.zero).dy;

        if (offsety < (deviceheigh) / 2 && offsety > 0) {
          ref
              .read(Utility.restaurantIsShow.notifier)
              .isOnScreen(restaurantName: restaurantName);
        }
      });
    }, [controller]);

    return Text('');
  }
}
