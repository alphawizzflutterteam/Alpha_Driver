import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:work/Models/profileModel.dart';
import 'package:work/Provider/edit_profile_controller.dart';
import 'package:work/helper/CustomWidgets/base_scaffold.dart';
import 'package:work/utilities/shared_pref..dart';
import '../../../helper/CustomWidgets/custom_button.dart';
import '../../../helper/CustomWidgets/custom_text_field.dart';
import '../../../helper/CustomWidgets/upload_doc_widget.dart';
import '../../../helper/app_constant.dart';

class EditDrivingLicence extends StatefulWidget {
  const EditDrivingLicence({super.key});

  @override
  State<EditDrivingLicence> createState() => _EditDrivingLicenceState();
}

class _EditDrivingLicenceState extends State<EditDrivingLicence> {
  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  var licenseImage = "";
  DateTime selectedDOOI = DateTime.now();
  DateTime selectedExpiryDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, bool forDOI) async {
    // Check if the context is still valid and mounted
    if (context == null || !mounted) {
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      // initialDate: tomorrow,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      // Set mode to only display the calendar
    );

    // Check if the context is still valid and mounted before updating state
    if (context != null && mounted) {
      if (forDOI) {
        if (picked != null && picked != selectedDOOI) {
          setState(() {
            selectedDOOI = picked;
          });
          String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDOOI);
          print(formattedDate);
          editProfileController.license_doi.value = formattedDate;
          editProfileController.dateOfIssueController.text = formattedDate;
        }
      } else {
        if (picked != null && picked != selectedExpiryDate) {
          setState(() {
            selectedExpiryDate = picked;
          });
          String formattedDate =
              DateFormat('yyyy-MM-dd').format(selectedExpiryDate);
          // print(formattedDate);
          editProfileController.license_exp_date.value = formattedDate;
          editProfileController.expiryDateController.text = formattedDate;
        }
      }
    }
  }

  @override
  void dispose() {
    // editProfileController.nameController.dispose();
    // editProfileController.driverLicenceController.dispose();
    // editProfileController.dateOfIssueController.dispose();
    // editProfileController.expiryDateController.dispose();
    // editProfileController.stateOrCountryDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    var model =
        jsonDecode(SharedPref.shared.pref!.getString(PrefKeys.userDetails)!);

    Datum user = Datum.fromJson(model);

    editProfileController.nameController.text = user.fName;
    editProfileController.driverLicenceController.text = user.licenseNumber;
    editProfileController.dateOfIssueController.text = user.licenseDoi;
    editProfileController.expiryDateController.text = user.licenseExpDate;
    editProfileController.stateOrCountryDateController.text = user.licenseState;
    licenseImage = user.licenseImage;
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return BaseScaffold(
      title: 'Driver\'s Licence',
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding),
        child: ListView(children: [
          // Text(
          //   'Enter your detail',
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
            enabled: false,
            controller: editProfileController.nameController,
            labelText: 'Full Name',
            hintText: '',
            inputFormatters: [],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            enabled: false,
            controller: editProfileController.driverLicenceController,
            labelText: 'Driver\' Licence Number',
            hintText: '',
            inputFormatters: [],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            enabled: false,
            controller: editProfileController.dateOfIssueController,
            keyboardType: TextInputType.datetime,
            labelText: 'Date of Issue',
            hintText: '',
            onTap: () {
              _selectDate(context, true);
            },
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            enabled: false,
            controller: editProfileController.expiryDateController,
            keyboardType: TextInputType.datetime,
            labelText: 'Expiry Date',
            hintText: '',
            onTap: () {
              _selectDate(context, false);
            },
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            enabled: false,
            controller: editProfileController.stateOrCountryDateController,
            keyboardType: TextInputType.name,
            labelText: 'State or Country of Issuance',
            hintText: '',
            inputFormatters: [],
          ),
          const SizedBox(height: 15),
          licenseImage == ""
              ? FileUploadWidget(
                  text: 'Upload License',
                  controller: editProfileController,
                )
              : GestureDetector(
                  // onTap: _pickFile,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Card(
                      child: SizedBox(
                          width: 120,
                          height: 90,
                          child: CachedNetworkImage(
                            imageUrl: licenseImage,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),
          const SizedBox(height: 40),
          // CustomButtonWidget(
          //     enable: false,
          //     text: 'SAVE',
          //     onPressed: () {
          //       // editProfileController.verifyAndPostLicence();
          //     }),
        ]),
      ),
    );
  }
}
