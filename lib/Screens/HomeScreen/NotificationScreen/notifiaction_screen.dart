import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work/Screens/HomeScreen/NotificationScreen/controller/notificationsController.dart';

import '../../../helper/app_constant.dart';
import 'components/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationsController controller = Get.put(NotificationsController());
  @override
  void initState() {
    super.initState();
    callApi();
  }

  callApi() async {
    await controller.getNotifiHistory();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appPrimaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: appColorWhite,
            )),
        title: Center(
          child: Text(
            'Notification ',
            style: th.bodyLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: appColorWhite),
          ),
        ),
      ),
      body: controller.isLoading.value
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: controller.noti.length,
              itemBuilder: (context, index) {
                return NotificationCard(
                  model: controller.noti[index],
                );
              }),
    );
  }
}
