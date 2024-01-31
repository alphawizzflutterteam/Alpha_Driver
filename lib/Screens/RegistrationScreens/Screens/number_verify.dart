import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:work/utilities/color.dart';
import 'package:work/utilities/shared_pref..dart';

import '../../../Provider/signupController.dart';
import '../../../helper/CustomWidgets/custom_button.dart';
import '../../../helper/CustomWidgets/otp_widget.dart';
import '../../../helper/app_constant.dart';

class BankNumberVerify extends StatefulWidget {
  const BankNumberVerify({super.key});

  @override
  State<BankNumberVerify> createState() => _BankNumberVerifyState();
}

class _BankNumberVerifyState extends State<BankNumberVerify> {
  final SignupController signUpContr = Get.put(SignupController());
  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());

  void _increment() {
    signUpContr.increaseCurrentState();
  }

  @override
  Widget build(BuildContext context) {
    var otp = SharedPref.shared.pref!.getString(PrefKeys.otp);
    for (int i = 0; i < otp!.length; i++) {
      otpControllers[i].text = otp[i];
    }
    final th = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Enter your verification \ncode',
                style: th.bodyLarge?.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: appColorBlack),
              ),
              const SizedBox(height: 5),
              Text(
                'We have sent the OTP to ${signUpContr.phone}',
                style: th.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500, color: appColorBlack),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
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
              const SizedBox(height: 20),
              CustomButtonWidget(
                  text: 'VERIFY',
                  onPressed: () {
                    var enterdOTp = signUpContr
                        .retrieveStringFromControllers(otpControllers);
                    signUpContr.verifyOtp(enterdOTp);
                  }),
              const SizedBox(height: 20),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Didn\'t recieved Otp? ',
                      style: th.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500, color: appColorBlack),
                    ),
                    TextSpan(
                      text: 'Resend OTP ',
                      style: th.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700, color: appPrimaryColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await signUpContr.resendOtp();
                          setState(() {});
                        },
                    ),
                  ])),
            ],
          )),
    );
  }
}
