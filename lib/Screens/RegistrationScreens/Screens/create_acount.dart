import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:work/Screens/staticPages/ui/WebViewScreen.dart';
import 'package:work/utilities/app_color.dart';
import 'package:work/utilities/utils.dart';

import '../../../Provider/signupController.dart';
import '../../../helper/CustomWidgets/custom_button.dart';
import '../../../helper/CustomWidgets/custom_text_field.dart';
import '../../../helper/app_constant.dart';
import '../../../utilities/sizedBox.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final SignupController signUpContr = Get.put(SignupController());

  bool _checkValue = false;
  @override
  void dispose() {
    super.dispose();
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
        return Future.value(true);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: ListView(
          children: [
            // boxA1(),
            boxA1(),
            Container(
              child: Text(
                'Create your Account',
                style: th.bodyLarge?.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: appColorBlack),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Empower your journey with seamless E-commerce deliveries – Sign up now and drive success with our dedicated Driver app',
              style: th.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w700, color: Colors.grey),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),

            CustomTextField(
              controller: signUpContr.numberController,
              labelText: 'Mobile Number',
              hintText: '+91 966666666',
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp(r'\d+'))
              ],
              prefixIcon: Icons.phone,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              textInputAction: TextInputAction.send,
            ),
            const SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: Checkbox(
                    activeColor: AppColors.theme,
                    value: _checkValue,
                    onChanged: (bool? value) {
                      setState(() {
                        _checkValue = !_checkValue;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'By clicking, you agree to our \n',
                        style: th.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700, color: Colors.grey),
                      ),
                      TextSpan(
                        text: 'Terms of Service',
                        style: th.bodySmall?.copyWith(
                            decorationColor: appPrimaryColor,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            color: appPrimaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Handle tap on 'Terms of Service'
                            print('Tapped on Terms of Service');
                            Get.to(const StaticScreens(
                              title: 'Terms of Service',
                            ));
                          },
                      ),
                      TextSpan(
                        text: ' and ',
                        style: th.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700, color: Colors.grey),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: th.bodySmall?.copyWith(
                            decorationColor: appPrimaryColor,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            color: appPrimaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Tapped on Privacy Policy');
                            Get.to(const StaticScreens(
                              title: 'Privacy Policy',
                            ));
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButtonWidget(
                text: 'VERIFY',
                onPressed: () {
                  if (_checkValue) {
                    signUpContr.sendRegisterOTP();
                  } else {
                    Utils.showFlushBarWithMessage(
                      'Please accpet terms of service & Privacy Policy.',
                      Get.context!,
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
