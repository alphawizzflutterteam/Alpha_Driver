import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:work/Screens/SinginScreens/Verification/VerifyByEmail/verify_by_email.dart';
import 'package:work/Screens/SinginScreens/Verification/VerifyByNumber/verif_by_number.dart';
import 'package:work/Screens/SinginScreens/controller/signInController.dart';

import '../../../helper/CustomWidgets/custom_text_field.dart';
import '../../../helper/app_constant.dart';
import '../../HomeScreen/home_screen.dart';
import '../../RegistrationScreens/get_steps.dart';
import '../../RegistrationScreens/regristration_screen.dart';

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password.';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters.';
  }
  if (!value.contains(RegExp(r'[a-z]'))) {
    return 'Password must contain at least one lowercase letter.';
  }
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one uppercase letter.';
  }
  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one number.';
  }
  if (!value.contains(RegExp(r'[!@#\$%^&*()_+{}|:<>?~]'))) {
    return 'Password must contain at least one special character.';
  }
  return null;
}

signIinWithEmail(emailController, passwordController, screenHeight, th, index,
    context, LoginController controller) {
  return Column(
    children: [
      SizedBox(
        height: 70,
        child: Center(
          child: CustomTextField(
            controller: emailController,
            labelText: 'Email',
            hintText: 'example@gmail.com',
            // prefixIcon: Icons.person,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            onTap: () {},
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]')),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 70,
        child: Center(
          child: CustomTextField(
            controller: passwordController,
            labelText: 'Password',
            hintText: '*********',
            // prefixIcon: Icons.person,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            textInputAction: TextInputAction.done,
            onTap: () {}, inputFormatters: [],
          ),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      GestureDetector(
        onTap: () {
          if (validatePassword(passwordController.text) != null) {
            showPasswordRequirementsDialog(context);
          } else {
            controller.loginMail(emailController.text);
          }
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => FormPage()));
        },
        child: Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: appPrimaryColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login',
                  style: th.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: appColorWhite,
                  )),
              const SizedBox(
                width: 5,
              ),
              Icon(
                CupertinoIcons.arrow_right,
                color: appColorWhite,
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        width: double.infinity,
        alignment: Alignment.centerRight,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VerifyByNumber()));
              },
              child: Text('Forgot Password ?',
                  style: th.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: appColorBlack,
                  )),
            ),
          ],
        ),
      ),
      SizedBox(
        height: index == 1 ? screenHeight * 0.21 : screenHeight * 0.13,
      ),
      Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Don\'t have an account?',
                style: th.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: appColorBlack,
                )),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () {
                Get.to(const SignupScreen());
              },
              child: Column(
                children: [
                  Text('Sign Up',
                      style: th.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: appPrimaryColor,
                      )),
                  Container(
                    width: 50,
                    height: 1,
                    color: appPrimaryColor,
                  )
                ],
              ),
            ),
          ],
        ),
      )
    ],
  );
}

void showPasswordRequirementsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Password Requirements',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              '• Password must be at least 8 characters.\n',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
            ),
            Text(
              '• Password must contain at least one lowercase letter & one uppercase letter.\n',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
            ),
            Text(
              '• Password must contain at least one number.\n',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
            ),
            Text(
              '• Password must contain at least one special character.\n',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(
              'OK',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
            ),
          ),
        ],
      );
    },
  );
}
