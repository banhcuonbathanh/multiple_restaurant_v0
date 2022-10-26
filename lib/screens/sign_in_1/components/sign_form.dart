import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:untitled1/app_provider/api_provider.dart';

import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/app_provider/utility_provider.dart';

import 'package:untitled1/components/custom_surfix_icon.dart';
import 'package:untitled1/components/default_button.dart';
import 'package:untitled1/components/form_error.dart';
import 'package:untitled1/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:untitled1/helper/custom_page_route.dart';
import 'package:untitled1/screens/home/home_screen.dart';

import '../../../size_config.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:socket_io_client/socket_io_client.dart' as Io;

class SignForm extends HookConsumerWidget {
  SignForm({Key? key}) : super(key: key);

  void addError({String? error}) {
    // if (!errors.contains(error))
    // setState(() {
    //   errors.add(error);
    // });
  }

  void removeError({String? error}) {
    // if (errors.contains(error))
    //   setState(() {
    //     errors.remove(error);
    //   });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ---------------------------------
// socket Io
    late Io.Socket socket;
    void connectAndListen() {
      socket = Io.io('http://127.0.0.1:62173',
          Io.OptionBuilder().setTransports(['websocket']).build());
      print('docket io');
      socket.onConnect((_) {
        print(';socket on coneection');
      });
      socket.emit('add_user', 'sing in screen');
      // -----------
      socket.on('receiveOrder', (data) async {
        // await service.showNotification(
        //     id: 0,
        //     title: ' notiication titleasfdasdf',
        //     body: ' some nidy111111111111111');
      });
      // --------------
      socket.onDisconnect((_) => print('disconnect'));
    }

    useEffect(() {
      // connectAndListen();
      return () {};
    });
    // --------------------------------------
    // ------------------------------
    final hasInternet = useState<bool>(false);
    ConnectivityResult resultConnectivity = ConnectivityResult.none;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final userEmail = useTextEditingController();
    final userPassword = useTextEditingController();
    final errorList = ref.watch(Utility.error);
    final user = ref.watch(AppStateProvider.userNotifier);
    // ref.listen<String?>(error1, (previous, next) {});
    useEffect(() {
      InternetConnectionChecker().onStatusChange.listen((status) {
        final hasInternet1 = status == InternetConnectionStatus.connected;
        hasInternet.value = hasInternet1;
      });
      return () {};
    });
//     late IO.Socket socket;
// // ---------------------

//     void connectAndListen({required String userId}) {
//       socket = IO.io(
//         'http://127.0.0.1:3000',
//         OptionBuilder().setTransports(['websocket']).build(),
//       );
//       socket.onConnect((_) {
//         socket.emit('sign_in', userId);
//       });
//       socket.onDisconnect((_) => print('disconnect'));
//     }
// // ------------------------

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildTextFormFieldEmail(userEmail: userEmail, ref: ref),
          // buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPassFormField(ref: ref, userPassword: userPassword),
          // buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          (errorList != null && errorList.length > 0)
              ? FormError(errors: errorList)
              : SizedBox(
                  height: getProportionateScreenHeight(30),
                ),

          SizedBox(height: getProportionateScreenHeight(5)),
          DefaultButton(
            text: "Continue",
            press: () async {
              // final user = await ref
              //     .read(AppStateProvider.userNotifier.notifier)
              //     .singIn_Controller(
              //         userEmail: userEmail.text,
              //         userPassword: userPassword.text);

              // Navigator.pushNamed(context, HomeScreen.routeName);
              // ------------------------
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                // ref.read(Utility.isLoading.notifier).isLoading(isLoading: true);
                final user = await ref
                    .read(AppStateProvider.userNotifier.notifier)
                    .singIn_Controller(
                        userEmail: userEmail.text,
                        userPassword: userPassword.text);
                if (user!.userEmail != '') {
                  print('userasdfasdfsdf');
                  print(user);
                  print(user.userName != '');
                  Navigator.of(context)
                      .push(CustomPageRoute(child: HomeScreen()));
                } else {
                  return;
                }
                // ref
                //     .read(Utility.isLoading.notifier)
                //     .isLoading(isLoading: false);

                // Navigator.pushNamed(context, HomeScreen.routeName);

                // Navigator.of(context).push(PageRouteBuilder(
                //     pageBuilder: (context, animation, secondaryAnimation) {
                //       return HomeScreen();
                //     },
                //     opaque: false));
                ref.read(Utility.error.notifier).removeAllErrors();
              } else {
                print(_formKey.currentState!.validate());
              }
              // ------------------------
              // if (!_formKey.currentState!.validate()) {
              //   print('not valie');
              // }
            },
          ),
          ElevatedButton(
              onPressed: () async {
                final Dio dio = Dio();
                try {
                  // connectAndListen();
                  // print('/test1');
                  // http://127.0.0.1:50532
                  // await dio.post('http://127.0.0.1:8080/test', data: {});
                  // var test = await dio.post(
                  //   'http://127.0.0.1:8080/test',
                  // );
                  var test = await dio.post(
                    'http://127.0.0.1:8080/api/user/createUser',
                    data: {'userEmail': " useremail from local"},
                  );

                  // var test = await dio.post(
                  //   'http://14.225.27.169:8080/api/user/createUser',
                  // );
                  // var test = await dio.post(
                  //   'http://127.0.0.1:49951/api/user/createUser',
                  //   data: {'userEmail': " useremail from local"},
                  // );
                  // await dio.get('http://127.0.0.1:5000/');
                  // print('/test2');

                  // await ref.read(API.user).createUser(
                  //     userEmail: 'userEmail', userPassword: 'userPassword');
                  // print('/test2');
                } on DioError catch (e) {
                  throw Exception(' failed to create post');
                }
              },
              child: Text(' test docker')),
          ElevatedButton(
              onPressed: () async {
                hasInternet.value =
                    await InternetConnectionChecker().hasConnection;
                resultConnectivity = await Connectivity().checkConnectivity();

                if (resultConnectivity == ConnectivityResult.mobile) {
                  showSimpleNotification(Text(' mobile network'));
                } else if (resultConnectivity == ConnectivityResult.wifi) {
                  showSimpleNotification(Text(' wifi network'));
                } else {
                  showSimpleNotification(Text(' no network'));
                }
                // final message = hasInternet.value
                //     ? 'intenet available'
                //     : 'internet is not available';
                // showSimpleNotification(Text(message));
              },
              child: Text(' check internet'))
        ],
      ),
    );
  }

  Widget buildPassFormField(
      {required TextEditingController userPassword, required WidgetRef ref}) {
    return TextFormField(
      controller: userPassword,
      keyboardType: TextInputType.text,
      // obscureText: true,
      onSaved: (newValue) => userPassword.text = newValue!,
      onChanged: (value) {
        ref.read(Utility.error.notifier).removeAllErrors();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          ref
              .read(Utility.error.notifier)
              .addError(error: 'Chưa Điền Mật Khẩu');
          return "can nasldkf";
        }
        if (value.length < 6) {
          ref
              .read(Utility.error.notifier)
              .addError(error: 'Mật Khẩu Dài Hơn 6 Kí Tự');
          return "can nasldkf";
        }

        if (!value.contains(RegExp(r"[a-z]"))) {
          ref
              .read(Utility.error.notifier)
              .addError(error: 'Mật Khẩu Cần Chữ Cái Thường');
          return "can nasldkf";
        }

        if (!value.contains(RegExp(r"[A-Z]"))) {
          ref
              .read(Utility.error.notifier)
              .addError(error: 'Mật Khẩu Cần Chữ Cái Hoa');
          return "can nasldkf";
        }

        if (!value.contains(RegExp(r"[0-9]"))) {
          ref.read(Utility.error.notifier).addError(error: 'Mật Khẩu Cần Số');
          return "can nasldkf";
        }

        if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
          ref
              .read(Utility.error.notifier)
              .addError(error: 'Mật Khẩu Cần Kí Tự Đặc BIệt');
          return "can nasldkf";
        }

        return null;
      },
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        labelText: "Mật Khẩu",
        hintText: "Nhập Mật Khẩu",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  Widget buildTextFormFieldEmail(
      {required TextEditingController userEmail, required WidgetRef ref}) {
    return TextFormField(
      controller: userEmail,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        ref.read(Utility.error.notifier).removeAllErrors();
      },
      onSaved: (value) {
        userEmail.text = value!;
      },
      decoration: InputDecoration(
        suffixIcon: const CustomSurffixIcon(
          svgIcon: 'assets/icons/Mail.svg',
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        hintText: 'Nhập Địa Chỉ Email',
        label: const Text('Địa Chỉ Email'),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          ref
              .read(Utility.error.notifier)
              .addError(error: 'Nhập Địa Chỉ Email');
          return "can nasldkf";
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          ref
              .read(Utility.error.notifier)
              .addError(error: 'Email Chưa Chính Xác');
          return "can nasldkf";
        }
        return null;
      },
    );
  }
}
