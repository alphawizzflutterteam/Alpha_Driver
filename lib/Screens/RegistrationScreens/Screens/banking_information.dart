import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:work/helper/CustomWidgets/custom_button.dart';
import 'package:work/utilities/color.dart';

import '../../../Provider/signupController.dart';
import '../../../helper/CustomWidgets/custom_text_field.dart';
import '../../../helper/app_constant.dart';

class BankingInformation extends StatefulWidget {
  const BankingInformation({super.key});

  @override
  State<BankingInformation> createState() => _BankingInformationState();
}

class _BankingInformationState extends State<BankingInformation> {
  final SignupController signUpContr = Get.put(SignupController());

  final List<String> gender = ["Male", "Female", "Others"];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    signUpContr.accountTypeController.text = "Select Account Type";
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
          'Enter your Account information',
          style: th.bodyLarge?.copyWith(
              fontSize: 26, fontWeight: FontWeight.w700, color: appColorBlack),
        ),
        const SizedBox(height: 5),
        Text(
          'Safely manage your earnings with our E-Commerce Driver app by securely entering your bank account details',
          style: th.bodySmall
              ?.copyWith(fontWeight: FontWeight.w700, color: Colors.grey),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        CustomTextField(
          controller: signUpContr.bankNameController,
          labelText: 'Bank Name',
          hintText: '',
          maxLength: 40,
          textCapitalization: TextCapitalization.words,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9 ]*$")),
          ],
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: signUpContr.branchController,
          labelText: 'Bank Branch',
          hintText: '',
          maxLength: 40,
          textCapitalization: TextCapitalization.words,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9 ]*$")),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: appColorBlack, width: 0.6)),
          padding: const EdgeInsets.only(
              left: defaultPadding,
              bottom: defaultPadding,
              top: defaultPadding),
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 12),
            child: DropdownButton<String>(
              underline: Container(),
              isExpanded: true,
              value: signUpContr.selectAccountType,
              dropdownColor: Theme.of(context).brightness == Brightness.dark
                  ? colors.darkBG
                  : Colors.white,
              onChanged: (String? newValue) {
                setState(() {
                  signUpContr.selectAccountType = newValue!;
                  signUpContr.accountTypeController.text = newValue;
                });
              },
              items: signUpContr.accountOptions
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? colors.textColor
                            : Colors.black),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        // CustomTextField(
        //   controller: signUpContr.accountTypeController,
        //   labelText: 'Account Type',
        //   hintText: '',
        //   inputFormatters: [],
        // ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: signUpContr.micrCodeController,
          labelText: 'MIRC Code',
          hintText: '',
          keyboardType: TextInputType.numberWithOptions(signed: true),
          maxLength: 9,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'\d+'))],
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: signUpContr.bankAddressController,
          keyboardType: TextInputType.text,
          labelText: 'Bank Address',
          hintText: '',
          maxLength: 50,
          inputFormatters: [],
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: signUpContr.accountNumberController,
          keyboardType: TextInputType.number,
          labelText: 'Account Number',
          hintText: '',
          maxLength: 15,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'\d+'))],
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: signUpContr.ifscCodeController,
          labelText: 'IFSC Code Number',
          hintText: '',
          textCapitalization: TextCapitalization.characters,
          maxLength: 11,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9 ]*$")),
          ],
        ),
        const SizedBox(height: 30),
        CustomButtonWidget(
            text: 'CONTINUE',
            onPressed: () {
              signUpContr.verifyBank();
            }),
      ]),
    );
  }
}
