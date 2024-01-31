import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work/Models/orderDetailModelNew.dart';

import '../../../../helper/app_constant.dart';

class SellerDetail extends StatelessWidget {
  final Shop shop;
  final double lat;
  final double lon;
  const SellerDetail(
      {super.key, required this.shop, required this.lat, required this.lon});

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
    final th = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seller Detail',
            style: th.bodyMedium?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: appColorBlack,
            ),
          ),
          Text(
            shop.name,
            style: th.bodyLarge?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: appColorBlack,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                shop.address,
                style: th.bodyMedium?.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: appColorGrey,
                ),
              ),
              InkWell(
                onTap: () {
                  launchGoogleMaps(lat, lon);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(CupertinoIcons.location_solid),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'View route',
                      style: th.bodyMedium?.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: appColorBlack,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          // Container(
          //   width: 70,
          //   height: 30,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(4),
          //     border: Border.all(color: appPrimaryColor),
          //     color: appPrimaryColor.withOpacity(0.4),
          //   ),
          //   child: Center(
          //     child: Text(
          //       'Delivered',
          //       style: th.bodyMedium?.copyWith(
          //         fontSize: 10,
          //         fontWeight: FontWeight.w600,
          //         color: appPrimaryColor,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
