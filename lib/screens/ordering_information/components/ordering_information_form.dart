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

class OrderingInformationForm extends HookConsumerWidget {
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
    final userNameController = useTextEditingController();

    final userPhoneController = useTextEditingController();
    final userAddrressController = useTextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildTextFormFieldName(
              ref: ref, userNameController: userNameController),
          // buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPassFormFieldPhone(
              ref: ref, userPhoneController: userPhoneController),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(
            userAddrressController: userAddrressController,
            ref: ref,
          ),

          // FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                await ref
                    .read(AppStateProvider.userNotifier.notifier)
                    .addOrderingInformation(
                      userAdrress: userAddrressController.text,
                      userName: userNameController.text,
                      userPhone: userPhoneController.text,
                    );

                // if all are valid then go to success screen
                Navigator.pushNamed(context, HomeScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildTextFormFieldName(
      {required TextEditingController userNameController,
      required WidgetRef ref}) {
    return TextFormField(
      controller: userNameController,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        // ref.read(error_State_Provider.notifier).removeAllErrors();
      },
      onSaved: (value) {
        userNameController.text = value!;
      },
      decoration: InputDecoration(
        suffixIcon: const CustomSurffixIcon(
          svgIcon: 'assets/icons/Mail.svg',
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        hintText: 'Nhập Tên',
        label: const Text('Tên'),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          ref.read(Utility.error.notifier).addError(error: 'Điền Tên');
          return "";
        }

        return null;
      },
    );
  }

  Widget buildPassFormFieldPhone(
      {required TextEditingController userPhoneController,
      required WidgetRef ref}) {
    return TextFormField(
      controller: userPhoneController,
      keyboardType: TextInputType.text,
      // obscureText: true,
      onSaved: (newValue) => userPhoneController.text = newValue!,
      onChanged: (value) {
        ref.read(Utility.error.notifier).removeAllErrors();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          ref
              .read(Utility.error.notifier)
              .addError(error: 'Chưa Điền Số ĐIện Thoại');
          return "";
        }

        return null;
      },
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        labelText: "Số Điện Thoại",
        hintText: "Nhập Số Điện Thoại",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  Widget buildConformPassFormField(
      {required TextEditingController userAddrressController,
      required WidgetRef ref}) {
    return TextFormField(
      controller: userAddrressController,
      // obscureText: true,
      onSaved: (newValue) => userAddrressController.text = newValue!,
      onChanged: (value) {
        ref.read(Utility.error.notifier).removeAllErrors();
      },
      validator: (value) {
        if (value!.isEmpty) {
          ref
              .read(Utility.error.notifier)
              .addError(error: 'Chưa Điền Thông Tin Địa Chỉ');
          return "";
        }

        return null;
      },
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        labelText: " Địa Chỉ",
        hintText: "Điền Thông Tin",
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