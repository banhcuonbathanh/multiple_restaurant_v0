import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/app_provider/state_provider.dart';
import 'package:untitled1/app_provider/utility_provider.dart';
import 'package:untitled1/components/custom_surfix_icon.dart';
import 'package:untitled1/components/default_button.dart';
import 'package:untitled1/components/form_error.dart';
import 'package:untitled1/constants.dart';
import 'package:untitled1/screens/home/home_screen.dart';
import 'package:untitled1/size_config.dart';

class SignUpForm extends HookConsumerWidget {
  // void addError({String? error}) {
  //   if (!errors.contains(error))
  //     setState(() {
  //       errors.add(error);
  //     });
  // }

  // void removeError({String? error}) {
  //   if (errors.contains(error))
  //     setState(() {
  //       errors.remove(error);
  //     });
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final userEmail = useTextEditingController();

    final userPassword = useTextEditingController();
    final passwordReconfirmController = useTextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildTextFormFieldEmail(ref: ref, userEmail: userEmail),
          // buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPassFormField(ref: ref, userPassword: userPassword),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(
              passwordController: userPassword,
              ref: ref,
              passwordReconfirmController: passwordReconfirmController),

          // FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                ref.read(Utility.isLoading.notifier).isLoading(isLoading: true);
                final user = await ref
                    .read(AppStateProvider.userNotifier.notifier)
                    .createUser(
                      userEmail: userEmail.text,
                      userPassword: userPassword.text,
                    );
                ref
                    .read(Utility.isLoading.notifier)
                    .isLoading(isLoading: false);
                // if all are valid then go to success screen
                Navigator.pushNamed(context, HomeScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildTextFormFieldEmail(
      {required TextEditingController userEmail, required WidgetRef ref}) {
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

  Widget buildConformPassFormField(
      {required TextEditingController passwordReconfirmController,
      required TextEditingController passwordController,
      required WidgetRef ref}) {
    return TextFormField(
      controller: passwordReconfirmController,
      // obscureText: true,
      onSaved: (newValue) => passwordReconfirmController.text = newValue!,
      onChanged: (value) {
        ref.read(Utility.error.notifier).removeAllErrors();
      },
      validator: (value) {
        if (value!.isEmpty) {
          ref.read(Utility.error.notifier).addError(error: 'password is empty');
          return "";
        }
        if (passwordController.text != value) {
          ref
              .read(Utility.error.notifier)
              .addError(error: 'password is not match');
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}


//  decoration: InputDecoration(
//         enabledBorder: outlineInputBorder(),
//         focusedBorder: outlineInputBorder(),
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
//         labelText: "Mật Khẩu",
//         hintText: "Nhập Mật Khẩu",
//         // If  you are using latest version of flutter then lable text and hint text shown like this
//         // if you r using flutter less then 1.20.* then maybe this is not working properly
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
//       ),