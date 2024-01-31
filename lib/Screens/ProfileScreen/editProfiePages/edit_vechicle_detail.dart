import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:work/Models/profileModel.dart';
import 'package:work/helper/CustomWidgets/base_scaffold.dart';
import 'package:work/utilities/shared_pref..dart';

import '../../../Provider/edit_profile_controller.dart';
import '../../../helper/CustomWidgets/custom_button.dart';
import '../../../helper/CustomWidgets/custom_text_field.dart';
import '../../../helper/CustomWidgets/upload_doc_widget.dart';
import '../../../helper/app_constant.dart';

class EditVehicleDetail extends StatefulWidget {
  const EditVehicleDetail({super.key});

  @override
  State<EditVehicleDetail> createState() => _EditVehicleDetailState();
}

class _EditVehicleDetailState extends State<EditVehicleDetail> {
  final EditProfileController editProfileController =
      Get.put(EditProfileController());
  DateTime selectedDOOI = DateTime.now();
  DateTime selectedExpiryDate = DateTime.now();
  DateTime coverageDate = DateTime.now();
  var vehicleImage = "";
  Future<void> _selectDate(BuildContext context, int forDOI) async {
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
      if (forDOI == 1) {
        if (picked != null && picked != selectedDOOI) {
          setState(() {
            selectedDOOI = picked;
          });
          String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDOOI);
          print(formattedDate);
          editProfileController.dateOfIssueVehileController.text =
              formattedDate;
        }
      } else if (forDOI == 2) {
        if (picked != null && picked != selectedExpiryDate) {
          setState(() {
            selectedExpiryDate = picked;
          });
          String formattedDate =
              DateFormat('yyyy-MM-dd').format(selectedExpiryDate);
          print(formattedDate);
          editProfileController.expiryDateVehileController.text = formattedDate;
        }
      } else {
        if (picked != null && picked != coverageDate) {
          setState(() {
            coverageDate = picked;
          });
          String formattedDate = DateFormat('yyyy-MM-dd').format(coverageDate);
          print(formattedDate);
          editProfileController.coverageNumberController.text = formattedDate;
        }
      }
    }
  }

  @override
  void dispose() {
    // editProfileController.typeController.dispose();
    // editProfileController.vehicleNumberController.dispose();
    // editProfileController.dateOfIssueController.dispose();
    // editProfileController.expiryDateController.dispose();
    // editProfileController.policyNumberController.dispose();
    // editProfileController.coverageNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    var model =
        jsonDecode(SharedPref.shared.pref!.getString(PrefKeys.userDetails)!);

    Datum user = Datum.fromJson(model);

    print(user.vehicleImage);
    editProfileController.vehicleNumberController.text =
        user.registerationNumber;
    editProfileController.typeController.text = user.vehicleType;
    editProfileController.dateOfIssueVehileController.text = user.issueDate;
    editProfileController.expiryDateVehileController.text = user.expirationDate;
    editProfileController.policyNumberController.text = user.policyNumber;
    editProfileController.coverageNumberController.text = user.coverageDate;
    vehicleImage = user.vehicleImage;
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return BaseScaffold(
      title: 'Vehicle Info',
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding),
        child: ListView(children: [
          // Text(
          //   'Enter your vehicle detail',
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
            controller: editProfileController.typeController,
            labelText: 'Vehicle Type',
            hintText: '',
            // suffixIcon: Icons.arrow_drop_down_circle_outlined,
            inputFormatters: [],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            enabled: false,
            controller: editProfileController.vehicleNumberController,
            labelText: 'Vehicle Registration number',
            hintText: '',
            inputFormatters: [],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            enabled: false,
            controller: editProfileController.dateOfIssueVehileController,
            keyboardType: TextInputType.number,
            labelText: 'Issue Date',
            hintText: '',
            onTap: () {
              _selectDate(context, 1);
            },
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            enabled: false,
            controller: editProfileController.expiryDateVehileController,
            keyboardType: TextInputType.datetime,
            labelText: 'Expiry Date',
            hintText: '',
            onTap: () {
              _selectDate(context, 2);
            },
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            enabled: false,
            controller: editProfileController.policyNumberController,
            keyboardType: TextInputType.number,
            labelText: 'Policy number',
            hintText: '',
            inputFormatters: [],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            enabled: false,
            controller: editProfileController.coverageNumberController,
            keyboardType: TextInputType.datetime,
            labelText: 'Coverage date',
            hintText: '',
            onTap: () {
              _selectDate(context, 3);
            },
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
          ),
          const SizedBox(height: 15),
          vehicleImage == ""
              ? FileUploadWidget(
                  text: 'Vehicle Photo',
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
                            imageUrl: vehicleImage,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),
          const SizedBox(height: 30),
          // CustomButtonWidget(
          //     enable: false,
          //     text: 'SAVE',
          //     onPressed: () {
          //       // editProfileController.verifyAndPostVehicle();
          //     }),
        ]),
      ),
    );
  }
}
