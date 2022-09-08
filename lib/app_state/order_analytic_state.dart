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
}
