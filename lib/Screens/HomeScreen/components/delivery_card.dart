import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work/Models/person_details.dart';
import 'package:work/Screens/OrderScreens/OrderShipment/order_shipment.dart';
import 'package:work/helper/app_constant.dart';

import '../../../Models/order_model.dart';

class DeliveryCard extends StatelessWidget {
  Datuo list;
  String name;
  String address;
  String orderType;
  int orderCount;
  String deliveryType;

  DeliveryCard({
    super.key,
    required this.name,
    required this.address,
    required this.orderType,
    required this.orderCount,
    required this.list,
    required this.deliveryType,
  });

  launchGoogleMaps(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&dir_action=navigate';
    if (await canLaunch(
      googleUrl,
    )) {
      await launchUrl(Uri.parse(googleUrl),
          mode: LaunchMode.externalApplication);

      // await launch(
      //   googleUrl,
      // );
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    print(list.order_status);
    var th = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        print(list.payment_status.toString().toLowerCase());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderShipment(
                      list: list,
                      deliveryTyype: deliveryType,
                      isPaid: list.payment_status.toString().toLowerCase() ==
                          "paid",
                      isDelivered: list.order_status
                          .toString()
                          .toLowerCase()
                          .contains("delivered"),
                    )));
      },
      child: Card(
        elevation: 0,
        color: appCardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ORDER ID - " + list.orderId.toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: th.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: appTextColor,
                      ),
                    ),
                  ),
                  buildCustom(
                      !list.order_status.toLowerCase().contains("out_for_"),
                      !list.order_status.contains("out_for_")
                          ? "Completed"
                          : "Pending"),
                  // Container(
                  //   padding: const EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //     borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //     color: buttonColor.withOpacity(0.2),
                  //   ),
                  //   child: Text(
                  //     list.order_status,
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(address,
                  style: th.bodyMedium?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: appTextColor,
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(orderType,
                          style: th.bodyMedium?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: appButtonUnSelected,
                          )),
                      Text(orderCount.toString(),
                          style: th.bodyMedium?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: appTextColor,
                          )),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      launchGoogleMaps(
                          double.parse(list.shippingAddress.latitude),
                          double.parse(list.shippingAddress.longitude));
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/Location.svg',
                          color: appPrimaryColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('View Route',
                            style: th.bodyMedium?.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: appPrimaryColor,
                            )),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCustom(bool isSuccess, String status) {
  Color buttonColor = isSuccess ? Colors.green : Colors.red;

  return Container(
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      color: buttonColor.withOpacity(0.9),
    ),
    child: Text(
      status,
      style: const TextStyle(color: Colors.white),
    ),
  );
}
