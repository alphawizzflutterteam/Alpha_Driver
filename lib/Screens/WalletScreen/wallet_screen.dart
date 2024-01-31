import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:work/Models/profileModel.dart';
import 'package:work/Provider/walletController.dart';
import 'package:work/Screens/PaymentScreen/component/amount_widget.dart';
import 'package:work/Screens/WalletScreen/components/balance_widget.dart';
import 'package:work/Screens/WalletScreen/components/payment_widget.dart';
import 'package:work/Screens/WalletScreen/wallet_history.dart';
import 'package:work/helper/CustomWidgets/base_scaffold.dart';
import 'package:work/helper/CustomWidgets/commonappbar.dart';
import 'package:work/helper/app_constant.dart';
import 'package:work/utilities/color.dart';
import 'package:work/utilities/shared_pref..dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final WalletController controller = WalletController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callApi();
  }

  String formatDaate(String dateString) {
    // Parse the date string
    DateTime dateTime = DateTime.parse(dateString);

    // Format the date
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  callApi() async {
    await controller.getWalletHistory();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    var model =
        jsonDecode(SharedPref.shared.pref!.getString(PrefKeys.userDetails)!);

    Datum user = Datum.fromJson(model);
    return RefreshIndicator(
      color: colors.buttonColor,
      backgroundColor: Colors.white,
      displacement: 40.0,
      strokeWidth: 2.0,
      semanticsLabel: 'Pull to refresh',
      semanticsValue: 'Refresh',
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
        callApi();
        setState(() {});
      },
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(defaultPadding * 1.2),
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomBottomSheet();
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                // primary: enable
                //     ? appPrimaryColor
                //     : Colors.grey, // Set your desired button color
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Adjust the radius as needed
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Withdraw",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: appColorWhite),
                ),
              ),
            ),
          ),
          appBar: const CommanAppbar(
            appbarTitle: 'Wallet',
            forHome: false,
          ),
          body: Obx(() {
            return controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      //  const BalanceWidget(),
                      AmountWidget(
                        amount: user.currentBalance,
                        delivery: user.cashInHand,
                        forWallet: true,
                      ),

                      controller.withdrawmodel!.value.withdraws.isEmpty
                          ? const Center(
                              child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Text("No Record found."),
                              ],
                            ))
                          : Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Wallet History',
                                    style: th.bodyMedium?.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: appColorBlack),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WalletHistoryScreen(
                                                    list: controller
                                                        .withdrawmodel!
                                                        .value
                                                        .withdraws,
                                                  )));
                                    },
                                    child: Text(
                                      'View all',
                                      style: th.bodyMedium?.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: appPrimaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      for (int i = 0;
                          i < controller.withdrawmodel!.value.withdraws.length;
                          i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          child: PaymentWidget(
                              paymentType: "Withdraw",
                              paymentStatus: controller
                                  .withdrawmodel!.value.withdraws[i].approved,
                              paymentDate: formatDaate(controller
                                  .withdrawmodel!.value.withdraws[i].updatedAt),
                              amount: controller
                                  .withdrawmodel!.value.withdraws[i].amount
                                  .toString()),
                        ),
                    ],
                  );
          })),
    );
  }
}
