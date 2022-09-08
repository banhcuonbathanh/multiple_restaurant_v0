import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:untitled1/app_state/utility_state.dart';

abstract class Utility {
  static StateNotifierProvider<WidgetOffSet, Map<String, double>>
      get widgetOffSet => _widgetOffSet;
  static StateNotifierProvider<RestuarantIsShow, String> get restaurantIsShow =>
      _restaurantIsShow;
  static StateNotifierProvider<IsLoading, bool> get isLoading => _isLoading;
  static StateNotifierProvider<Error, List<String?>?> get error => _error;
  static StateNotifierProvider<Error12, String?> get error1 => error1;
  static StateNotifierProvider<CategoriesTitle, String?> get categoriesTitle =>
      _categoriesTitle;
  static StateNotifierProvider<SearchValueKey, String> get searchValue =>
      _searchValue;
  static StateNotifierProvider<ShowAnimationForBuying1, int>
      get showAnimationForBuying1 => showAnimationForBuying;
  static StateNotifierProvider<Disposeofhome, bool> get disposeofhomeGetter =>
      disposeofhome;
  static StateNotifierProvider<orderTimingDay, DateTime?> get orderDay =>
      _orderDay;
  static StateNotifierProvider<orderTimingHour, int?> get orderHour =>
      _orderHour;
  static StateNotifierProvider<orderTimingMinute, int?> get orderMinute =>
      _orderMinute;
}

final _widgetOffSet =
    StateNotifierProvider<WidgetOffSet, Map<String, double>>((ref) {
  return WidgetOffSet({});
});

final _restaurantIsShow =
    StateNotifierProvider<RestuarantIsShow, String>((ref) {
  return RestuarantIsShow('1', ref.read);
});

final _isLoading = StateNotifierProvider<IsLoading, bool>((ref) {
  return IsLoading(ref.read);
});

final _error = StateNotifierProvider<Error, List<String?>?>((ref) {
  return Error(null);
});

final error1 = StateNotifierProvider<Error12, String?>((ref) {
  return Error12(null);
});

final _categoriesTitle = StateNotifierProvider<CategoriesTitle, String>((ref) {
  return CategoriesTitle('Đồ Ăn');
});

final _searchValue = StateNotifierProvider<SearchValueKey, String>((ref) {
  return SearchValueKey('', ref.read);
});

final showAnimationForBuying =
    StateNotifierProvider<ShowAnimationForBuying1, int>((ref) {
  return ShowAnimationForBuying1();
});
final disposeofhome = StateNotifierProvider<Disposeofhome, bool>((ref) {
  return Disposeofhome();
});
final _orderDay = StateNotifierProvider<orderTimingDay, DateTime?>((ref) {
  return orderTimingDay();
});
final _orderHour = StateNotifierProvider<orderTimingHour, int?>((ref) {
  return orderTimingHour();
});
final _orderMinute = StateNotifierProvider<orderTimingMinute, int?>((ref) {
  return orderTimingMinute();
});
