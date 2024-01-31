import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:work/Models/profileModel.dart';
import 'package:work/Screens/HomeScreen/NotificationScreen/notifiaction_screen.dart';
import 'package:work/helper/CustomWidgets/comman_header.dart';
import 'package:work/helper/CustomWidgets/drawer_home.dart';
import 'package:work/helper/app_constant.dart';
import 'package:work/utilities/app_color.dart';
import 'package:work/utilities/color.dart';
import 'package:work/utilities/shared_pref..dart';
import 'package:work/utilities/sizedBox.dart';
import '../../Models/person_details.dart';
import '../../Provider/current_order_controller.dart';
import '../../helper/CustomWidgets/default_button.dart';
import '../OrderScreens/QrScreen/qr_screen.dart';
import 'components/delivery_card.dart';
import 'components/delivery_status_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CurrentOrderController currentOrderController =
      Get.put(CurrentOrderController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  void initState() {
    super.initState();
    currentOrderController.initialize();
  }

  int index = 1;
  @override
  Widget build(BuildContext context) {
    var model =
        jsonDecode(SharedPref.shared.pref!.getString(PrefKeys.userDetails)!);

    Datum user = Datum.fromJson(model);
    SharedPref.shared.pref?.setString(PrefKeys.image, user.image);

    var th = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      color: colors.buttonColor,
      backgroundColor: Colors.white,
      displacement: 40.0,
      strokeWidth: 2.0,
      semanticsLabel: 'Pull to refresh',
      semanticsValue: 'Refresh',
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
        currentOrderController.callApi();
        setState(() {});
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const HomeDrawer(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              openDrawer();
            },
            child: Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                'assets/icons/menu.svg',
              ),
            ),
          ),
          title: const Text(
            "Work Order",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('assets/icons/notfication.svg',
                      color: appColorWhite),
                )),
          ],
          flexibleSpace: Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.transparent
                : colors.buttonColor,
            child: const Stack(
              children: [
                ProfileHeader(),
              ],
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: ListView(
            children: [
              DeliveryStatusCard(
                failedOrder: user.pauseDelivery,
                deliverOrder: user.completedDelivery,
                pendingOrder: user.pendingDelivery,
              ),
              Obx(() {
                return ButtonsWidgets(
                  index: index,
                  buttonFirstText:
                      'All Delivery (${currentOrderController.allDeliverCount})',
                  buttonSecondText:
                      'Alpha Delivery (${currentOrderController.alphaDeliverCount})',
                  onPressed1: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  onPressed2: () {
                    setState(() {
                      index = 2;
                    });
                  },
                );
              }),
              const SizedBox(
                height: 10,
              ),
              if (index == 1)
                Obx(() {
                  return SizedBox(
                    height: screenHeight * 0.63,
                    child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: currentOrderController.orderDataList.length,
                        itemBuilder: (context, index) {
                          var list =
                              currentOrderController.orderDataList[index];
                          // String orderType='';
                          // if(list.shippingAddress.isBilling==0){
                          //   orderType='Delivery';
                          // }
                          return DeliveryCard(
                            name: list.customerName,
                            orderType: 'Delivery',
                            address:
                                "${list.shippingAddress.address} ${list.shippingAddress.address1} ${list.shippingAddress.zip}",
                            orderCount: list.totalDelivery,
                            list: list,
                            deliveryType: 'Delivery',
                          );
                        }),
                  );
                }),
              if (index == 2)
                Obx(() {
                  return SizedBox(
                    height: screenHeight * 0.63,
                    child: ListView.builder(
                        itemCount:
                            currentOrderController.alphaOrderDataList.length,
                        itemBuilder: (context, index) {
                          var list =
                              currentOrderController.alphaOrderDataList[index];
                          // String orderType='';
                          // if(list.shippingAddress.isBilling==0){
                          //   orderType='Delivery';
                          // }
                          return DeliveryCard(
                            name: list.customerName,
                            orderType: 'Delivery',
                            address:
                                "${list.shippingAddress.address} ${list.shippingAddress.address1} ${list.shippingAddress.zip}",
                            orderCount: list.totalDelivery,
                            list: list,
                            deliveryType: 'Alpha Delivery',
                          );
                        }),
                  );
                }),
            ],
          ),
        ),
        // floatingActionButton: Container(
        //   padding: const EdgeInsets.all(8),
        //   decoration:
        //       BoxDecoration(shape: BoxShape.circle, color: appPrimaryColor),
        //   child: IconButton(
        //     icon: SvgPicture.asset(
        //       'assets/icons/qr.svg',
        //     ),
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => QrScannerScreen(
        //                     list: currentOrderController.orderDataList[index],
        //                   )));
        //     },
        //   ),
        // ),
      ),
    );
  }
}
