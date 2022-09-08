import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/components/custom_container.dart';
import 'package:untitled1/size_config.dart';

import 'doanh_thu_category.dart';

class DoanhThu extends HookConsumerWidget {
  static String routeName = "/Doanh_Thu";
  const DoanhThu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime _selectedDate = DateTime(2023);
    final datel = useState<DateTime?>(null);
    final categoryIndex = useValueNotifier<int>(0);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doanh Thu',
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(getProportionateScreenWidth(10), 0,
            getProportionateScreenWidth(10), getProportionateScreenHeight(20)),
        child: Column(
          children: [
            DoanhThuCategory(categoryIndex: categoryIndex),
            Text(
              '0',
              style: TextStyle(fontSize: 40),
            ),
            // DropdownButton<DateTime>(
            //     onChanged: (ValueKey) {
            //       showDatePicker(
            //               context: context,
            //               initialDate: DateTime.now(),
            //               firstDate: DateTime(2022),
            //               lastDate: DateTime(2023))
            //           .then((value) => datel.value = value);
            //     },
            //     items: ['Choose A Date']
            //         .map((e) => DropdownMenuItem<DateTime>(child: Text(e)))
            //         .toList()),
            CustomContainer(child: Text('atest'), bottompadding: 20),
          ],
        ),
      ),
    );
  }
}
