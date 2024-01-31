import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

import '../../../../helper/app_constant.dart';

class OrderDeliveryStatus extends StatelessWidget {
  const OrderDeliveryStatus({super.key});

  @override
  Widget build(BuildContext context) {
    int activeStep = 1;
    final th= Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Arriving Wednesday',style: th.bodyMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: appPrimaryColor,
          ),),


          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15),
                clipBehavior: Clip.none,
                child: EasyStepper(
                  direction: Axis.vertical,
                  activeStep: activeStep,
                  lineStyle: const LineStyle(
                    lineLength: 62,
                    lineSpace: 0,
                    lineType: LineType.normal,
                    defaultLineColor: Colors.black,
                    finishedLineColor: Colors.orange,
                    lineThickness: 1.5,
                  ),
                  activeStepTextColor: Colors.transparent,
                  finishedStepTextColor: Colors.transparent,
                  internalPadding: 0,
                  showTitle: false,
                  showLoadingAnimation: false,
                  stepRadius: 14,
                  showStepBorder: false,
                  steps: [
                    EasyStep(
                      customStep:  CircleAvatar(
                        radius: 18,
                        backgroundColor: activeStep >= 0 ? Colors.white : Colors.white,
                        child: Icon(Icons.gpp_good,color: activeStep >= 0 ? Colors.orange : Colors.white,),
                      ),
                      // title: 'Waiting',
                    ),
                    EasyStep(
                      customStep: CircleAvatar(
                        radius: 18,
                        backgroundColor: activeStep >= 1 ? Colors.transparent : Colors.white,
                        child: Icon(Icons.gpp_good,color: activeStep >= 1 ? Colors.orange : Colors.black,),
                      ),
                      // title: 'Order Received',
                      topTitle: true,
                    ),
                    EasyStep(
                      customStep: CircleAvatar(
                        radius: 14,
                        child: Icon(Icons.gpp_good,color: activeStep >= 2 ? Colors.orange : Colors.black,),
                        backgroundColor:
                        activeStep >= 2 ? Colors.transparent : Colors.white,
                      ),
                      // title: 'Preparing',
                    ),
                    EasyStep(
                      customStep: CircleAvatar(
                        radius: 14,
                        child: Icon(Icons.gpp_good,color: activeStep >= 3 ? Colors.orange : Colors.black,),
                        backgroundColor:
                        activeStep >= 3 ? Colors.transparent : Colors.white,
                      ),
                      // title: 'On Way',
                      // topTitle: true,
                    ),
                    // EasyStep(
                    //   customStep: CircleAvatar(
                    //     radius: 14,
                    //     child: Icon(Icons.gpp_good),
                    //     backgroundColor:
                    //     activeStep >= 4 ? Colors.orange : Colors.white,
                    //   ),
                    //   // title: 'Delivered',
                    // ),
                  ],
                  onStepReached: (index) =>{},
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ordered Saturday, 6 Oct',style: th.bodyMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: appColorBlack,
                    ),),
                    SizedBox(height: 80,),
                    Text('Shipped Sunday, 7 Oct',style: th.bodyMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: appColorBlack,
                    ),),
                    SizedBox(height: 85,),

                    Text('Out for delivery',style: th.bodyMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: appColorGrey,
                    ),),
                    SizedBox(height: 85,),

                    Text('Arriving Wednesday',style: th.bodyMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: appColorGrey,
                    ),),

                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
