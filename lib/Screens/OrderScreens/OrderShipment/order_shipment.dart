import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:work/Screens/acceptPayment/acceptPayment.dart';
import 'package:work/helper/CustomWidgets/base_scaffold.dart';

import '../../../Models/order_model.dart';
import '../../../Provider/order_detail_controller.dart';
import '../../../helper/CustomWidgets/bottom_button_widget.dart';
import '../../../helper/app_constant.dart';
import 'compoments/price_details.dart';
import 'compoments/scan_delivery_card.dart';

class OrderShipment extends StatefulWidget {
  final Datuo list;
  final String deliveryTyype;
  final bool isPaid;
  final bool isDelivered;

  const OrderShipment(
      {super.key,
      required this.list,
      required this.deliveryTyype,
      required this.isPaid,
      required this.isDelivered});

  @override
  State<OrderShipment> createState() => _OrderShipmentState();
}

class _OrderShipmentState extends State<OrderShipment> {
  final OrderDetailController orderDetailController =
      Get.put(OrderDetailController());
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callApi();
  }

  Future<void> _selectDate(BuildContext context) async {
    // Check if the context is still valid and mounted
    if (context == null || !mounted) {
      return;
    }
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tomorrow,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      // Set mode to only display the calendar

      selectableDayPredicate: (DateTime date) {
        // Set condition to disable previous days
        return date.isAfter(DateTime.now());
      },
    );

    // Check if the context is still valid and mounted before updating state
    if (context != null && mounted) {
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }

      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      print(formattedDate);

      Map data = {
        "order_id": widget.list.orderId.toString(),
        "expected_delivery_date": formattedDate,
        "cause": "Unable to delivery order"
      };
      orderDetailController.rescheduleOrder(data, context);
    }
  }

  callApi() async {
    await orderDetailController.getAllOrders(widget.list.orderId.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(widget.isPaid.toString());
    var th = Theme.of(context).textTheme;
    return BaseScaffold(
      title: 'Order Shipment',
      bottomSheet: widget.isDelivered
          ? SizedBox(
              height: 0,
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: BottomButtonWidget(
                onPressed1: () {
                  _selectDate(context);
                },
                onPressed2: () {
                  print(widget.isPaid.toString());
                  Get.to(AcceptPaymentMethod(
                    productId: orderDetailController.productId.value,
                    deliveryTpe: widget.deliveryTyype,
                    price: orderDetailController.productname.toString(),
                    orderDetailController: orderDetailController,
                    orderId: widget.list.orderId.toString(),
                    isPaid: widget.isPaid,
                  ));
                },
                buttonText1: 'RESCHUDLE',
                buttonText2: 'CONFIRM',
              ),
            ),
      child: Obx(() {
        return orderDetailController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Container(
                    color: appCardColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.list.customerName,
                          style: th.bodyMedium?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: appColorBlack,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(widget.list.shippingAddress.address,
                            style: th.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: appTextColor,
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
                                      color: apGreyColor,
                                    ),
                                  ),
                                  Text(
                                    widget.list.shippingAddress.phone,
                                    style: th.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: appTextColor,
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
                                      GestureDetector(
                                        onTap: () {
                                          orderDetailController.launchDialer(
                                              widget
                                                  .list.shippingAddress.phone);
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             OrderShipmentAfterScan(
                                          //                 list: list)));
                                        },
                                        child: Text(
                                          'Call',
                                          style: th.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: appColorWhite,
                                          ),
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
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: Text(
                        "ORDER ID - ${orderDetailController.orderId.value}",
                        style: th.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: appTextColor,
                        )),
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
                  Obx(() {
                    return ScanDeliveryDetail(
                      productId: orderDetailController.productId.value,
                      deliveryTpe: widget.deliveryTyype,
                      price: orderDetailController.productname.toString(),
                      list: widget.list,
                      orderDetailController: orderDetailController,
                      isDeliverd: widget.isDelivered,
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
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
                  PriceDetails(
                    price: orderDetailController.priceList.first.itemPrice,
                    discount: orderDetailController.priceList.first.discount,
                    item: '1',
                    deliveryFee:
                        orderDetailController.priceList.first.deliveryFee,
                    tax: orderDetailController.priceList.first.tax,
                    totalPrice: orderDetailController.priceList.first.total,
                  ),
                  SizedBox(
                    height: 150,
                  )
                ],
              );
      }),
    );
  }
}
