import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work/Screens/HomeScreen/home_screen.dart';
import 'package:work/Screens/ProfileScreen/editProfiePages/edit_passsword.dart';
import 'package:work/Screens/SinginScreens/Verification/VerifyByNumber/otp_verify_by_number.dart';
import 'package:work/utilities/api_manager/apis.dart';
import 'package:work/utilities/api_manager/http_client.dart';
import 'package:work/utilities/shared_pref..dart';
import 'package:work/utilities/utils.dart';

class LoginController extends GetxController {
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;
  RxString otp = "".obs;

  sendOTP(bool forLogin) async {
    if (mobileController.text.length < 10 ||
        mobileController.text.startsWith('+91')) {
      // Utils.showFlushBarWithMessage(
      //   'Invalid Mobile Number!!!',
      //   Get.context!,
      // );
    } else {
      isLoading = true.obs;

      update();
      var fcm = SharedPref.shared.pref!.getString("FCMToken");
      // var fcm = SharedPref.shared.pref?.getString(PrefKeys.fcmToken);
      final params = {
        "phone": mobileController.text,
        "fcm_id": fcm ?? "",
      };

      final res = await HTTPClient.postRequest(APIs.sendOtp, params);

      if (res["status"] == true) {
        SharedPref.shared.pref?.setString(PrefKeys.otp, res["otp"]);
        SharedPref.shared.pref
            ?.setString(PrefKeys.mobile, mobileController.text);

        SharedPref.shared.pref?.setString(PrefKeys.token, res["token"]);

        Get.to(OtpVerifyByNumber(
          isComingForLogin: forLogin,
        ));
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

  verifyOtp(String enteredotp, bool forLogin) async {
    if (enteredotp.isEmpty || enteredotp.length < 6) {
      Utils.showFlushBarWithMessage(
        'Invalid otp!!!',
        Get.context!,
      );
    } else {
      var otpApi = SharedPref.shared.pref?.getString(PrefKeys.otp);
      if (enteredotp == otpApi) {
        SharedPref.shared.pref?.setString(PrefKeys.isLoggedIn, "1");

        if (forLogin) {
          getProfile();
        } else {
          Get.to(EditConfirmPassword(
            forLogin: forLogin,
          ));
        }
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

  loginMail(String email) async {
    if (passwordController.text.isEmpty) {
      Utils.showFlushBarWithMessage(
        'Invalid Password!!!',
        Get.context!,
      );
    } else {}
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    if (!emailValid) {
      Utils.showFlushBarWithMessage(
        'Invalid Email Address!!!',
        Get.context!,
      );
    } else {
      isLoading = true.obs;

      update();

      var fcm = SharedPref.shared.pref!.getString("FCMToken");
      final params = {
        "phone": emailController.text,
        "password": passwordController.text,
        "fcm_id": fcm ?? "",
      };

      final res = await HTTPClient.postRequest(APIs.loginMail, params);

      if (res["status"] == true) {
        SharedPref.shared.pref
            ?.setString(PrefKeys.mobile, mobileController.text);
        SharedPref.shared.pref?.setString(PrefKeys.token, res["token"]);
        getProfile();
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
}
