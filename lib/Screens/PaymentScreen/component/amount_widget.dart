import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work/Screens/WalletScreen/components/balance_widget.dart';
import 'package:work/helper/CustomWidgets/custom_button.dart';
import 'package:work/utilities/sizedBox.dart';

import '../../../helper/app_constant.dart';

class AmountWidget extends StatelessWidget {
  final String amount;
  final String delivery;
  final bool forWallet;
  const AmountWidget(
      {super.key,
      required this.amount,
      required this.delivery,
      required this.forWallet});

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return Container(
      color: appCardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              SvgPicture.asset(
                'assets/icons/Wallet.svg',
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                forWallet ? "Wallet Balace" : 'Total Amount',
                style: th.bodyMedium?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: appColorBlack,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                amount.toString(),
                style: th.bodyMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: appColorBlack,
                ),
              ),
            ],
          ),
          Container(
            width: 1,
            margin: EdgeInsets.symmetric(vertical: 30),
            height: 80,
            color: appColorGrey,
          ),
          Column(
            children: [
              SvgPicture.asset(
                'assets/icons/delivery.svg',
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                forWallet ? "Cash in hand" : 'Total Delivery',
                style: th.bodyMedium?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: appColorBlack,
                ),
              ),
              Text(
                delivery.toString(),
                style: th.bodyMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: appColorBlack,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
