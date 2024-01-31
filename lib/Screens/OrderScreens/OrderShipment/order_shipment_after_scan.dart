import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:work/Screens/OrderScreens/OrderShipment/compoments/after_scan_card.dart';
import 'package:work/Screens/OrderScreens/OrderShipment/compoments/product_scan_status.dart';
import 'package:work/helper/CustomWidgets/base_scaffold.dart';

import '../../../Models/order_model.dart';
import '../../../Models/person_details.dart';
import '../../../helper/CustomWidgets/bottom_button_widget.dart';
import '../../../helper/app_constant.dart';
import 'compoments/price_details.dart';
import 'compoments/scan_delivery_card.dart';

class OrderShipmentAfterScan extends StatelessWidget {
  Datuo list;
  OrderShipmentAfterScan({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    var th = Theme.of(context).textTheme;
    return BaseScaffold(
        title: 'Order Shipment  ',
      bottomSheet: BottomButtonWidget(
        isScan: true,
        onPressed1: () {},
        onPressed2: () {},
        buttonText1: 'RESCHUDLE',
        buttonText2: 'CONFIRM',
      ),
      child: ListView(
        children: [
          Container(
            color: appCardColor,
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  list.customerName,
                  style: th.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: appColorBlack,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(list.shippingAddress.address,
                    style: th.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: appColorBlack,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone ',
                            style: th.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: appColorBlack,
                            ),
                          ),
                          Text(
                            list.shippingAddress.phone,
                            style: th.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: appColorBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: appPrimaryColor),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.call,
                                size: 18,
                                color: appColorWhite,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Call',
                                style: th.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: appColorWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Text(
              'Scan and Delivery Details ',
              style: th.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: appColorBlack,
              ),
            ),
          ),
          AfterScanWidget(),
          const SizedBox(
            height: 20,
          ),
          ProductScanStatus(scanStatus: 'scanned'),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(
              'Price Details ',
              style: th.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: appColorBlack,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const PriceDetails(
            price: '120',
            discount: '80',
            item: '1',
            deliveryFee: '0',
            tax: "",
            totalPrice: '',
          ),
        ],
      ),
    );
  }
}
