import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work/Provider/signupController.dart';
import 'package:work/utilities/app_color.dart';
import '../../utilities/sizedBox.dart';
import 'Screens/address_detail.dart';
import 'Screens/banking_information.dart';
import 'Screens/confirm_password.dart';
import 'Screens/create_acount.dart';
import 'Screens/driving_licence.dart';
import 'Screens/number_verify.dart';
import 'Screens/personal_details.dart';
import 'Screens/vechile_detail.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupController signUpContr = Get.put(SignupController());
  @override
  // void dispose() {
  //   signUpContr.nameController.dispose();
  //
  //
  //
  //   signUpContr.passwordController.dispose();
  //   signUpContr.confirmPasswordController.dispose();
  //
  //   signUpContr.driverLicenceController.dispose();
  //   signUpContr.dateOfIssueController.dispose();
  //   signUpContr.expiryDateController.dispose();
  //   signUpContr.stateOrCountryDateController.dispose();
  //
  //   signUpContr.typeController.dispose();
  //   signUpContr.vehicleNumberController.dispose();
  //   signUpContr.dateOfIssueController.dispose();
  //   signUpContr.expiryDateController.dispose();
  //   signUpContr.policyNumberController.dispose();
  //   signUpContr.coverageNumberController.dispose();
  //   signUpContr.numberController.dispose();
  //
  //   signUpContr.permanentAddressController.dispose();
  //   signUpContr.countryName=' ';
  //   signUpContr.stateName=' ';
  //   signUpContr.cityName=' ';
  //
  //   signUpContr.bankAddressController.dispose();
  //   signUpContr.bankNameController.dispose();
  //   signUpContr.branchController.dispose();
  //   signUpContr.micrCodeController.dispose();
  //   signUpContr.ifscCodeController.dispose();
  //   signUpContr.accountNumberController.dispose();
  //   signUpContr.accountTypeController.dispose();
  //
  //
  //   signUpContr.nameController.dispose();
  //   signUpContr.emailController.dispose();
  //   signUpContr.zipCodeController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return GetBuilder<SignupController>(
        builder: (c) => WillPopScope(
              onWillPop: () {
                if (signUpContr.currentState == 0) {
                  Navigator.pop(context);
                  return Future.value(false);
                } else {
                  signUpContr.decreaseCurrentState();
                  return Future.value(false);
                }
              },
              child: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    leading: InkWell(
                        onTap: () {
                          if (signUpContr.currentState == 0) {
                            Navigator.pop(context);
                            // return Future.value(false);
                          } else {
                            signUpContr.decreaseCurrentState();
                            // return Future.value(false);
                          }
                          // Get.offAll(const SignInWithPhone());
                        },
                        child: const Icon(Icons.arrow_back_ios)),
                    title: Text(
                      "Registration Onboarding",
                      style: th.bodyLarge
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    centerTitle: true,
                  ),
                  body: SafeArea(
                    child: Column(
                      children: [
                        boxA1(),
                        Container(
                          //padding: const EdgeInsets.only(left: 20),
                          clipBehavior: Clip.none,
                          child: EasyStepper(
                              activeStep: signUpContr.currentState,
                              lineStyle: const LineStyle(
                                lineLength: 90,
                                lineSpace: 0,
                                lineType: LineType.normal,
                                defaultLineColor: Colors.black,
                                finishedLineColor: AppColors.theme,
                                lineThickness: 1.5,
                              ),
                              // signUpContr.currentStateTextColor: Colors.black87,
                              finishedStepTextColor: Colors.black87,
                              internalPadding: 0,
                              showLoadingAnimation: false,
                              stepRadius: 6,
                              showStepBorder: false,
                              steps: [
                                EasyStep(
                                  customStep: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: signUpContr.currentState >= 0
                                          ? AppColors.theme
                                          : Colors.black,
                                    ),
                                  ),
                                  customTitle: iconTitle(
                                      'Phone', signUpContr.currentState, 0),
                                ),
                                EasyStep(
                                  customStep: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: signUpContr.currentState >= 1
                                          ? AppColors.theme
                                          : Colors.black,
                                    ),
                                  ),
                                  customTitle: iconTitle(
                                      'Verify', signUpContr.currentState, 2),
                                ),
                                EasyStep(
                                  customStep: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: signUpContr.currentState >= 2
                                          ? AppColors.theme
                                          : Colors.black,
                                    ),
                                  ),
                                  customTitle: iconTitle('Password Confirm',
                                      signUpContr.currentState, 2),
                                ),
                                EasyStep(
                                  customStep: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: signUpContr.currentState >= 3
                                          ? AppColors.theme
                                          : Colors.black,
                                    ),
                                  ),
                                  customTitle: iconTitle('Driver\'s Licence',
                                      signUpContr.currentState, 3),
                                ),
                                EasyStep(
                                  customStep: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: signUpContr.currentState >= 4
                                          ? AppColors.theme
                                          : Colors.black,
                                    ),
                                  ),
                                  customTitle: iconTitle('Vechile\'s Licence',
                                      signUpContr.currentState, 4),
                                ),
                                EasyStep(
                                  customStep: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: signUpContr.currentState >= 5
                                          ? AppColors.theme
                                          : Colors.black,
                                    ),
                                  ),
                                  customTitle: iconTitle('Address Licence',
                                      signUpContr.currentState, 5),
                                ),
                                EasyStep(
                                  customStep: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: signUpContr.currentState >= 6
                                          ? AppColors.theme
                                          : Colors.black,
                                    ),
                                  ),
                                  customTitle: iconTitle('Banking Information',
                                      signUpContr.currentState, 6),
                                ),
                                EasyStep(
                                  customStep: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: signUpContr.currentState >= 7
                                          ? AppColors.theme
                                          : Colors.black,
                                    ),
                                  ),
                                  customTitle: iconTitle(
                                      'Detail', signUpContr.currentState, 7),
                                ),
                              ],
                              onStepReached: (index) => {}),
                        ),
                        if (signUpContr.currentState == 0)
                          const Expanded(child: CreateAccount()),
                        if (signUpContr.currentState == 1)
                          const Expanded(child: BankNumberVerify()),
                        if (signUpContr.currentState == 2)
                          const Expanded(child: ConfirmPassword()),
                        if (signUpContr.currentState == 3)
                          const Expanded(child: DrivingLicence()),
                        if (signUpContr.currentState == 4)
                          const Expanded(child: VehicleDetail()),
                        if (signUpContr.currentState == 5)
                          const Expanded(child: AddressDetail()),
                        if (signUpContr.currentState == 6)
                          const Expanded(child: BankingInformation()),
                        if (signUpContr.currentState == 7)
                          const Expanded(child: PersonalDetails()),
                      ],
                    ),
                  )),
            ));
  }
}

iconTitle(text, currentState, index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Visibility(
        visible: index == 0,
        child: SizedBox(
          width: 35,
        ),
      ),
      SvgPicture.asset(
        'assets/icons/tick.svg',
        color: currentState == index ? Colors.black : Colors.grey,
        height: 13,
      ),
      SizedBox(
        width: 54,
        child: Text(
          text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: currentState == index ? Colors.black : Color(0xffC3C5DD)),
        ),
      ),
      Visibility(
        visible: index == 7,
        child: SizedBox(
          width: 10,
        ),
      ),
    ],
  );
}
