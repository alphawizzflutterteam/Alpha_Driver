import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:work/Provider/signupController.dart';
import 'package:work/Screens/RegistrationScreens/Screens/create_acount.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../helper/app_constant.dart';
import 'Screens/address_detail.dart';
import 'Screens/banking_information.dart';
import 'Screens/confirm_password.dart';
import 'Screens/driving_licence.dart';
import 'Screens/number_verify.dart';
import 'Screens/personal_details.dart';
import 'Screens/vechile_detail.dart';

class FormPage extends StatefulWidget {
  FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final SignupController signUpContr = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    final list = [
      iconTitle('Phone'),
      iconTitle('Password Confirm'),
      iconTitle('Driver\'s Licence'),
      iconTitle('Vechile\'s Licence'),
      iconTitle('Address Licence'),
    ];
    // int currentState =
    //     Provider.of<signUpContr>(context, listen: false).currentState;
    return GetBuilder<SignupController>(
        builder: (c) => MaterialApp(
              home: Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      "Registration Onboarding ",
                    ),
                    centerTitle: true,
                  ),
                  body: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.black,
                        height: 2,
                        child: Stack(
                          children: [
                            Container(
                              width: (signUpContr.currentState + 1) * 60,
                              color: Colors.grey,
                              height: 2,
                            ),
                            Container(
                              width: (signUpContr.currentState + 1) * 30,
                              color: Colors.blue,
                              height: 2,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 70,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return list[index];
                              })),
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
                  )),
            ));
  }

  iconTitle(text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.gpp_good_rounded),
        SizedBox(
          width: 70,
          child: Text(
            text,
            style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w400,
                color: appColorBlack),
          ),
        )
      ],
    );
  }
}
