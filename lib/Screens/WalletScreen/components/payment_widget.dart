import 'package:flutter/material.dart';
import 'package:work/helper/app_constant.dart';

class PaymentWidget extends StatelessWidget {
  final String paymentType;
  final String paymentStatus;
  final String paymentDate;
  final String amount;
  const PaymentWidget(
      {super.key,
      required this.paymentType,
      required this.paymentStatus,
      required this.paymentDate,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              paymentType,
              style: th.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: appColorBlack),
            ),
            Text(
              paymentDate,
              style: th.bodyMedium?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: appColorGrey),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              amount.toString(),
              style: th.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: appColorBlack),
            ),
            Container(
              height: 20,
              width: 70,
              decoration: BoxDecoration(
                color: paymentStatus == 'Accepted'
                    ? appAcceptColor
                    : appCancelColor,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Center(
                child: Text(
                  paymentStatus,
                  style: th.bodyMedium?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: paymentStatus == 'Accepted'
                        ? appPrimaryColor
                        : appOrderPendingColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Divider(
          height: 1,
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
