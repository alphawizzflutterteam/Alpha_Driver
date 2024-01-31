import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work/Screens/HomeScreen/home_screen.dart';
import 'package:work/Screens/WalletScreen/model/transactionModel.dart';
import 'package:work/Screens/WalletScreen/model/withdrawModel.dart';
import 'package:work/Screens/WalletScreen/wallet_screen.dart';
import 'package:work/utilities/api_manager/apis.dart';
import 'package:work/utilities/shared_pref..dart';
import 'package:work/utilities/utils.dart';

import '../utilities/api_manager/http_client.dart';

class WalletController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<WithdrawModel>? withdrawmodel;
  Rx<TransactionModel>? model;

  withdrawMoney(dynamic map, BuildContext context) async {
    isLoading = true.obs;
    update();
    final res = await HTTPClient.postRequest(APIs.withdrawMoney, map);
    isLoading = false.obs;
    update();

    Utils.showFlushBarWithMessage(res["message"], context);
  }

  getProfile() async {
    final res = await HTTPClient.getProfileResponse(APIs.profile);

    if (res.status == true) {
      SharedPref.shared.pref?.setString(PrefKeys.name, res.data[0].fName);

      SharedPref.shared.pref
          ?.setString(PrefKeys.userDetails, jsonEncode(res.data[0]));
    } else {
      Utils.showFlushBarWithMessage(
        'Something went wrong!!!',
        Get.context!,
      );
    }
  }

  getWalletHistory() async {
    isLoading = true.obs;
    update();

    final res = await HTTPClient.getWithdrawList(APIs.withdrawRequests);
    withdrawmodel = res.obs;

    isLoading = false.obs;
    update();
    getProfile();
  }

  getPamentList() async {
    isLoading = true.obs;
    update();

    final res = await HTTPClient.getTransactionList(APIs.transactionHistory);
    model = res.obs;

    isLoading = false.obs;
    update();
  }
}
