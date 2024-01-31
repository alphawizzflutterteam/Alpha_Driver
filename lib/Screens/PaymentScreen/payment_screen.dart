import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:work/Provider/walletController.dart';
import 'package:work/Screens/PaymentScreen/component/amount_widget.dart';
import 'package:work/helper/CustomWidgets/base_scaffold.dart';
import 'package:work/helper/CustomWidgets/commonappbar.dart';
import 'package:work/utilities/color.dart';

import '../../helper/app_constant.dart';
import '../WalletScreen/components/payment_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final WalletController controller = WalletController();

  @override
  void initState() {
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
    await controller.getPamentList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return Obx(() {
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
            appBar: const CommanAppbar(
              appbarTitle: 'Payment',
              forHome: false,
            ),
            body: controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      AmountWidget(
                        amount: controller.model!.value.totalAmount,
                        delivery: controller.model!.value.totalOrders,
                        forWallet: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Scan and delivery detail',
                              style: th.bodyMedium?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: appColorBlack,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            for (int i = 0;
                                i < controller.model!.value.data.length;
                                i++)
                              PaymentWidget(
                                  paymentType: controller
                                      .model!.value.data[i].transactionType,
                                  paymentStatus: 'Accepted',
                                  paymentDate: formatDaate(controller
                                      .model!.value.data[i].updatedAt),
                                  amount: controller.model!.value.data[i].debit
                                              .toString() ==
                                          "0"
                                      ? controller.model!.value.data[i].credit
                                          .toString()
                                      : controller.model!.value.data[i].debit
                                          .toString()),
                          ],
                        ),
                      ),
                    ],
                  )),
      );
    });
  }
}
