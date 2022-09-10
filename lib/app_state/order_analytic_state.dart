import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/exception/repository_exception.dart';
import 'package:untitled1/model/order_model.dart';

import 'package:untitled1/model/productdetail_model.dart';
import 'package:untitled1/model/topping_model.dart';
import 'package:untitled1/utils.dart';

import '../app_provider/api_provider.dart';

// List<Category>
class OrderAnalyticState extends StateNotifier<Map<String, OrderModel>> {
  OrderAnalyticState(this.read, [Map<String, OrderModel>? state])
      : super(state ?? const {}) {
    // getAllProduct();
  }
  final Reader read;
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  String bieuDoType = '';
  int inDefferentHour = 0;

  void fromDateFunc({required DateTime fromDateData}) {
    fromDate = fromDateData;
  }

  void toDateFunc({required DateTime toDateData}) {
    toDate = toDateData;
  }

  int inDefferentInHourFunc(
      {required DateTime toDateData, required DateTime fromDateData}) {
    inDefferentHour = toDateData.difference(fromDateData).inHours;
    return inDefferentHour;
  }

  void bieuDoTypeFunc({required int differentDay}) {
    if (differentDay / 24 > 0 && differentDay / 24 < 6) {
      bieuDoType = 'gio';
    }
    if (differentDay / 24 > 6 && differentDay / 24 < 30) {
      bieuDoType = 'day';
    }
    if (differentDay / 24 > 6 && differentDay / 24 < 30) {
      bieuDoType = 'thang';
    }
    if (differentDay / 24 > 30) {
      bieuDoType = 'nam';
    }
  }

  Future<List<OrderModel>> addOrder({
    required List<OrderModel> serverOrders,
  }) async {
    Map<String, OrderModel> dataLocal = state;

    if (dataLocal.length < 1) {
      Map<String, OrderModel> temporary = {};
      serverOrders.forEach((element) {
        temporary['${element.orderId}'] = element;
      });
      state = temporary;
    } else {
      for (final serverOrder in serverOrders) {
        dataLocal.putIfAbsent(serverOrder.orderId, () => serverOrder);
        state = dataLocal;
      }
    }

    return serverOrders;
    // print('state order state');
    // print(state);
  }

  //  create map from from date to date
  List<DateTime> makeListDateFromDateToDate() {
    List<DateTime> listDateFromDateToDate = [];
    for (int index = 0; index < toDate.difference(fromDate).inDays; index++) {
      listDateFromDateToDate
          .add(DateTime(fromDate.year, fromDate.month, fromDate.day + index));
    }
    return listDateFromDateToDate;
  }

  Map<double, DateTime> mapDayandDateFromToDate(
      {required List<DateTime> listDateFromDateToDate}) {
    Map<double, DateTime> DateandDayFromToDate = {};
    listDateFromDateToDate.forEach((Element) {
      DateandDayFromToDate.putIfAbsent((Element).day.toDouble(), () => Element);
    });
    return DateandDayFromToDate;
  }

  Map<double, double> listYCoutingSameDay(
      {required Map<double, DateTime> mapDayandDateFromToDate,
      required Map<double, DateTime> mapDayandDateFromToDate1}) {
    Map<double, double> coutingSameDay = {};
    List<double> keysofDateandDayFromToDate =
        mapDayandDateFromToDate.keys.toList();
    keysofDateandDayFromToDate.forEach((element) {
      coutingSameDay[element] = 0.0;
    });
    return coutingSameDay;
  }

  List<double> listX({required List<DateTime> listDateFromDateToDate}) {
    List<double> listXTest0ToLeng = [];
    for (int index = 0; index < listDateFromDateToDate.length; index++) {
      listXTest0ToLeng.add(index.toDouble());
    }
    return listXTest0ToLeng;
  }
  //--------------------------------------
}
