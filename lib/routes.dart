import 'package:flutter/widgets.dart';
import 'package:untitled1/screens/sign_in_1/sign_in_screen.dart';

import 'screens/cart/cart_screen.dart';

import 'screens/edit_screen/edit_product_body.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';

import 'screens/manage_restaurant/da_xac_nhan/1da_xac_nhan_body.dart';

import 'screens/manage_restaurant/doanh_thu/doanh_thu.dart';

import 'screens/manage_restaurant/don_hang/don_hang_body.dart';

import 'screens/manage_restaurant/manage_restaurant_body.dart';

import 'screens/manage_restaurant/phan_tich_ban_hang/phan_tich_ban_hang.dart';
import 'screens/profile/profile_screen.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  DonHangBody.routeName: (context) => DonHangBody(),

  // DatHangBodyamnagerRestaurant.routeName: (context) =>
  //     DatHangBodyamnagerRestaurant(),
  ManageRestaurantBody.routeName: (context) => ManageRestaurantBody(),
  DaXacNhanBodyamnagerRestaurant.routeName: (context) =>
      DaXacNhanBodyamnagerRestaurant(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  // LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  // CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  // OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  // DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  EditProduct.routeName: (context) => EditProduct(),
  DoanhThu.routeName: (context) => DoanhThu(),
  PhanTichBanHang.routeName: (context) => PhanTichBanHang(),
  // OrderingInformationScreen1.routeName: (context) => OrderingInformationScreen1(),
};
