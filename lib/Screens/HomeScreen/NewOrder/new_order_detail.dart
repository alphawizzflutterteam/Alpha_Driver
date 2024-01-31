import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work/Provider/order_detail_controller.dart';
import 'package:work/Screens/HomeScreen/NewOrder/components/order_delivery_status.dart';
import 'package:work/Screens/HomeScreen/NewOrder/components/order_with_image.dart';
import 'package:work/Screens/HomeScreen/NewOrder/components/pickup_address.dart';
import 'package:work/helper/CustomWidgets/base_scaffold.dart';
import 'package:work/helper/CustomWidgets/custom_button.dart';
import 'package:work/helper/app_constant.dart';

import '../../OrderScreens/OrderShipment/compoments/price_details.dart';
import 'components/seller_detail.dart';

class NewOrderDetail extends StatefulWidget {
  final String id;
  final bool fromAllOrders;
  const NewOrderDetail(
      {super.key, required this.id, required this.fromAllOrders});

  @override
  State<NewOrderDetail> createState() => _NewOrderDetailState();
}

class _NewOrderDetailState extends State<NewOrderDetail> {
  final OrderDetailController controller = OrderDetailController();

  @override
  void initState() {
    super.initState();
    callApi();
  }

  callApi() async {
    await controller.getOrderDetails(widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return Obx(() {
      return BaseScaffold(
        title: 'Order Detail',
        child: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SellerDetail(
                    shop: controller.orderModdel!.value.data.detail[0].shop,
                    lat: double.parse(controller.orderModdel!.value.data
                                .shippingAddress.latitude ==
                            ""
                        ? "0.0"
                        : controller
                            .orderModdel!.value.data.shippingAddress.latitude),
                    lon: double.parse(controller.orderModdel!.value.data
                                .shippingAddress.longitude ==
                            ""
                        ? "0.0"
                        : controller
                            .orderModdel!.value.data.shippingAddress.longitude),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Color(0xffC3C5DD),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(
                      'Order ID - ${controller.orderModdel!.value.data.orderId}',
                      style: th.bodyMedium?.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: appColorBlack,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OrderWithImage(
                    productName:
                        controller.orderModdel!.value.data.detail[0].name,
                    amount: controller
                        .orderModdel!.value.data.detail[0].specialPrice,
                    imageUrl:
                        controller.orderModdel!.value.data.detail[0].thumbnail,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PriceDetails(
                    price:
                        controller.orderModdel!.value.data.priceDetail.subtotal,
                    discount:
                        controller.orderModdel!.value.data.priceDetail.discount,
                    item: '1',
                    deliveryFee: controller
                        .orderModdel!.value.data.priceDetail.deliveryFee,
                    tax: controller.orderModdel!.value.data.priceDetail.tax,
                    totalPrice:
                        controller.orderModdel!.value.data.priceDetail.total,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PickUpAddress(
                      localaddress: controller
                              .orderModdel!.value.data.shippingAddress.address +
                          ", " +
                          controller
                              .orderModdel!.value.data.shippingAddress.address1,
                      name: controller.orderModdel!.value.data.shippingAddress
                          .contactPersonName,
                      state: controller
                          .orderModdel!.value.data.shippingAddress.state,
                      zipCode: controller
                          .orderModdel!.value.data.shippingAddress.zip,
                      phone: controller
                          .orderModdel!.value.data.shippingAddress.phone),
                  const SizedBox(
                    height: 30,
                  ),
                  // OrderDeliveryStatus(),
                  widget.fromAllOrders
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Map map = {
                                  "order_id": widget.id,
                                  "status": "reject"
                                };
                                controller.acceptRejectOrder(map, context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary:
                                    Colors.red, // Set your desired button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Adjust the radius as needed
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Text(
                                  "Reject",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: appColorWhite),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Map map = {
                                  "order_id": widget.id,
                                  "status": "accept"
                                };
                                controller.acceptRejectOrder(map, context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary:
                                    appPrimaryColor, // Set your desired button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Adjust the radius as needed
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: appColorWhite),
                                ),
                              ),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
      );
    });
  }
}
