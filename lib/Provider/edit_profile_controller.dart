import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:work/Provider/signupController.dart';
import 'package:work/Screens/HomeScreen/home_screen.dart';
import 'package:work/Screens/SinginScreens/SignInWithPhone/sign_in_wit_phone.dart';
import 'package:work/utilities/shared_pref..dart';
import 'dart:convert';
import 'dart:io';
import '../utilities/api_manager/apis.dart';
import '../utilities/api_manager/http_client.dart';
import '../utilities/utils.dart';
import 'package:http_parser/http_parser.dart';

class EditProfileController extends GetxController {
  RxBool isLoading = false.obs;
  File? selectedFileLicence;
  File? selectedFileVehicle;
  File? selecteduserImage;

  TextEditingController numberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController driverLicenceController = TextEditingController();
  TextEditingController dateOfIssueController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController stateOrCountryDateController = TextEditingController();

  TextEditingController typeController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController dateOfIssueVehileController = TextEditingController();
  TextEditingController expiryDateVehileController = TextEditingController();
  TextEditingController policyNumberController = TextEditingController();
  TextEditingController coverageNumberController = TextEditingController();

  TextEditingController permanentAddressController = TextEditingController();
  // TextEditingController cityController = TextEditingController();
  final cityName = ''.obs;
  // TextEditingController stateController = TextEditingController();
  final stateName = ''.obs;

  TextEditingController zipCodeController = TextEditingController();
  // TextEditingController countryController = TextEditingController();
  final countryName = ''.obs;

  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController micrCodeController = TextEditingController();
  TextEditingController bankAddressController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();

  TextEditingController personalNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String cityName1 = '';
  String stateName1 = '';
  String countryName1 = '';

  RxString name = "".obs;
  RxString email = "".obs;
  RxString phone = "".obs;
  RxString fcm_id = "".obs;
  RxString password = "".obs;
  RxString license_number = "".obs;
  RxString license_doi = "".obs;
  RxString license_exp_date = "".obs;
  RxString license_state = "".obs;
  RxString bank_name = "".obs;
  RxString branch_name = "".obs;
  RxString account_type = "".obs;
  RxString micr_code = "".obs;
  RxString bank_address = "".obs;
  RxString account_number = "".obs;
  RxString ifsc_code = "".obs;
  RxString address = "".obs;
  RxString city = "".obs;
  RxString state = "".obs;
  RxString pincode = "".obs;
  RxString country = "".obs;
  RxString vehicle_type = "".obs;
  RxString registeration_number = "".obs;
  RxString issue_date = "".obs;
  RxString expiration_date = "".obs;
  RxString policy_number = "".obs;
  RxString coverage_date = "".obs;

  verifyAndPutPassword() async {
    if (confirmPasswordController.text.isEmpty ||
        confirmPasswordController.text != passwordController.text) {
      Utils.showFlushBarWithMessage(
        'Invalid password!!!',
        Get.context!,
      );
    } else {
      Map map = {
        "old_password": oldPasswordController.text,
        "password": passwordController.text,
        "confirm_password": confirmPasswordController.text,
      };
      final res = await HTTPClient.postRequest(APIs.editPassword, map);
      print(res.toString());
      Get.find<SignupController>().getProfile();
    }
  }

  changePassword() async {
    if (confirmPasswordController.text.isEmpty ||
        confirmPasswordController.text != passwordController.text) {
      Utils.showFlushBarWithMessage(
        'Invalid password!!!',
        Get.context!,
      );
    } else {
      var mobile = SharedPref.shared.pref?.getString(PrefKeys.mobile);

      Map map = {
        'phone': mobile,
        "password": passwordController.text,
        "confirm_password": confirmPasswordController.text,
      };
      final res = await HTTPClient.postRequest(APIs.resetPassword, map);
      if (res['status'] == true) {
        Get.offAll(const SignInWithPhone());
        Utils.showFlushBarWithMessage(res["message"], Get.context!);
      } else {
        Utils.showFlushBarWithMessage(res["message"], Get.context!);
      }
    }
  }

  deleteAccount() async {
    final res = await HTTPClient.getAPI(APIs.deleteAccount);
    if (res['status'] == true) {
      Get.offAll(const SignInWithPhone());
      Utils.showFlushBarWithMessage(res["message"], Get.context!);
    } else {
      Utils.showFlushBarWithMessage(res["message"], Get.context!);
    }
  }

