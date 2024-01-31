import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:work/Screens/RegistrationScreens/regristration_screen.dart';
import 'package:work/Screens/SinginScreens/controller/signInController.dart';
import 'package:work/helper/CustomWidgets/custom_text_field.dart';
import 'package:work/helper/app_constant.dart';
import 'package:work/utilities/color.dart';

class VerifyByNumber extends StatefulWidget {
  const VerifyByNumber({super.key});

  @override
  State<VerifyByNumber> createState() => _VerifyByNumberState();
}

class _VerifyByNumberState extends State<VerifyByNumber> {
  TextEditingController numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneCtrl = TextEditingController();
  final LoginController loginContr = Get.put(LoginController());

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var th = Theme.of(context).textTheme;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: height * .35,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("assets/images/onboarding_bg-light.png"))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                "Verify Number",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              centerTitle: true,
            ),
          ),
          Positioned(
            top: height * .07,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: height * .9,
                width: width * .9,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * .15),
                      Image.asset("assets/images/alpha_logo-light.png",
                          height: (height / width) * 35,
                          width: (height / width) * 35),
                      // const Divider(color: Colors.transparent),
                      const Text(
                        "Enter your mobile number",
                        style: TextStyle(fontSize: 28),
                      ),

                      const Text(
                        "We will send you 6 digit verification code",
                        style: TextStyle(fontSize: 14, color: colors.greyText),
                      ),
                      const Divider(color: Colors.transparent),
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
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true),
                            textInputAction: TextInputAction.send,
                            onTap: () {},
                          ),
                        ),
                      ),
                      // TextFormField(
                      //   controller: phoneCtrl,
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter.allow(RegExp(r'\d+'))
                      //   ],
                      //   decoration: const InputDecoration()
                      //       .applyDefaults(
                      //           Theme.of(context).inputDecorationTheme)
                      //       .copyWith(label: const Text("Mobile No.")),
                      //   validator: (value) {
                      //     if (value == null ||
                      //         value.isEmpty ||
                      //         value.length < 10) {
                      //       return "Enter a valid number";
                      //     }
                      //     return null;
                      //   },
                      //   keyboardType: TextInputType.number,
                      //   maxLength: 10,
                      //   onChanged: (value) {
                      //     if (value.length == 10) {
                      //       FocusScope.of(context).unfocus();
                      //     }
                      //   },
                      // ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      GestureDetector(
                        onTap: () {
                          loginContr.sendOTP(false);
                        },
                        child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: appPrimaryColor),
                            child: const Center(
                              child: Text(
                                "SEND",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ),
                      //Spacer(),
                      SizedBox(height: height * 0.26),
                      GestureDetector(
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
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
