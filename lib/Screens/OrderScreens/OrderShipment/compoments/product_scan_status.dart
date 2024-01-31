import 'package:flutter/material.dart';
import 'package:work/helper/app_constant.dart';

class ProductScanStatus extends StatelessWidget {
  final String scanStatus;
  const ProductScanStatus({super.key, required this.scanStatus});

  @override
  Widget build(BuildContext context) {
    if(scanStatus=='scanned') {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultPadding,vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: appPrimaryColor.withOpacity(0.2),
        ),
        padding: const EdgeInsets.all(5),

        child: Row(
        children: [
          Icon(Icons.gpp_good,color: appPrimaryColor,),
          SizedBox(width: 5,),

          Text('Your product scanned',style: Theme.of(context).textTheme.bodyMedium?.
          copyWith(
            fontWeight: FontWeight.w700,color: appPrimaryColor,
          ),),
        ],
      ),
    );
    }
    else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultPadding,vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: appOrderPendingColor.withOpacity(0.2),
        ),
        padding: const EdgeInsets.all(5),

        child: Row(
        children: [
          Icon(Icons.gpp_good,color: appOrderPendingColor,),
          SizedBox(width: 5,),
          Text('Your product not scanned',style: Theme.of(context).textTheme.bodyMedium?.
          copyWith(
            fontWeight: FontWeight.w700,color: appOrderPendingColor,
          ),),
        ],
      ),
    );
    }
  }
}
