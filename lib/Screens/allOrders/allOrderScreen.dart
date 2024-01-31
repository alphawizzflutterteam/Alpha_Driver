import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:work/Provider/allOrdersController.dart';
import 'package:work/Provider/newOrderController.dart';
import 'package:work/Screens/HomeScreen/NewOrder/components/order_card_widget.dart';
import 'package:work/Screens/allOrders/all_order_card_widget.dart';
import 'package:work/helper/CustomWidgets/base_scaffold.dart';
import 'package:work/helper/CustomWidgets/commonappbar.dart';
import 'package:work/helper/CustomWidgets/menu_scaffold.dart';
import 'package:work/utilities/color.dart';

import '../../../helper/app_constant.dart';

class AllOrderScreen extends StatefulWidget {
  final String status;
  const AllOrderScreen({super.key, required this.status});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  final AllOrderController controller = Get.put(AllOrderController());

  @override
  void initState() {
    super.initState();
    callApi();
  }

  callApi() async {
    await controller.getAllOrders(widget.status);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //  callApi();
    final th = Theme.of(context).textTheme;
    return RefreshIndicator(
      color: colors.buttonColor,
      backgroundColor: Colors.white,
      displacement: 40.0,
      strokeWidth: 2.0,
      semanticsLabel: 'Pull to refresh',
      semanticsValue: 'Refresh',
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
        callApi();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: const CommanAppbar(
            appbarTitle: 'All Orders',
            forHome: true,
          ),
          body: Obx(() {
            return controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: controller.list.isEmpty
                        ? const Center(child: Text("No new order found."))
                        : ListView.builder(
                            itemCount: controller.list.length,
                            itemBuilder: (context, index) {
                              var list = controller.list[index];
                              return AllOrderCardWidget(
                                productName: list.productName,
                                orderID: list.orderId.toString(),
                                address:
                                    "${list.shippingAddress.address}, ${list.shippingAddress.address}, ${list.shippingAddress.city}",
                                list: list,
                                controller: controller,
                              );
                            }));
          })),
    );
  }
}
