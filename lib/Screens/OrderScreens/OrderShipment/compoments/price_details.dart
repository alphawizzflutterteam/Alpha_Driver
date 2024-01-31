import 'package:flutter/material.dart';

import '../../../../helper/app_constant.dart';

class PriceDetails extends StatelessWidget {
  final String price;
  final String discount;
  final String item;
  final String deliveryFee;
  final String tax;
  final String totalPrice;
  const PriceDetails(
      {super.key,
      required this.price,
      required this.discount,
      required this.item,
      required this.deliveryFee,
      required this.tax,
      required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    var th = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'MRP ' + '(' + item + ' item)',
              style: th.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: apGreyColor,
              ),
            ),
            Text(
              price,
              style: th.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: appTextColor,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delivery Fees ',
              style: th.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: apGreyColor,
              ),
            ),
            Text(
              deliveryFee,
              style: th.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: appTextColor,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tax ',
              style: th.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: apGreyColor,
              ),
            ),
            Text(
              tax,
              style: th.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: appTextColor,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Discount ',
              style: th.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: apGreyColor,
              ),
            ),
            Text(
              "- " + discount,
              style: th.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: appColorBlack,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
          height: 0.5,
          color: appDividerColor,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Amount ',
              style: th.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: appColorBlack,
              ),
            ),
            Text(
              totalPrice,
              style: th.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: appPrimaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
          height: 0.5,
          color: appDividerColor,
        ),
      ]),
    );
  }
}
