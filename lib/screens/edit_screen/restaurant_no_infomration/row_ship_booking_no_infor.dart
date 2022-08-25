import 'package:flutter/material.dart';
import 'package:untitled1/size_config.dart';

import '../../../components/custom_buttom.dart';

class RowShipBookingNoInfor extends StatefulWidget {
  final bool isShip;
  final bool isBooking;
  final Function() isShipFun;
  final Function() isBookingFun;
  const RowShipBookingNoInfor(
      {Key? key,
      required this.isShip,
      required this.isBooking,
      required this.isShipFun,
      required this.isBookingFun})
      : super(key: key);

  @override
  State<RowShipBookingNoInfor> createState() => _RowShipBookingNoInforState();
}

class _RowShipBookingNoInforState extends State<RowShipBookingNoInfor> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Ship , Booking : '),
        SizedBox(
          width: getProportionateScreenWidth(5),
        ),
        CustomerButton(
          buttonHeight: 35,
          buttonWidth: 80,
          text: 'Ship',
          BorderRadiuscircular: 10,
          press: () {
            setState(() {
              widget.isShipFun();
            });
          },
          backgoundColor: widget.isShip ? null : Colors.grey.shade300,
        ),
        SizedBox(
          width: getProportionateScreenWidth(20),
        ),
        CustomerButton(
          buttonHeight: 35,
          buttonWidth: 80,
          text: 'Booking',
          BorderRadiuscircular: 10,
          press: () {
            setState(() {
              widget.isBookingFun();
            });
          },
          backgoundColor: widget.isBooking ? null : Colors.grey.shade300,
        ),
        SizedBox(
          width: getProportionateScreenWidth(60),
        ),
      ],
    );
  }
}
