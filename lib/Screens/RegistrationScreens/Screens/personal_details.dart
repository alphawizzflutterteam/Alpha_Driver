import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:work/utilities/utils.dart';

import '../../../Provider/signupController.dart';
import '../../../helper/CustomWidgets/custom_button.dart';
import '../../../helper/CustomWidgets/custom_text_field.dart';
import '../../../helper/app_constant.dart';
import '../../HomeScreen/home_screen.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final SignupController signUpContr = Get.put(SignupController());

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: ListView(children: [
        Text(
          'Enter your detail',
          style: th.bodyLarge?.copyWith(
              fontSize: 26, fontWeight: FontWeight.w700, color: appColorBlack),
        ),
        const SizedBox(height: 5),
        Text(
          'Seamlessly drive your E-Commerce success with just a tap – Enter your personal details and accelerate your business journey with our Driver apps.',
          style: th.bodySmall
              ?.copyWith(fontWeight: FontWeight.w700, color: Colors.grey),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        CustomTextField(
          controller: signUpContr.personalNameController,
          labelText: 'Full Name',
          keyboardType: TextInputType.name,
          hintText: '',
          textCapitalization: TextCapitalization.words,
          maxLength: 40,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9 ]*$")),
          ],
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: signUpContr.emailController,
          keyboardType: TextInputType.emailAddress,
          labelText: 'Personal Email ID',
          maxLength: 50,
          hintText: '',
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9@.]')), // Allow only alphanumeric characters

            /// You can add additional formatters if needed
          ],
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: signUpContr.SellerCodeCtrl,
          keyboardType: TextInputType.text,
          labelText: 'Seller Code',
          hintText: '',
          maxLength: 20,
          inputFormatters: [],
        ),
        const SizedBox(height: 20),
        CustomButtonWidget(
            text: 'CONTINUE',
            onPressed: () {
              final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(signUpContr.emailController.text);
              if (!emailValid) {
                return Utils.showFlushBarWithMessage(
                    "Invalid Email Address", context);
              } else if (signUpContr.personalNameController.text.isEmpty) {
                return Utils.showFlushBarWithMessage(
                    "Please enter your name.", context);
              } else {
                signUpContr.verifyPersonalDetails();
              }
            }),
      ]),
    );
  }
}
