import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work/Screens/WalletScreen/components/payment_widget.dart';
import 'package:work/Screens/WalletScreen/model/withdrawModel.dart';
import 'package:work/helper/CustomWidgets/base_scaffold.dart';
import 'package:work/helper/CustomWidgets/commonappbar.dart';
import 'package:work/helper/app_constant.dart';

class WalletHistoryScreen extends StatelessWidget {
  final List<Withdraw> list;
  const WalletHistoryScreen({super.key, required this.list});

  String formatDaate(String dateString) {
    // Parse the date string
    DateTime dateTime = DateTime.parse(dateString);

    // Format the date
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommanAppbar(
          appbarTitle: 'Wallet History',
          forHome: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              for (int i = 0; i < list.length; i++)
                PaymentWidget(
                    paymentType: "Withdraw",
                    paymentStatus: list[i].approved,
                    paymentDate: formatDaate(list[i].updatedAt),
                    amount: list[i].amount.toString()),
            ],
          ),
        ));
  }
}
