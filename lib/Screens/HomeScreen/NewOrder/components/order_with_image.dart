import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../helper/app_constant.dart';

class OrderWithImage extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String amount;
  const OrderWithImage(
      {super.key,
      required this.productName,
      required this.amount,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            height: 60,
            errorWidget: (context, url, error) {
              return Image.asset(
                "assets/images/default-img.png",
                height: 60,
              );
            },
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  productName,
                  style: th.bodyMedium?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: appColorBlack,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                amount.toString(),
                style: th.bodyMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: appPrimaryColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
