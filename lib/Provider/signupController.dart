import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:work/Models/cities_model.dart';
import 'package:work/Models/country_model.dart';
import 'package:work/Models/states_model.dart';
import 'package:work/utilities/api_manager/apis.dart';
import 'package:work/utilities/api_manager/http_client.dart';
import 'package:work/utilities/shared_pref..dart';
import 'package:work/utilities/utils.dart';
import 'package:http_parser/http_parser.dart';

import '../Screens/HomeScreen/home_screen.dart';

class SignupController extends GetxController {
  RxBool isLoading = false.obs;
  File? selectedFileLicence;
  File? selectedFileVehicle;

  DataCountry? selectedCountry;
  DatuState? selectedState;
  Datuc? selectedCity;

  Rx<StateModel>? stateList;
  RxList<DatuState> stateListItems = <DatuState>[].obs;
  RxList<DataCountry> countryListItem = <DataCountry>[].obs;
  Rx<CountryModel>? countryList;

  Rx<CitiesModel>? citiesList;
  RxList<Datuc> citiesListItems = <Datuc>[].obs;

  getCountryList() async {
    isLoading = true.obs;
    final res = await HTTPClient.getCountryList(APIs.countryList);
    countryList = res.obs;
    countryListItem.value = countryList!.value.data;
    isLoading = false.obs;
    update();

    getStateList(countryList!.value.data.first.id.toString());
  }

  setCountry(DataCountry? value) async {
    selectedCountry = value;
    selectedState = null;
    stateListItems!.clear();
    selectedCity = null;
    citiesListItems.clear();
    // notifyListeners();
    await getStateList(value!.id.toString());
    update();
  }

  setState(DatuState? value) async {
    selectedState = value;
    print('state${selectedState!.name}');
    update();
    selectedCity = null;
    citiesListItems.clear();
    await getCityList(value!.id.toString());
    update();
    // selectedState = null;
    // states.clear();
    // selectedCity = null;
    // cities.clear();
    // notifyListeners();
  }

  setCity(Datuc? value) {
    selectedCity = value;

    print('city${selectedCity!.name}');
    update();
    // getCityList(value!.id.toString());
    // selectedState = null;
    // states.clear();
    // selectedCity = null;
    // cities.clear();
    // notifyListeners();
  }

  getStateList(id) async {
    isLoading = true.obs;

    final res = await HTTPClient.getStateList(APIs.stateList + id);
    stateList = res.obs;
    stateListItems = stateList!.value.data.obs;
    isLoading = false.obs;
    update();
  }

  getCityList(id) async {
    isLoading = true.obs;
    final res = await HTTPClient.getCitiesList(APIs.citiesList + id);
    print(APIs.citiesList + id);
    citiesList = res.obs;
    citiesListItems = citiesList!.value.data.obs;
    isLoading = false.obs;

    update();
  }

  TextEditingController numberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
  // TextEditingController stateController = TextEditingController();

  TextEditingController zipCodeController = TextEditingController();
  // TextEditingController countryController = TextEditingController();

  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController micrCodeController = TextEditingController();
  TextEditingController bankAddressController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();

  TextEditingController personalNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController SellerCodeCtrl = TextEditingController();
  String selectAccountType = 'Select Account Type'; // Default selected gender
  // List of gender options
  List<String> accountOptions = [
    'Select Account Type',
    'Savings Account',
    'Current Account'
  ];

  int currentState = 0;
  increaseCurrentState() {
    currentState++;
    print(currentState);
    update();
  }

  decreaseCurrentState() {
    currentState--;
    print(currentState);
    update();
  }

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

  resendOtp() async {
    isLoading = true.obs;

    update();
    // var fcm = SharedPref.shared.pref?.getString(PrefKeys.fcmToken);
    final params = {
      "phone": numberController.text,
      "fcm_id": "",
    };
    final res = await HTTPClient.postRequest(APIs.sendOtpReg, params);

    if (res["status"] == true) {
      phone.value = res["mobile"];
      SharedPref.shared.pref?.setString(PrefKeys.otp, res["otp"]);
      SharedPref.shared.pref?.setString(PrefKeys.mobile, res["mobile"]);
      SharedPref.shared.pref?.setString(PrefKeys.token, res["token"]);
      //  increaseCurrentState();
    } else {
      Utils.showFlushBarWithMessage(
        res["errors"][0]["message"],
        Get.context!,
      );
    }
    update();
    isLoading = false.obs;

    update();
  }

  sendRegisterOTP() async {
    if (numberController.text.length < 10 ||
        numberController.text.startsWith('+91')) {
      Utils.showFlushBarWithMessage(
        'Invalid Mobile Number!!!',
        Get.context!,
      );
    } else {
      isLoading = true.obs;

      update();
      // var fcm = SharedPref.shared.pref?.getString(PrefKeys.fcmToken);
      final params = {
        "phone": numberController.text,
        "fcm_id": "",
      };

      final res = await HTTPClient.postRequest(APIs.sendOtpReg, params);

      if (res["status"] == true) {
        phone.value = res["mobile"];
        SharedPref.shared.pref?.setString(PrefKeys.otp, res["otp"]);
        SharedPref.shared.pref?.setString(PrefKeys.mobile, res["mobile"]);
        SharedPref.shared.pref?.setString(PrefKeys.token, res["token"]);
        increaseCurrentState();
      } else {
        Utils.showFlushBarWithMessage(
          res["errors"][0]["message"],
          Get.context!,
        );
      }
      update();
      isLoading = false.obs;

      update();
    }
  }

