import 'package:flutter/material.dart';
import 'package:work/Provider/newOrderController.dart';
import 'package:work/Screens/HomeScreen/NewOrder/model/newOrderModel.dart';
import 'package:work/Screens/HomeScreen/NewOrder/new_order_detail.dart';
import 'package:work/helper/CustomWidgets/custom_button.dart';
import 'package:work/helper/app_constant.dart';
import 'package:work/utilities/app_color.dart';

class OrderCardWidget extends StatelessWidget {
  final String productName;
  final String orderID;
  final String address;
  final DatumNewOrder list;
  final NewOrderController controller;
  const OrderCardWidget({
    super.key,
    required this.productName,
    required this.orderID,
    required this.address,
    required this.list,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: appColorBlack,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 130,
                  child: Text(
                    address.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID - ' + orderID,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: appColorBlack,
                      ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewOrderDetail(
                                  id: orderID,
                                  fromAllOrders: false,
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: appThemeColor, // Set your desired button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the radius as needed
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      "View Details",
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: appColorWhite),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
