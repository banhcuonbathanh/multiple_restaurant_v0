import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/app_provider/utility_provider.dart';
import 'package:untitled1/components/custom_buttom.dart';
import 'package:untitled1/components/snackbarcontent.dart';
import 'package:untitled1/model/restaurant_model.dart';
import 'package:untitled1/screens/home/components/section_title.dart';
import 'package:untitled1/size_config.dart';

class Timingorder extends HookConsumerWidget {
  const Timingorder({
    Key? key,
    required this.recevingHour,
    required this.recevingMinute,
    required this.recevingDay,
    required this.restaurantId,
  }) : super(key: key);

  final ValueNotifier<int> recevingHour;
  final ValueNotifier<int> recevingMinute;
  final ValueNotifier<String> recevingDay;
  final String restaurantId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CurrentTime = DateTime.parse(DateTime.now().toString());
    final currentHour = useState<int>(CurrentTime.hour);
    final currentMinut = useState<int>(CurrentTime.minute);

    final restauantsData =
        ref.watch(AppStateProvider.restaurantStateMap).values.toList();
    final restaurant = restauantsData
        .firstWhere(((element) => element.restaurantId == restaurantId));
    return Column(
      children: [
        Row(
          children: [
            Text(
                '   Hiện Tại:   ${currentHour.value} :  ${currentMinut.value}'),
          ],
        ),
        Row(
          children: [
            Text(
                '   Thời Gian Mở Hàng:   ${restaurant.restaurantStartTime} -  ${restaurant.restaurantEndingTime}'),
          ],
        ),
        TimeOrdering(
          restaurantData: restaurant,
        ),
      ],
    );
  }
}

class TimeOrdering extends HookConsumerWidget {
  const TimeOrdering({
    required this.restaurantData,
    Key? key,
  }) : super(key: key);

  final RestaurantModel restaurantData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return thoigiannhanHang(
      restaurantData: restaurantData,
    );
  }
}

class thoigiannhanHang extends HookConsumerWidget {
  final RestaurantModel restaurantData;

  thoigiannhanHang({required this.restaurantData, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restart = useState(true);
    // final restaurantsData =
    //     widget.ref.watch(AppStateProvider.restaurantNotifier);
    // final restaurantData = restaurantsData!
    //     .firstWhere((element) => element.restaurantId == widget.restaurantId);
    final CurrentTime = DateTime.parse(DateTime.now().toString());
    final currentHour = CurrentTime.hour;
    final currentMinut = CurrentTime.minute;
    final currentDay = CurrentTime.day;
    final isShowSelectHour = useState<bool>(false);
    final isShowSelectMinut = useState<bool>(false);
    final isTodaySelective = useState<bool>(false);
    final isTomorrowSelective = useState<bool>(false);
    final selectedMinuted = useState(0);
    final selectedHour = useState(0);

    final recevingDay = useState<int>(0);
    final recevingHour = useState<int>(0);
    final recevingMinute = useState<int>(0);
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '   Ngày Đặt Hàng :',
              style: TextStyle(
                  color: (isTodaySelective.value == false &&
                          isTomorrowSelective.value == false)
                      ? Colors.red
                      : Colors.black),
            ),
            if (restaurantData.restaurantEndingTime!.toInt() > currentHour)
              CustomerButton(
                  text: 'Hôm Nay',
                  press: () async {
                    // ---------------------------
                    // logich to chose today or tomorwew

                    if (isTodaySelective.value == true) {
                      // second click to cancel
                      isTodaySelective.value = false;
                    } else {
                      isTodaySelective.value = true;
                    }

                    isTomorrowSelective.value = false;
                    // ------------------------
                    recevingDay.value = currentDay;

                    await ref
                        .read(AppStateProvider.restaurantStateMap.notifier)
                        .searchRestaurantID(
                            restaurantId: restaurantData.restaurantId);
                    ref
                        .read(Utility.orderDay.notifier)
                        .orderday(day: recevingDay.value);
                  },
                  buttonHeight: getProportionateScreenHeight(25),
                  buttonWidth: getProportionateScreenWidth(80),
                  BorderRadiuscircular: 5,
                  backgoundColor:
                      isTodaySelective.value ? Colors.orange : Colors.grey),
            SizedBox(
              width: getProportionateScreenWidth(15),
            ),
            CustomerButton(
                text: 'Ngày Mai',
                press: () async {
                  // ---------------------------
                  // logich to chose today or tomorwew

                  if (isTomorrowSelective.value == true) {
                    // second click to cancel
                    isTomorrowSelective.value = false;
                  } else {
                    isTomorrowSelective.value = true;
                  }

                  isTodaySelective.value = false;
                  // ------------------------
                  recevingDay.value = currentDay + 1;
                  ref
                      .read(Utility.orderDay.notifier)
                      .orderday(day: recevingDay.value);
                  await ref
                      .read(AppStateProvider.restaurantStateMap.notifier)
                      .searchRestaurantID(
                          restaurantId: restaurantData.restaurantId);
                },
                buttonHeight: getProportionateScreenHeight(25),
                buttonWidth: getProportionateScreenWidth(80),
                BorderRadiuscircular: 5,
                backgoundColor:
                    isTomorrowSelective.value ? Colors.orange : Colors.grey),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text('   Thời Gian Nhận Hàng:'),
            Column(
              children: [
                CustomerButton(
                    text: selectedHour.value.toString(),
                    press: () async {
                      isShowSelectHour.value = !isShowSelectHour.value;
                    },
                    buttonHeight: getProportionateScreenHeight(20),
                    buttonWidth: getProportionateScreenWidth(40),
                    BorderRadiuscircular: 5,
                    backgoundColor:
                        (isShowSelectHour.value || selectedHour.value > 0)
                            ? Colors.orange
                            : Colors.grey),
              ],
            ),
            Text(':'),
            CustomerButton(
                text: selectedMinuted.value.toString(),
                press: () async {
                  isShowSelectMinut.value = !isShowSelectMinut.value;
                  // await ref
                  //     .read(AppStateProvider.restaurantStateMap.notifier)
                  //     .searchRestaurantID(
                  //         restaurantId: restaurantData.restaurantId);
                  // ref
                  //     .read(Utility.orderMinute.notifier)
                  //     .orderMinute(minute: selectedMinuted.value);
                },
                buttonHeight: getProportionateScreenHeight(20),
                buttonWidth: getProportionateScreenWidth(40),
                BorderRadiuscircular: 5,
                backgoundColor:
                    (isShowSelectMinut.value || selectedMinuted.value > 0)
                        ? Colors.orange
                        : Colors.grey),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        if (isShowSelectHour.value)
          ChoseHour(
            callback: (int val) {
              selectedHour.value = val;
              isShowSelectHour.value = !isShowSelectHour.value;
            },
            recevieDay: recevingDay.value,
            currentDay: currentDay,
            restaurantData: restaurantData,
            currentHour: currentHour,
          ),
        SizedBox(
          height: 10,
        ),
        if (isShowSelectMinut.value)
          ChoseMinute(
            callback: (selecnumber) {
              selectedMinuted.value = selecnumber;
              isShowSelectMinut.value = !isShowSelectMinut.value;
            },
            recevieDay: recevingDay.value,
            selectedHour: selectedHour.value,
            currentDay: currentDay,
            restaurantData: restaurantData,
          )
      ],
    );
  }
}

