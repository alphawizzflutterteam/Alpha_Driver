import 'package:flutter/material.dart';
import 'package:work/helper/app_constant.dart';

class AfterScanWidget extends StatelessWidget {
  const AfterScanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: defaultPadding),
      color: appCardColor,
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AE29726543',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: appColorBlack
            ),),
            Text('Alpha delivery',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: appColorBlack
            ),),
          ],
        ),
      ),
    );
  }
}
