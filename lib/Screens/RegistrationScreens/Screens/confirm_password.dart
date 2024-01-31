import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work/utilities/utils.dart';
import '../../../Provider/signupController.dart';
import '../../../helper/CustomWidgets/custom_button.dart';
import '../../../helper/CustomWidgets/custom_text_field.dart';
import '../../../helper/app_constant.dart';

class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({super.key});

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  final SignupController signUpContr = Get.put(SignupController());

  bool _isVisible = false;
  bool _isVisible1 = false;
  IconData _icon = Icons.visibility_off;
  IconData _icon1 = Icons.visibility_off;
  bool _checkValue = false;
  @override
  void dispose() {
    super.dispose();
  }

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

  void _increment() {
    signUpContr.increaseCurrentState();
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () {
        signUpContr.decreaseCurrentState();
        return Future.value(false);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: ListView(
          children: [
            Container(
              child: Text(
                'Enter new password ',
                style: th.bodyLarge?.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: appColorBlack),
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Secure your account with a new password – driving seamless and secure e-commerce experiences with just a click.',
              style: th.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w700, color: Colors.grey),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            CustomTextField(
              obscureText: !_isVisible,
              suffixIcon: _icon,

              controller: signUpContr.passwordController,
              // prefixIcon: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              hintText: '',
              onIconTap: () {
                setState(() {
                  _isVisible = !_isVisible;
                  _icon = _isVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined;
                });
              },
              labelText: 'Create New password', inputFormatters: [],
            ),
            SizedBox(height: 20),
            CustomTextField(
              obscureText: !_isVisible1,
              suffixIcon: _icon1,
              controller: signUpContr.confirmPasswordController,
              // prefixIcon: d.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              labelText: 'Confirm Password',
              onIconTap: () {
                setState(() {
                  _isVisible1 = !_isVisible1;
                  _icon1 = _isVisible1
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined;
                });
              },
              hintText: '', inputFormatters: [],
            ),
            SizedBox(height: 30),
            CustomButtonWidget(
                text: 'CREATE PASSWORD',
                onPressed: () {
                  if (validatePassword(signUpContr.passwordController.text) ==
                      null) {
                    if (signUpContr.passwordController.text ==
                        signUpContr.confirmPasswordController.text) {
                      signUpContr.verifyPassword();
                    } else {
                      Utils.showFlushBarWithMessage(
                          "New and confirm password should be same.", context);
                    }
                  } else {
                    Utils.showFlushBarWithMessage(
                        validatePassword(signUpContr.passwordController.text)!,
                        context);
                  }
                }),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
