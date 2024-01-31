import 'package:get/get.dart';
import 'package:work/Screens/HomeScreen/NewOrder/model/newOrderModel.dart';
import 'package:work/utilities/api_manager/apis.dart';
import 'package:work/utilities/api_manager/http_client.dart';

class AllOrderController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<NewOrderModel>? newOrderModel;
  RxList<DatumNewOrder> list = <DatumNewOrder>[].obs;

  getAllOrders(String orderStatus) async {
    isLoading = true.obs;
    update();

    try {
      final res =
          await HTTPClient.getNewOrderModel(APIs.allOrders + orderStatus);
      newOrderModel = res.obs;
      list = newOrderModel!.value.data.obs;
    } catch (stacktrace) {
      print(stacktrace.toString());
    }

    isLoading = false.obs;
    update();
  }
}
