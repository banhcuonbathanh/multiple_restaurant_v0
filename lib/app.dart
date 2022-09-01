import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';

import 'routes.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'theme.dart';

class MyApp extends HookConsumerWidget {
  static const String title = 'check inter connectitit';
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isLoading = ref.watch(Utility.isLoading);
    // if (isLoading) {
    //   print('build isLoading ${isLoading}');
    //   return Container(
    //     color: Colors.white,
    //   );
    // }
    // OverlaySupport.global(
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: SignInScreen.routeName,
      routes: routes,
    );
  }
}
