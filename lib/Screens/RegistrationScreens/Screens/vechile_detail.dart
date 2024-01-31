import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:work/helper/CustomWidgets/upload_doc_vehicle.dart';

import '../../../Provider/signupController.dart';
import '../../../helper/CustomWidgets/custom_button.dart';
import '../../../helper/CustomWidgets/custom_text_field.dart';
import '../../../helper/CustomWidgets/upload_doc_widget.dart';
import '../../../helper/app_constant.dart';

class VehicleDetail extends StatefulWidget {
  const VehicleDetail({super.key});

  @override
  State<VehicleDetail> createState() => _VehicleDetailState();
}

class _VehicleDetailState extends State<VehicleDetail> {
  final SignupController signUpContr = Get.put(SignupController());
  DateTime selectedDOOI = DateTime.now();
  DateTime selectedExpiryDate = DateTime.now();
  DateTime coverageDate = DateTime.now();
  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, int forDOI) async {
    // Check if the context is still valid and mounted
    if (context == null || !mounted) {
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      // initialDate: tomorrow,
      firstDate: forDOI != 1 ? DateTime.now() : DateTime(2000),
      lastDate: forDOI == 1 ? DateTime.now() : DateTime(2050),
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
          signUpContr.dateOfIssueVehileController.text = formattedDate;
        }
      } else if (forDOI == 2) {
        if (picked != null && picked != selectedExpiryDate) {
          setState(() {
            selectedExpiryDate = picked;
          });
          String formattedDate =
              DateFormat('yyyy-MM-dd').format(selectedExpiryDate);
          print(formattedDate);
          signUpContr.expiryDateVehileController.text = formattedDate;
        }
      } else {
        if (picked != null && picked != coverageDate) {
          setState(() {
            coverageDate = picked;
          });
          String formattedDate = DateFormat('yyyy-MM-dd').format(coverageDate);
          print(formattedDate);
          signUpContr.coverageNumberController.text = formattedDate;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () {
        signUpContr.decreaseCurrentState();
        return Future.value(true);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: ListView(children: [
          Text(
            'Enter your vehicle detail',
            style: th.bodyLarge?.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: appColorBlack),
          ),
          const SizedBox(height: 5),
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            style: th.bodySmall
                ?.copyWith(fontWeight: FontWeight.w700, color: Colors.grey),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          CustomTextField(
            controller: signUpContr.typeController,
            labelText: 'Vehicle Type',
            hintText: '',
            textCapitalization: TextCapitalization.characters,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9 ]*$")),
            ],
          ),
          const SizedBox(height: 20),
          CustomTextField(
            textCapitalization: TextCapitalization.characters,
            controller: signUpContr.vehicleNumberController,
            labelText: 'Vehicle Registration number',
            maxLength: 21,
            hintText: '',
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9]*$")),
            ],
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: signUpContr.dateOfIssueVehileController,
            keyboardType: TextInputType.datetime,
            labelText: 'Issue Date Vehicle',
            hintText: '',
            onTap: () {
              _selectDate(context, 1);
            },
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: signUpContr.expiryDateVehileController,
            keyboardType: TextInputType.datetime,
            labelText: 'Expiry Date Vehicle',
            hintText: '',
            onTap: () {
              _selectDate(context, 2);
            },
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: signUpContr.policyNumberController,
            labelText: 'Policy number',
            maxLength: 25,
            hintText: '',
            textCapitalization: TextCapitalization.characters,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9]*$")),
            ],
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: signUpContr.coverageNumberController,
            keyboardType: TextInputType.datetime,
            labelText: 'Coverage date',
            hintText: '',
            onTap: () {
              _selectDate(context, 3);
            },
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
          ),
          const SizedBox(height: 20),
          FileUploadVehicleWidget(
            text: 'Vehicle Photo',
            controller: signUpContr,
          ),
          const SizedBox(height: 30),
          CustomButtonWidget(
              text: 'CONTINUE',
              onPressed: () {
                signUpContr.verifyVehicle();
                //  _increment();
              }),
        ]),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
