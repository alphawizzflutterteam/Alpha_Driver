import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:work/Models/profileModel.dart';
import 'package:work/Provider/order_detail_controller.dart';
import 'package:work/Provider/walletController.dart';
import 'package:work/helper/CustomWidgets/custom_button.dart';
import 'package:work/utilities/shared_pref..dart';

import '../../../helper/app_constant.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var model =
        jsonDecode(SharedPref.shared.pref!.getString(PrefKeys.userDetails)!);

    Datum user = Datum.fromJson(model);
    final th = Theme.of(context).textTheme;
    return Container(
      height: MediaQuery.of(context).size.height * 0.37,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/color_wallet.svg',
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/cash.svg',
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                user.currentBalance,
                style: th.bodyLarge?.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: appTextColor),
              ),
            ],
          ),
          Text(
            'Current Balance',
            style: th.bodyMedium?.copyWith(
                fontSize: 12, fontWeight: FontWeight.w700, color: appColorGrey),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButtonWidget(
              text: 'Request for Withdraw',
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomBottomSheet();
                  },
                );
              })
        ],
      ),
    );
  }
}

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final WalletController controller = Get.put(WalletController());
    var model =
        jsonDecode(SharedPref.shared.pref!.getString(PrefKeys.userDetails)!);

    Datum user = Datum.fromJson(model);
    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Enter Amount',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Withdrawable Balance : ',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        user.withdrawableBalance,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter amount',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButtonWidget(
                      text: 'Request',
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Get.back();

                        String enteredAmount = _amountController.text;
                        print('Requested Amount: $enteredAmount');

                        Map map = {"amount": enteredAmount};

                        controller.withdrawMoney(map, context);
                      }),
                  const SizedBox(height: 20),
                ],
              ),
            )));
  }
}
