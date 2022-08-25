import 'package:hooks_riverpod/hooks_riverpod.dart';

class WidgetOffSet extends StateNotifier<Map<String, double>> {
  WidgetOffSet(Map<String, double> state) : super(state);

  void addwidgetoffset(String ten, double vitri) {
    state.putIfAbsent(ten, () => vitri);
  }

  Map<String, double> get lacaotion {
    return state;
  }

  Map<String, double> getwidgetLocation() {
    return lacaotion;
  }
}

class RestuarantIsShow extends StateNotifier<String> {
  RestuarantIsShow(String state, this.read) : super(state);
  final Reader read;

  void isOnScreen({required String restaurantName}) {
    state = restaurantName;
  }
}

class CategoriesTitle extends StateNotifier<String> {
  CategoriesTitle(
    String state,
  ) : super(state);

  void categoriesTitleOnScreen({required String categoriesTitle}) {
    state = categoriesTitle;
  }
}

class IsLoading extends StateNotifier<bool> {
  IsLoading(this.read) : super(false);
  final Reader read;

  void isLoading({required bool isLoading}) {
    state = isLoading;
    // print('restaurantName trong restuarantIsShowNotifier');
    // print(restaurantName);
  }

  // Map<String, double> getlatin() {
  //   final location = read(Utility.widgetOffSet.notifier).getwidgetLocation();
  //   return location;
  // }
}

class IsAuthentiate extends StateNotifier<bool> {
  IsAuthentiate(this.read) : super(false);
  final Reader read;

  void isAuthentiate({required bool isAuth}) {
    state = isAuth;
    // print('restaurantName trong restuarantIsShowNotifier');
    // print(restaurantName);
  }

  // Map<String, double> getlatin() {
  //   final location = read(Utility.widgetOffSet.notifier).getwidgetLocation();
  //   return location;
  // }
}

class Error extends StateNotifier<List<String?>?> {
  final String? message;
  Error(this.message, [List<String?>? state = null])
      : super(state == null ? null : [...state, message]);
  void addError({required String error}) {
    state = [...?state, error].toSet().toList();
  }

  void removeAllErrors() {
    List<String> tset = [];

    state = tset;
  }
}

class Error12 extends StateNotifier<String?> {
  final String? message;

  Error12(this.message) : super(null);
  void addError({required String error}) {
    state = error;
  }

  void removeAllErrors() {
    state = null;
  }
}

// ------------------------------------------------
class SearchValueKey extends StateNotifier<String> {
  SearchValueKey(String state, this.read) : super(state);
  final Reader read;

  void searchValue({required String searchValue}) {
    state = searchValue;
  }
}

// ------------------------------------------------
class ShowAnimationForBuying1 extends StateNotifier<int> {
  ShowAnimationForBuying1() : super(0);

  void addOne() {
    state = state + 1;
  }

  void minusOne() {
    state = state - 1;
  }

  void reset() {
    state = 0;
  }
}

class Disposeofhome extends StateNotifier<bool> {
  Disposeofhome() : super(false);

  void diposetrue() {
    print('diposetrue Disposeofhome utility');
    state = true;
  }

  void diposefalse() {
    state = false;
  }
}

class orderTimingDay extends StateNotifier<int?> {
  orderTimingDay() : super(null);

  void orderday({required int day}) {
    state = day;
  }
}

class orderTimingHour extends StateNotifier<int?> {
  orderTimingHour() : super(null);

  void orderHour({required int hour}) {
    state = hour;
  }
}

class orderTimingMinute extends StateNotifier<int?> {
  orderTimingMinute() : super(null);

  void orderMinute({required int minute}) {
    state = minute;
  }
}
