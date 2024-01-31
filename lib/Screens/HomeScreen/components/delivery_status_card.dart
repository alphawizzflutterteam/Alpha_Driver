import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work/Screens/allOrders/allOrderScreen.dart';
import 'package:work/helper/app_constant.dart';

class DeliveryStatusCard extends StatelessWidget {
  String failedOrder;
  String deliverOrder;
  String pendingOrder;
  DeliveryStatusCard(
      {super.key,
      required this.failedOrder,
      required this.deliverOrder,
      required this.pendingOrder});

  @override
  Widget build(BuildContext context) {
    var th = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      color: appCardColor,
      margin: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: defaultPadding, horizontal: defaultPadding * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(AllOrderScreen(
                  status: 'shipped,out_for_delivery',
                ));
              },
              child: Column(
                children: [
                  Text(
                    pendingOrder ?? '',
                    style: th.bodyMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: appOrderPendingColor),
                  ),
                  Text(
                    'Pending',
                    style: th.bodySmall?.copyWith(
                        color: appOrderPendingColor,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(AllOrderScreen(
                  status: 'failed',
                ));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                height: 35,
                width: 1,
                color: Colors.grey,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(AllOrderScreen(
                  status: 'failed',
                ));
              },
              child: Column(
                children: [
                  Text(
                    failedOrder ?? '',
                    style: th.bodyMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: appOrderFailedColor),
                  ),
                  Text(
                    'Failed',
                    style: th.bodySmall?.copyWith(
                        color: appOrderFailedColor,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(AllOrderScreen(
                  status: 'delivered',
                ));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                height: 35,
                width: 1,
                color: Colors.grey,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(AllOrderScreen(
                  status: 'delivered',
                ));
              },
              child: Column(
                children: [
                  Text(
                    deliverOrder,
                    style: th.bodyMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: appOrderDeliveredColor),
                  ),
                  Text(
                    'Delivered',
                    style: th.bodySmall?.copyWith(
                        color: appOrderDeliveredColor,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
