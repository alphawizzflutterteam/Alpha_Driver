import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:work/Models/profileModel.dart';
import 'package:work/helper/CustomWidgets/base_scaffold.dart';
import 'package:work/helper/CustomWidgets/custom_button.dart';
import 'package:work/utilities/shared_pref..dart';

import '../../../Provider/edit_profile_controller.dart';
import '../../../helper/CustomWidgets/custom_text_field.dart';
import '../../../helper/app_constant.dart';

class EditBankingInformation extends StatefulWidget {
  const EditBankingInformation({super.key});

  @override
  State<EditBankingInformation> createState() => _EditBankingInformationState();
}

class _EditBankingInformationState extends State<EditBankingInformation> {
  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  @override
  void dispose() {
    // editProfileController.bankAddressController.dispose();
    // editProfileController.bankNameController.dispose();
    // editProfileController.branchController.dispose();
    // editProfileController.micrCodeController.dispose();
    // editProfileController.ifscCodeController.dispose();
    // editProfileController.accountNumberController.dispose();
    // editProfileController.accountTypeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    var model =
        jsonDecode(SharedPref.shared.pref!.getString(PrefKeys.userDetails)!);

    Datum user = Datum.fromJson(model);

    editProfileController.bankAddressController.text = user.bankAddress;
    editProfileController.bankNameController.text = user.bankName;
    editProfileController.branchController.text = user.branch;
    editProfileController.micrCodeController.text = user.micrCode;
    editProfileController.ifscCodeController.text = user.ifscCode;
    editProfileController.accountNumberController.text = user.accountNo;
    editProfileController.accountTypeController.text = user.accountType;
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return BaseScaffold(
      title: 'Bank Information',
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: ListView(children: [
          // Text(
          //   'Enter your Account information',
          //   style: th.bodyLarge?.copyWith(
          //       fontSize: 26,
          //       fontWeight: FontWeight.w700,
          //       color: appColorBlack),
          // ),
          // const SizedBox(height: 5),
          // Text(
          //   'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
          //   style: th.bodySmall
          //       ?.copyWith(fontWeight: FontWeight.w700, color: Colors.grey),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          CustomTextField(
            controller: editProfileController.bankNameController,
            labelText: 'Bank Name',
            hintText: '',
            enabled: false,
            //   suffixIcon: Icons.arrow_drop_down_circle_outlined,
            inputFormatters: [],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: editProfileController.branchController,
            labelText: 'Bank Branch',
            hintText: '',
            enabled: false,
            inputFormatters: [],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: editProfileController.accountTypeController,
            labelText: 'Account Type',
            hintText: '',
            enabled: false,
            inputFormatters: [],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: editProfileController.micrCodeController,
            labelText: 'MIRC Code',
            enabled: false,
            hintText: '',
            inputFormatters: [],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: editProfileController.bankAddressController,
            keyboardType: TextInputType.number,
            labelText: 'Bank Address',
            enabled: false,
            hintText: '',
            inputFormatters: [],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: editProfileController.accountNumberController,
            keyboardType: TextInputType.datetime,
            labelText: 'Account Number',
            enabled: false,
            hintText: '',
            inputFormatters: [],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: editProfileController.ifscCodeController,
            keyboardType: TextInputType.datetime,
            labelText: 'IFSC Code Number',
            enabled: false,
            hintText: '',
            inputFormatters: [],
          ),
          const SizedBox(height: 40),
          // CustomButtonWidget(
          //     text: 'SAVE',
          //     onPressed: () {
          //       editProfileController.verifyAndPostBank();
          //     }),
        ]),
      ),
    );
  }
}
