import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work/Screens/HomeScreen/NotificationScreen/model/notificationsModel.dart';

import '../../../../helper/app_constant.dart';

class NotificationCard extends StatelessWidget {
  final Notifications model;

  const NotificationCard({
    super.key,
    required this.model,
  });

  String convertTimestampToFormattedDate(String timestamp) {
    // Parse the timestamp string into a DateTime object
    DateTime dateTime = DateTime.parse(timestamp);

    // Format the DateTime object as "dd Month name yyyy"
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      model.description,
                      maxLines: 2,
                      style: th.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: appColorBlack,
                          fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Text(convertTimestampToFormattedDate(model.updatedAt),
                  style: th.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: appColorBlack,
                  )),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Divider(
            height: 0.5,
            color: appColorBlack,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
