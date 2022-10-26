import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

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
  const SignForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final userEmail = useTextEditingController();

    final userPassword = useTextEditingController();

    final errorList = ref.watch(Utility.error);
// CHECK INTERNET
    final hasInternet = useState<bool>(false);
    ConnectivityResult resultConnectivity = ConnectivityResult.none;
    // useEffect(() {
    //   InternetConnectionChecker().onStatusChange.listen((status) {
    //     final hasInternet1 = status == InternetConnectionStatus.connected;
    //     hasInternet.value = hasInternet1;
    //   });
    //   return () {};
    // });

    // ----------------
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EmailForm(
            ref: ref,
            userEmail: userEmail,
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          PasswordForm(
            ref: ref,
            userPassword: userPassword,
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          (errorList != null && errorList.length > 0)
              ? FormError(errors: errorList)
              : SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
          ContinueButton(
            formKey: _formKey,
            userEmail: userEmail,
            userPassword: userPassword,
            ref: ref,
          ),
        ],
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.userEmail,
    required this.userPassword,
    required this.ref,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController userEmail;
  final TextEditingController userPassword;
  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      text: "Continue",
      press: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          final user = await ref
              .read(AppStateProvider.userNotifier.notifier)
              .singIn_Controller(
                  userEmail: userEmail.text, userPassword: userPassword.text);
          if (user!.userEmail != '') {
            Navigator.of(context).push(CustomPageRoute(child: HomeScreen()));
          } else {
            return;
          }

          ref.read(Utility.error.notifier).removeAllErrors();
        } else {
          print(_formKey.currentState!.validate());
        }
      },
    );
  }
}

class PasswordForm extends StatelessWidget {
  final TextEditingController userPassword;
  final WidgetRef ref;
  const PasswordForm({
    Key? key,
    required this.userPassword,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class EmailForm extends StatelessWidget {
  final TextEditingController userEmail;
  final WidgetRef ref;
  const EmailForm({
    Key? key,
    required this.userEmail,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: userEmail,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        // ref.read(error_State_Provider.notifier).removeAllErrors();
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