  verifyAndPostLicence() async {
    if (nameController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid name!!!',
        Get.context!,
      );
    } else if (driverLicenceController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid Driving license number!!!',
        Get.context!,
      );
    } else if (dateOfIssueController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid date of issue!!!',
        Get.context!,
      );
    } else if (expiryDateController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid date of expiry!!!',
        Get.context!,
      );
    } else if (stateOrCountryDateController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid state!!!',
        Get.context!,
      );
    } else if (selectedFileLicence.isNull) {
      Utils.showFlushBarWithMessage(
        'Upload driving license!!!',
        Get.context!,
      );
    } else {
      name.value = nameController.text;
      license_number.value = driverLicenceController.text;
      license_doi.value = dateOfIssueController.text;
      license_exp_date.value = expiryDateController.text;
      license_state.value = stateOrCountryDateController.text;
      Map map = {
        "name": name.value,
        "license_number": license_number.value,
        "license_doi": license_doi.value,
        "license_exp_date": license_exp_date.value,
        "license_state": license_state.value,
      };
      final res = await HTTPClient.postRequest(APIs.editDrivingProfile, map);
      print(res.toString());
    }
  }

  verifyAndPostVehicle() async {
    if (typeController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid type!!!',
        Get.context!,
      );
    } else if (vehicleNumberController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid Vehicle Registration number!!!',
        Get.context!,
      );
    } else if (dateOfIssueVehileController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid date of issue!!!',
        Get.context!,
      );
    } else if (expiryDateVehileController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid date of expiry!!!',
        Get.context!,
      );
    } else if (policyNumberController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid policy number!!!',
        Get.context!,
      );
    } else if (coverageNumberController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid coverage date!!!',
        Get.context!,
      );
    }
    // else if (selectedFileVehicle.isNull) {
    //   Utils.showFlushBarWithMessage(
    //     'Upload vehile image!!!',
    //     Get.context!,
    //   );
    // }
    else {
      vehicle_type.value = typeController.text;
      registeration_number.value = vehicleNumberController.text;
      issue_date.value = dateOfIssueVehileController.text;
      expiration_date.value = expiryDateVehileController.text;
      policy_number.value = policyNumberController.text;
      coverage_date.value = coverageNumberController.text;
      Map map = {
        "vehicle_type": vehicle_type.value,
        "registeration_number": registeration_number.value,
        "issue_date": issue_date.value,
        "expiration_date": expiration_date.value,
        "policy_number": policy_number.value,
        "coverage_date": coverage_date.value,
      };
      final res = await HTTPClient.postRequest(APIs.editVehicleProfile, map);
      print(res.toString());
    }
  }

  verifyAndPostAddress() async {
    cityName.value = cityName1;
    stateName.value = stateName1;
    countryName.value = countryName1;
    if (permanentAddressController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid Address!!!',
        Get.context!,
      );
    } else if (cityName.value == '') {
      Utils.showFlushBarWithMessage(
        'Invalid city!!!',
        Get.context!,
      );
    } else if (stateName.value == '') {
      Utils.showFlushBarWithMessage(
        'Invalid state!!!',
        Get.context!,
      );
    } else if (zipCodeController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid pincode!!!',
        Get.context!,
      );
    } else if (countryName.value == '') {
      Utils.showFlushBarWithMessage(
        'Invalid country!!!',
        Get.context!,
      );
    } else {
      address.value = permanentAddressController.text;
      city.value = cityName.value;
      state.value = stateName.value;
      pincode.value = zipCodeController.text;
      country.value = countryName.value;

      Map map = {
        "address": address.value,
        "city": city.value,
        "state": state.value,
        "country": "India",
        "pincode": pincode.value,
      };
      final res = await HTTPClient.postRequest(APIs.editAddress, map);
      Get.find<SignupController>().getProfile();
    }
  }

  verifyAndPostBank() async {
    if (bankNameController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid bank name!!!',
        Get.context!,
      );
    } else if (branchController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid branch name!!!',
        Get.context!,
      );
    } else if (accountTypeController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid account type!!!',
        Get.context!,
      );
    } else if (micrCodeController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid micr code!!!',
        Get.context!,
      );
    } else if (bankAddressController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid bank address!!!',
        Get.context!,
      );
    } else if (accountNumberController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid account number!!!',
        Get.context!,
      );
    } else if (ifscCodeController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid ifsc code!!!',
        Get.context!,
      );
    } else {
      bank_name.value = bankNameController.text;
      bank_address.value = bankAddressController.text;
      branch_name.value = branchController.text;
      account_type.value = accountTypeController.text;
      micr_code.value = micrCodeController.text;
      account_number.value = accountNumberController.text;
      ifsc_code.value = ifscCodeController.text;
      Map map = {
        "bank_name": bank_name.value,
        "branch_name": branch_name.value,
        "account_type": account_type.value,
        "micr_code": micr_code.value,
        "bank_address": bank_address.value,
        "account_number": account_number.value,
        "ifsc_code": ifsc_code.value,
      };
      final res = await HTTPClient.postRequest(APIs.editBankInfo, map);
      Get.find<SignupController>().getProfile();
      print(res.toString());
    }
  }

  Future<void> uploadFile(BuildContext context) async {
    final res = await HTTPClient.multipartRequestUserImage(
        APIs.uploadProfileImage,
        selecteduserImage!,
        MediaType('image', 'jpeg'));

    print(res["status"]);
    if (res['status'] == true) {
      getProfile();

      // await homeProvider.getProfileAPI({}, context);
      // Routes.navigateToPreviousScreen(context);
    }
  }

  getProfile() async {
    isLoading = true.obs;

    update();

    final res = await HTTPClient.getProfileResponse(APIs.profile);

    isLoading = false.obs;
    update();
    if (res.status == true) {
      SharedPref.shared.pref?.setString(PrefKeys.name, res.data[0].fName);
      SharedPref.shared.pref?.setString(PrefKeys.image, res.data[0].image);

      SharedPref.shared.pref
          ?.setString(PrefKeys.userDetails, jsonEncode(res.data[0]));
      Get.back();
      Get.back();
    } else {
      Utils.showFlushBarWithMessage(
        'Something went wrong!!!',
        Get.context!,
      );
    }
  }
}
