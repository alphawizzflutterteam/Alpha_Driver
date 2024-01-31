import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:work/Screens/HomeScreen/home_screen.dart';
import 'package:work/Screens/SinginScreens/Verification/VerifyByNumber/otp_verify_by_number.dart';
import 'package:work/Screens/SinginScreens/Verification/VerifyByNumber/verif_by_number.dart';
import 'package:work/Screens/SinginScreens/controller/signInController.dart';
import 'package:work/utilities/utils.dart';

import '../../../helper/CustomWidgets/custom_text_field.dart';
import '../../../helper/CustomWidgets/default_button.dart';
import '../../../helper/app_constant.dart';
import '../../RegistrationScreens/regristration_screen.dart';
import '../SignInWithEmail/sign_iin_with_email.dart';

class SignInWithPhone extends StatefulWidget {
  const SignInWithPhone({super.key});

  @override
  State<SignInWithPhone> createState() => _SignInWithPhoneState();
}

class _SignInWithPhoneState extends State<SignInWithPhone> {
  final LoginController loginContr = Get.put(LoginController());

  @override
  void dispose() {
    super.dispose();
    loginContr.mobileController.dispose();
  }

  int index = 1;
  @override
  Widget build(BuildContext context) {
    var th = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight * .35,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage("assets/images/onboarding_bg-light.png"))),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: ListView(
              children: [
                SizedBox(
                  height: screenHeight * 0.15,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "assets/images/Group 76.png",
                      height: 60,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Text('Sign in to your account',
                    style: th.bodyMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: appColorBlack,
                    )),
                const SizedBox(
                  height: 10,
                ),
                // Text('Lorem Ipsum has been the industry s standard dummy text ever since the 1500s,',style: th.bodyMedium?.
                // copyWith(
                //   fontWeight: FontWeight.w500,color: appColorBlack,
                // )),
                const SizedBox(
                  height: 20,
                ),
                ButtonsWidgets(
                  index: index,
                  buttonFirstText: 'Login via Phone',
                  buttonSecondText: 'Login via Email',
                  onPressed1: () {
                    setState(() {
                      index = 1;
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                  onPressed2: () {
                    setState(() {
                      index = 2;
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                if (index == 1) signInWithNumber(screenHeight, th),
                if (index == 2)
                  signIinWithEmail(
                      loginContr.emailController,
                      loginContr.passwordController,
                      screenHeight,
                      th,
                      index,
                      context,
                      loginContr),
              ],
            ),
          ),
        ],
      ),
    );
  }

  signInWithNumber(screenHeight, th) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          child: Center(
            child: CustomTextField(
              controller: loginContr.mobileController,
              labelText: 'Mobile',
              hintText: '9999999999',
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp(r'\d+'))
              ],
              prefixIcon: Icons.phone,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              textInputAction: TextInputAction.send,
              onTap: () {},
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            print(loginContr.mobileController.text);

            if (loginContr.mobileController.text.length < 10) {
              Utils.showFlushBarWithMessage(
                "Invalid Mobile number",
                Get.context!,
              );
            } else {
              loginContr.sendOTP(true);
            }
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
        InkWell(
          onTap: () {
            Get.to(const SignupScreen());
          },
          child: Container(
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
                Column(
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
              ],
            ),
          ),
        )
      ],
    );
  }
}
