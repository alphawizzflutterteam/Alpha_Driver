import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Provider/signupController.dart';
import '../../../helper/CustomWidgets/custom_button.dart';
import '../../../helper/CustomWidgets/custom_text_field.dart';
import '../../../helper/CustomWidgets/upload_doc_widget.dart';
import '../../../helper/app_constant.dart';

class DrivingLicence extends StatefulWidget {
  const DrivingLicence({super.key});

  @override
  State<DrivingLicence> createState() => _DrivingLicenceState();
}

class _DrivingLicenceState extends State<DrivingLicence> {
  final SignupController signUpContr = Get.put(SignupController());

  DateTime selectedDOOI = DateTime.now();
  DateTime selectedExpiryDate = DateTime.now();

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool forDOI) async {
    // Check if the context is still valid and mounted
    if (context == null || !mounted) {
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      // initialDate: tomorrow,
      firstDate: !forDOI ? DateTime.now() : DateTime(2000),
      lastDate: forDOI ? DateTime.now() : DateTime(2050),
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
          signUpContr.license_doi.value = formattedDate;
          signUpContr.dateOfIssueController.text = formattedDate;
        }
      } else {
        if (picked != null && picked != selectedExpiryDate) {
          setState(() {
            selectedExpiryDate = picked;
          });
          String formattedDate =
              DateFormat('yyyy-MM-dd').format(selectedExpiryDate);
          print(formattedDate);
          signUpContr.license_exp_date.value = formattedDate;
          signUpContr.expiryDateController.text = formattedDate;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
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
          'Empower your E-Commerce journey with the Driver app – just enter your details and hit the road to seamless deliveries!',
          style: th.bodySmall
              ?.copyWith(fontWeight: FontWeight.w700, color: Colors.grey),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        CustomTextField(
          controller: signUpContr.nameController,
          labelText: 'Full Name',
          hintText: '',
          textCapitalization: TextCapitalization.words,
          maxLength: 30,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\d+')),
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
          ],
        ),
        const SizedBox(height: 20),
        CustomTextField(
          maxLength: 13,
          controller: signUpContr.driverLicenceController,
          labelText: 'Driver\' Licence Number',
          hintText: '',
          textCapitalization: TextCapitalization.characters,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9]*$")),
          ],
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: signUpContr.dateOfIssueController,
          keyboardType: TextInputType.datetime,
          labelText: 'Date of Issue',
          hintText: '2023-10-12',
          onTap: () {
            _selectDate(context, true);
          },
          inputFormatters: [LengthLimitingTextInputFormatter(10)],
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: signUpContr.expiryDateController,
          keyboardType: TextInputType.datetime,
          labelText: 'Expiry Date',
          hintText: '2023-10-12',
          onTap: () {
            _selectDate(context, false);
          },
          inputFormatters: [LengthLimitingTextInputFormatter(10)],
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: signUpContr.stateOrCountryDateController,
          textCapitalization: TextCapitalization.words,
          labelText: 'State of Issuance',
          maxLength: 30,
          hintText: '',
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9 ]*$")),
          ],
        ),
        const SizedBox(height: 20),
        FileUploadWidget(
          text: 'Upload License',
          controller: signUpContr,
        ),
        const SizedBox(height: 30),
        CustomButtonWidget(
            text: 'CONTINUE',
            onPressed: () {
              signUpContr.verifyLicence();
            }),
      ]),
    );
  }
}
