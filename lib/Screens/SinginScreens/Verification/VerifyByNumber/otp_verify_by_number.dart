import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:work/Screens/SinginScreens/controller/signInController.dart';
import 'package:work/helper/CustomWidgets/custom_button.dart';
import 'package:work/helper/CustomWidgets/custom_text_field.dart';
import 'package:work/utilities/color.dart';
import 'package:work/utilities/shared_pref..dart';

import '../../../../helper/CustomWidgets/otp_widget.dart';
import '../../../../helper/app_constant.dart';

class OtpVerifyByNumber extends StatefulWidget {
  final bool isComingForLogin;
  const OtpVerifyByNumber({super.key, required this.isComingForLogin});

  @override
  State<OtpVerifyByNumber> createState() => _OtpVerifyByNumberState();
}

class _OtpVerifyByNumberState extends State<OtpVerifyByNumber> {
  final LoginController loginContr = Get.put(LoginController());
  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mobile = SharedPref.shared.pref?.getString(PrefKeys.mobile);
    var otp = SharedPref.shared.pref!.getString(PrefKeys.otp);
    for (int i = 0; i < otp!.length; i++) {
      otpControllers[i].text = otp[i];
    }
    final th = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Verify Number',
            style: th.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600, color: appColorBlack),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: screenHeight * .35,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage("assets/images/onboarding_bg-light.png"))),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        "assets/images/Group 76.png",
                        height: 60,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(
                      'Enter your verification \ncode',
                      style: th.bodyLarge?.copyWith(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: appColorBlack),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'We the OTP sent to +91 $mobile',
                    style: th.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500, color: appColorBlack),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return Container(
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: const Color.fromARGB(255, 142, 142, 142),
                          ),
                          child: TextField(
                            controller: otpControllers[index],
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              // border: OutlineInputBorder(
                              //   borderSide: BorderSide(color: colors.greyText),
                              // ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colors.greyText),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colors.greyText),
                              ),
                              counterStyle: TextStyle(color: colors.greyText),
                            ),
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ], // Limit to one character
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 35),
                  CustomButtonWidget(
                      text: 'VERIFY',
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        var enterdOTp = loginContr
                            .retrieveStringFromControllers(otpControllers);
                        loginContr.verifyOtp(
                            enterdOTp, widget.isComingForLogin);
                      }),
                  SizedBox(height: 20),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Didn\'t recieved Otp? ',
                          style: th.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: appColorBlack),
                        ),
                        TextSpan(
                          text: 'Resend OTP ',
                          style: th.bodySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: appPrimaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              print('Tapped on "!"');
                              await loginContr.sendOTP(widget.isComingForLogin);
                              setState(() {});
                            },
                        ),
                      ])),
                ],
              )),
        ],
      ),
    );
  }
}