  String retrieveStringFromControllers(
      List<TextEditingController> otpControllers) {
    List<String> otpValues = [];
    for (TextEditingController controller in otpControllers) {
      otpValues.add(controller.text);
    }

    // Use the otpValues list as needed
    print("OTP String: ${otpValues.join()}");

    return otpValues.join();
  }

  verifyOtp(String enteredotp) async {
    if (enteredotp.isEmpty || enteredotp.length < 6) {
      Utils.showFlushBarWithMessage(
        'Invalid otp!!!',
        Get.context!,
      );
    } else {
      var otpApi = SharedPref.shared.pref?.getString(PrefKeys.otp);
      if (enteredotp == otpApi) {
        increaseCurrentState();
      } else {
        Utils.showFlushBarWithMessage(
          'Invalid otp!!!',
          Get.context!,
        );
      }

      update();
      isLoading = false.obs;

      update();
    }
  }

  verifyPassword() async {
    if (confirmPasswordController.text.isEmpty ||
        confirmPasswordController.text != passwordController.text) {
      Utils.showFlushBarWithMessage(
        'Invalid password!!!',
        Get.context!,
      );
    } else {
      password.value = confirmPasswordController.text;
      increaseCurrentState();

      update();
      isLoading = false.obs;

      update();
    }
  }

  verifyLicence() async {
    if (nameController.text.trim().isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid name!!!',
        Get.context!,
      );
    } else if (driverLicenceController.text.trim().isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid Driving license number!!!',
        Get.context!,
      );
    } else if (dateOfIssueController.text.trim().isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid date of issue!!!',
        Get.context!,
      );
    } else if (expiryDateController.text.trim().isEmpty) {
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
      increaseCurrentState();
      update();
    }
  }

  verifyVehicle() {
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
    } else if (selectedFileVehicle.isNull) {
      Utils.showFlushBarWithMessage(
        'Upload vehile image!!!',
        Get.context!,
      );
    } else {
      vehicle_type.value = typeController.text;
      registeration_number.value = vehicleNumberController.text;
      issue_date.value = dateOfIssueVehileController.text;
      expiration_date.value = expiryDateVehileController.text;
      policy_number.value = policyNumberController.text;
      coverage_date.value = coverageNumberController.text;

      increaseCurrentState();
      update();
    }
  }

  verifyAddress() async {
    if (permanentAddressController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid Address!!!',
        Get.context!,
      );
    } else if (city.value == '') {
      Utils.showFlushBarWithMessage(
        'Invalid city!!!',
        Get.context!,
      );
    } else if (state.value == '') {
      Utils.showFlushBarWithMessage(
        'Invalid state!!!',
        Get.context!,
      );
    } else if (zipCodeController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid pincode!!!',
        Get.context!,
      );
    } else if (country.value == ' ') {
      Utils.showFlushBarWithMessage(
        'Invalid country!!!',
        Get.context!,
      );
    } else {
      address.value = permanentAddressController.text;

      pincode.value = zipCodeController.text;
      increaseCurrentState();
      update();
    }
  }

  verifyBank() async {
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
    } else if (accountTypeController.text.isEmpty ||
        accountNumberController.text
            .toString()
            .trim()
            .toLowerCase()
            .contains("select") ||
        selectAccountType.toString().toLowerCase().contains("select")) {
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
      increaseCurrentState();
      update();
    }
  }

  verifyPersonalDetails() async {
    if (personalNameController.text.toString().trim().isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid  name!!!',
        Get.context!,
      );
    } else if (emailController.text.toString().trim().isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid email!!!',
        Get.context!,
      );
    } else {
      name.value = personalNameController.text;
      email.value = emailController.text;

      signup();
    }
  }

  signup() async {
    var fcm = SharedPref.shared.pref!.getString("FCMToken") ?? "";

    Map data = {
      "name": name.value,
      "email": email.value,
      "phone": phone.value,
      "fcm_id": fcm ?? "",
      "password": password.value,
      "license_number": license_number.value,
      "license_doi": license_doi.value,
      "license_exp_date": license_exp_date.value,
      "license_state": license_state.value,
      "bank_name": bank_name.value,
      "branch_name": branch_name.value,
      "account_type": account_type.value,
      "micr_code": micr_code.value,
      "bank_address": bank_address.value,
      "account_number": account_number.value,
      "ifsc_code": ifsc_code.value,
      "address": address.value,
      "city": city.value,
      "state": state.value,
      "country": country.value,
      "pincode": pincode.value,
      "vehicle_type": vehicle_type.value,
      "registeration_number": registeration_number.value,
      "issue_date": issue_date.value,
      "expiration_date": expiration_date.value,
      "policy_number": policy_number.value,
      "coverage_date": coverage_date.value,
      "seller_code": SellerCodeCtrl.text.toString(),
    };
    final res = await HTTPClient.multipartRequest(APIs.register, data,
        selectedFileLicence!, selectedFileVehicle!, MediaType('image', 'jpeg'));

    if (res["status"] == true) {
      SharedPref.shared.pref?.setString(PrefKeys.token, res["token"]);
      SharedPref.shared.pref?.setString(PrefKeys.isLoggedIn, "1");

      getProfile();
    } else {
      Utils.showFlushBarWithMessage(
        res["errors"][0]["message"],
        Get.context!,
      );
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

      SharedPref.shared.pref
          ?.setString(PrefKeys.userDetails, jsonEncode(res.data[0]));
      Get.offAll(const HomeScreen());
    } else {
      Utils.showFlushBarWithMessage(
        'Something went wrong!!!',
        Get.context!,
      );
    }
  }
}
