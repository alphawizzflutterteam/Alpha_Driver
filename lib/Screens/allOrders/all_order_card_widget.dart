import 'package:flutter/material.dart';
import 'package:work/Provider/allOrdersController.dart';
import 'package:work/Provider/newOrderController.dart';
import 'package:work/Screens/HomeScreen/NewOrder/model/newOrderModel.dart';
import 'package:work/Screens/HomeScreen/NewOrder/new_order_detail.dart';
import 'package:work/helper/CustomWidgets/custom_button.dart';
import 'package:work/helper/app_constant.dart';
import 'package:work/utilities/app_color.dart';

class AllOrderCardWidget extends StatelessWidget {
  final String productName;
  final String orderID;
  final String address;
  final DatumNewOrder list;
  final AllOrderController controller;
  const AllOrderCardWidget({
    super.key,
    required this.productName,
    required this.orderID,
    required this.address,
    required this.list,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewOrderDetail(
                      id: orderID,
                      fromAllOrders: true,
                    )));
      },
      child: Card(
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
                                    fromAllOrders: true,
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: list.orderStatus != "failed"
                          ? appThemeColor
                          : Colors.red, // Set your desired button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Adjust the radius as needed
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: SizedBox(
                        width: 80,
                        child: Center(
                          child: Text(
                            list.orderStatus.toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12.0,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                                color: appColorWhite),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