typedef void minuteSelective(int val);

class ChoseMinute extends HookConsumerWidget {
  const ChoseMinute({
    required this.restaurantData,
    required this.currentDay,
    required this.selectedHour,
    required this.recevieDay,
    required this.callback,
    Key? key,
  }) : super(key: key);

  final minuteSelective callback;
  final int recevieDay;
  final int selectedHour;
  final int currentDay;
  final RestaurantModel restaurantData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chooseNumber = useState<int?>(0);
    return Container(
      height: getProportionateScreenHeight(30),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 13,
          itemBuilder: (context, index) {
            final number = index * 5;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CustomerButton(
                  text: number.toString(),
                  press: () async {
                    chooseNumber.value = number;
                    callback(number);
                    // await ref
                    //     .read(AppStateProvider.restaurantStateMap.notifier)
                    //     .searchRestaurantID(
                    //         restaurantId: restaurantData.restaurantId);

                    ref
                        .read(Utility.orderMinute.notifier)
                        .orderMinute(minute: number);
                  },
                  buttonHeight: 20,
                  buttonWidth: 30,
                  BorderRadiuscircular: 5,
                  backgoundColor: chooseNumber.value == number
                      ? Colors.orange
                      : Colors.grey),
            );
          }),
    );
  }
}

typedef void hourSelective(int val);

class ChoseHour extends HookConsumerWidget {
  const ChoseHour({
    required this.currentHour,
    required this.restaurantData,
    required this.currentDay,
    required this.recevieDay,
    required this.callback,
    Key? key,
  }) : super(key: key);

  final minuteSelective callback;
  final int recevieDay;
  final int currentDay;
  final int currentHour;
  final RestaurantModel restaurantData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chooseNumber = useState<int?>(0);

    return Container(
      height: getProportionateScreenHeight(30),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: restaurantData.restaurantEndingTime!.toInt() -
              restaurantData.restaurantStartTime!.toInt(),
          itemBuilder: (context, index) {
            int numberPPear = 0;
            int testNumber = 0;
            int number = 0;
            bool? case1 = null;
            if (recevieDay == currentDay &&
                currentHour > restaurantData.restaurantStartTime!) {
              numberPPear =
                  restaurantData.restaurantEndingTime!.toInt() - currentHour;
              testNumber = numberPPear - index;
              number =
                  restaurantData.restaurantEndingTime!.toInt() - testNumber;
              case1 = true;
            } else {
              case1 = false;
              number = restaurantData.restaurantStartTime!.toInt() + index;
            }

            return case1
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: (testNumber > 0)
                        ? CustomerButton(
                            text: number.toString(),
                            press: () async {
                              chooseNumber.value = number;
                              callback(number);
                              // await ref
                              //     .read(AppStateProvider
                              //         .restaurantStateMap.notifier)
                              //     .searchRestaurantID(
                              //         restaurantId:
                              //             restaurantData.restaurantId);

                              ref
                                  .read(Utility.orderHour.notifier)
                                  .orderHour(hour: number);
                            },
                            buttonHeight: 20,
                            buttonWidth: 30,
                            BorderRadiuscircular: 5,
                            backgoundColor: chooseNumber.value == number
                                ? Colors.orange
                                : Colors.grey)
                        : Text(''),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: CustomerButton(
                        text: number.toString(),
                        press: () async {
                          chooseNumber.value = number;
                          callback(number);
                          // await ref
                          //     .read(
                          //         AppStateProvider.restaurantStateMap.notifier)
                          //     .searchRestaurantID(
                          //         restaurantId: restaurantData.restaurantId);

                          ref
                              .read(Utility.orderHour.notifier)
                              .orderHour(hour: number);
                        },
                        buttonHeight: 20,
                        buttonWidth: 30,
                        BorderRadiuscircular: 5,
                        backgoundColor: chooseNumber.value == number
                            ? Colors.orange
                            : Colors.grey));
          }),
    );
  }
}
