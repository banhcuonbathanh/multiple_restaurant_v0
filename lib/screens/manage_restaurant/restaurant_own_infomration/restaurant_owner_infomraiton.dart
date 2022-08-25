import 'package:flutter/material.dart';
import 'package:untitled1/size_config.dart';

import '../../../model/user_model.dart';

class RestaurantOwnerInformation extends StatelessWidget {
  const RestaurantOwnerInformation({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final UserModel? userData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade500),
              // color: Colors.blue,
              borderRadius: BorderRadius.circular(10)),
          height: getProportionateScreenHeight(60),
          // width: 20,
          child: Text('chon anh'),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userData!.userName!,
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
            Text(
              'Số Người Theo Dõi: 30 ',
              style: TextStyle(fontSize: 13),
            ),
            Text(
              'Số Người Đang Theo Dõi: 17',
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }
}
