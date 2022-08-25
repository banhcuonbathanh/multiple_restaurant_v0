import 'package:flutter/material.dart';
import 'package:untitled1/size_config.dart';

import '../../../../components/custom_buttom.dart';

class RowShipBookingWithInfor extends StatefulWidget {
  bool isShip;
  final bool isShipServer;
  bool isBooking;
  final bool isBookingServer;
  final Function isShipFun;
  final Function isBookingFun;
  RowShipBookingWithInfor(
      {Key? key,
      required this.isShip,
      required this.isBooking,
      required this.isShipFun,
      required this.isBookingFun,
      required this.isShipServer,
      required this.isBookingServer})
      : super(key: key);

  @override
  State<RowShipBookingWithInfor> createState() => _RowShipBookingNoInforState();
}

class _RowShipBookingNoInforState extends State<RowShipBookingWithInfor> {
  @override
  void initState() {
    widget.isShip = widget.isShipServer;
    widget.isBooking = widget.isBookingServer;
    super.initState();
  }

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
              widget.isShipFun;
              widget.isShip = !widget.isShip;
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
              widget.isBookingFun;
              widget.isBooking = !widget.isBooking;
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
