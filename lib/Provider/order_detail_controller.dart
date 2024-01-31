import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work/Models/orderDetailModelNew.dart';
import 'package:work/Models/order_detail.dart';
import 'package:work/Provider/current_order_controller.dart';
import 'package:work/Provider/newOrderController.dart';
import 'package:work/Screens/HomeScreen/home_screen.dart';
import 'package:work/utilities/utils.dart';

import '../utilities/api_manager/apis.dart';
import '../utilities/api_manager/http_client.dart';

class OrderDetailController extends GetxController {
  RxBool isLoading = false.obs;
  var priceList = <PriceDetail>[].obs;
  var responseProduct;
  RxString productId = ''.obs;
  RxString orderId = ''.obs;
  RxString productname = ''.obs;

  Rx<OrderDetailModelNew>? orderModdel;

  launchDialer(String phoneNumber) async {
    final Uri _phoneLaunchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(_phoneLaunchUri.toString())) {
      await launch(_phoneLaunchUri.toString());
    } else {
      throw 'Could not launch $_phoneLaunchUri';
    }
  }

  getAllOrders(String id) async {
    isLoading = true.obs;
    orderId.value = id;
    update();
    priceList.clear();
    final res = await HTTPClient.getOrderResponse(APIs.ordersDetail + id);
    final body = jsonDecode(res.body);
    isLoading = false.obs;
    update();

    var priceDetail = body['data']['price_detail'];
    responseProduct = body['data']['detail'][0];
    productId.value = responseProduct["id"].toString();
    productname.value = responseProduct["name"].toString();

    PriceDetail priceDetailData = PriceDetail(
        priceDetail['subtotal'],
        priceDetail['item_price'],
        priceDetail['discount'],
        priceDetail['delivery_fee'],
        priceDetail['tax'],
        priceDetail['total']);
    priceList.add(priceDetailData);
    //print(body);
  }

  rescheduleOrder(dynamic map, BuildContext context) async {
    final res = await HTTPClient.putRequest(APIs.scheduleDelivery, map);
    Utils.showFlushBarWithMessage(res["message"], context);
  }

  cancelOrder(dynamic map, BuildContext context) async {
    final res = await HTTPClient.putRequest(APIs.cancelOrder, map);
    Get.offAll(const HomeScreen());
  }

  getOrderDetails(String id) async {
    isLoading = true.obs;
    orderId.value = id;
    update();
    priceList.clear();
    final res = await HTTPClient.getNewOrderDetailModel(APIs.ordersDetail + id);
    orderModdel = res.obs;
    isLoading = false.obs;
    update();

    //print(body);
  }

  acceptRejectOrder(dynamic params, BuildContext context) async {
    isLoading = true.obs;
    update();

    final res = await HTTPClient.postRequest(APIs.orderAction, params);

    print(res.toString());
    Get.offAll(HomeScreen());

    // Get.back();
    // Utils.showFlushBarWithMessage(res["message"], Get.context!);
    // NewOrderController controller = NewOrderController();
    // controller.list.clear();
    // controller.getNewOrders();
    // controller.update();
    // CurrentOrderController controller2 = CurrentOrderController();
    // controller2.update();
    // controller2.initialize();

    // Get.offAll(const HomeScreen());
  }

  updateDeliveryStatus(dynamic params, BuildContext context) async {
    isLoading = true.obs;
    update();

    final res = await HTTPClient.putRequest(APIs.updatePaymentStatus, params);

    print(res.toString());

    Get.offAll(const HomeScreen());
  }
}
