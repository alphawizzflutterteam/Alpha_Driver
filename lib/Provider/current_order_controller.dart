import 'dart:convert';

import 'package:get/get.dart';
import 'package:work/utilities/shared_pref..dart';
import 'package:work/utilities/utils.dart';

import '../Models/order_model.dart';
import '../utilities/api_manager/apis.dart';
import '../utilities/api_manager/http_client.dart';

class CurrentOrderController extends GetxController {
  RxBool isLoading = false.obs;
  var orderDataList = <Datuo>[].obs;
  var alphaOrderDataList = <Datuo>[].obs;
  RxString allDeliverCount = "0".obs;
  RxString alphaDeliverCount = "0".obs;
  List tabs = <String>[].obs;
  RxBool isUpdate = false.obs;

  getAllOrders() async {
    isLoading = true.obs;

    update();
    orderDataList.clear();
    final res = await HTTPClient.getOrderResponse(APIs.orders);
    final body = jsonDecode(res.body);
    tabs = [body['tab']['all'], body['tab']['all']];
    for (var u in body['data']) {
      var shippingAddress = u['shipping_address'];
      ShipingModel address = ShipingModel(
          shippingAddress['id'],
          shippingAddress['customer_id'],
          shippingAddress['contact_person_name'],
          shippingAddress['address_type'],
          shippingAddress['address'],
          shippingAddress['address1'],
          shippingAddress['city'],
          shippingAddress['zip'],
          shippingAddress['phone'],
          shippingAddress['alt_phone'] ?? "",
          shippingAddress['created_at'],
          shippingAddress['updated_at'],
          shippingAddress['state'] ?? "",
          shippingAddress['country'],
          shippingAddress['latitude'] ?? "",
          shippingAddress['longitude'] ?? "",
          shippingAddress['is_billing']);
      print(address);

      Datuo data = Datuo(
          u['order_id'],
          u['total_delivery'],
          u['order_status'],
          u['payment_status'],
          u['expected_delivery_date'],
          u['customer_name'],
          address);
      orderDataList.add(data);
      isLoading = false.obs;

      update();
    }
    allDeliverCount.value = orderDataList.length.toString();
  }

  getAlphaOrders() async {
    isLoading = true.obs;

    update();
    alphaOrderDataList.clear();
    final res = await HTTPClient.getOrderResponse(APIs.alphaOrders);
    final body = jsonDecode(res.body);
    tabs = [body['tab']['all'], body['tab']['all']];
    for (var u in body['data']) {
      var shippingAddress = u['shipping_address'];
      ShipingModel address = ShipingModel(
          shippingAddress['id'],
          shippingAddress['customer_id'],
          shippingAddress['contact_person_name'],
          shippingAddress['address_type'],
          shippingAddress['address'],
          shippingAddress['address1'],
          shippingAddress['city'],
          shippingAddress['zip'],
          shippingAddress['phone'],
          shippingAddress['alt_phone'] ?? "",
          shippingAddress['created_at'],
          shippingAddress['updated_at'],
          shippingAddress['state'] ?? "",
          shippingAddress['country'],
          shippingAddress['latitude'] ?? "0.0",
          shippingAddress['longitude'] ?? "0.0",
          shippingAddress['is_billing']);
      print(address);

      Datuo data = Datuo(
          u['order_id'],
          u['total_delivery'],
          u['order_status'],
          u['payment_status'],
          u['expected_delivery_date'],
          u['customer_name'],
          address);
      alphaOrderDataList.add(data);
      isLoading = false.obs;

      update();
    }
    alphaDeliverCount.value = alphaOrderDataList.length.toString();
  }

  callApi() {
    getProfile();

    orderDataList.clear();
    alphaOrderDataList.clear();
    getAllOrders();
    getAlphaOrders();
  }

  initialize() {
    print("APIS Called on home page");
    orderDataList.clear();
    alphaOrderDataList.clear();
    getAllOrders();
    getAlphaOrders();
    getProfile();
  }

  getProfile() async {
    final res = await HTTPClient.getProfileResponse(APIs.profile);

    if (res.status == true) {
      SharedPref.shared.pref?.setString(PrefKeys.name, res.data[0].fName);

      SharedPref.shared.pref
          ?.setString(PrefKeys.userDetails, jsonEncode(res.data[0]));
    } else {
      Utils.showFlushBarWithMessage(
        'Something went wrong!!!',
        Get.context!,
      );
    }
  }
}
