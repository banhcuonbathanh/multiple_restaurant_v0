import 'package:flutter/material.dart';
import 'package:untitled1/constants.dart';
import 'package:untitled1/screens/forgot_password/forgot_password_screen.dart';
import 'package:untitled1/screens/sign_up/sign_up_screen.dart';

import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, SignUpScreen.routeName);
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
      },
      child: Text(
        "Forgot Password",
        style: TextStyle(
            fontSize: getProportionateScreenWidth(16), color: kPrimaryColor),
      ),
    );
  }
}
