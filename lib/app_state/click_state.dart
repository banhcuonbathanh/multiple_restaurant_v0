import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_api/api_click.dart';
import 'package:untitled1/model/click_model.dart';

import '../app_provider/api_provider.dart';

// List<Category>
class ClickState extends StateNotifier<Map<String, ClickModel>> {
  ClickState(this.read, [Map<String, ClickModel>? state])
      : super(state ?? const {}) {
    // getAllProduct();
  }
  final Reader read;

  Future<void> createClick({
    required String clickName,
    required String clickingTiming,
    required String monitoringDay,
    required String productId,
    required String productName,
    required String restaurantId,
    required String restaurantName,
  }) async {
    Map<String, ClickModel> dataLocal = state;

    if (dataLocal.length < 1) {
      Map<String, ClickModel> temporary = {};
      temporary[clickName] = ClickModel(
        clickId: '',
        clickingTiming: [clickingTiming],
        monitoringDay: monitoringDay,
        productId: productId,
        productName: productName,
        restaurantId: restaurantId,
        restaurantName: restaurantName,
        clickName: clickName,
      );

      state = temporary;
    } else {
      dataLocal.putIfAbsent(
          clickName,
          () => ClickModel(
                clickId: '',
                clickingTiming: [clickingTiming],
                monitoringDay: monitoringDay,
                productId: productId,
                productName: productName,
                restaurantId: restaurantId,
                restaurantName: restaurantName,
                clickName: clickName,
              ));
      state = dataLocal;
    }

    await read(API.click).createClick(
        clickName: clickName,
        clickingTiming: clickingTiming,
        monitoringDay: monitoringDay,
        productId: productId,
        productName: productName,
        restaurantId: restaurantId,
        restaurantName: restaurantName);
  }

  Future<void> addTimeClick({
    required String clickName,
    required String clickingTiming,
  }) async {
    Map<String, ClickModel> dataLocal = state;
    final response = await read(API.click).addTimeClick(
      clickName: clickName,
      clickingTiming: clickingTiming,
    );
    if (dataLocal.length < 1) {
      Map<String, ClickModel> temporary = {};
      temporary[clickName] = response;

      state = temporary;
    } else {
      dataLocal.putIfAbsent(clickName, () => response);
      state = dataLocal;
    }
  }
}
