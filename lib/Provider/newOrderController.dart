import 'package:get/get.dart';
import 'package:work/Screens/HomeScreen/NewOrder/model/newOrderModel.dart';
import 'package:work/utilities/api_manager/apis.dart';
import 'package:work/utilities/api_manager/http_client.dart';

class NewOrderController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<NewOrderModel>? newOrderModel;
  RxList<DatumNewOrder> list = <DatumNewOrder>[].obs;

  getNewOrders() async {
    isLoading = true.obs;
    update();

    print("API CALLLED");
    try {
      final res = await HTTPClient.getNewOrderModel(APIs.newOrders);
      newOrderModel = res.obs;
      list = newOrderModel!.value.data.obs;
    } catch (stacktrace) {
      print(stacktrace);
    }

    isLoading = false.obs;
    update();
  }

  acceptRejectOrder(dynamic params) async {
    isLoading = true.obs;
    update();

    final res = await HTTPClient.postRequest(APIs.orderAction, params);

    print(res.toString());
    isLoading = false.obs;
    update();
  }
}
